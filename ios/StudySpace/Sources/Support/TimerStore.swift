import Foundation
import Combine

// Mirrors the Android app's DataHelper: timer state (start time + duration)
// is persisted so the countdown survives the app being backgrounded and
// relaunched, computed from elapsed wall-clock time rather than a running
// in-process counter.
final class TimerStore: ObservableObject {
    @Published private(set) var remainingSeconds: Int = 0
    @Published private(set) var isRunning: Bool = false

    private let defaults = UserDefaults.standard
    private var ticker: AnyCancellable?

    private var startTime: Date? {
        get { defaults.object(forKey: "timer.startTime") as? Date }
        set { defaults.set(newValue, forKey: "timer.startTime") }
    }

    private var durationSeconds: Int {
        get { defaults.integer(forKey: "timer.durationSeconds") }
        set { defaults.set(newValue, forKey: "timer.durationSeconds") }
    }

    init() {
        isRunning = defaults.bool(forKey: "timer.isRunning")
        ticker = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in self?.tick() }
        tick()
    }

    func setPresetDuration(seconds: Int) {
        reset()
        durationSeconds = seconds
        remainingSeconds = seconds
    }

    func start(durationSeconds seconds: Int) {
        durationSeconds = seconds
        startTime = .now
        isRunning = true
        defaults.set(true, forKey: "timer.isRunning")
        NotificationManager.shared.scheduleTimerFinished(in: TimeInterval(seconds))
        tick()
    }

    func stop() {
        isRunning = false
        defaults.set(false, forKey: "timer.isRunning")
        NotificationManager.shared.cancelTimerFinished()
    }

    func reset() {
        startTime = nil
        durationSeconds = 0
        remainingSeconds = 0
        isRunning = false
        defaults.set(false, forKey: "timer.isRunning")
        NotificationManager.shared.cancelTimerFinished()
    }

    func tick() {
        guard isRunning, let startTime else { return }
        let elapsed = Int(Date.now.timeIntervalSince(startTime))
        remainingSeconds = max(0, durationSeconds - elapsed)
        if remainingSeconds == 0 {
            isRunning = false
            defaults.set(false, forKey: "timer.isRunning")
        }
    }

    var formattedRemaining: String {
        let h = remainingSeconds / 3600
        let m = (remainingSeconds % 3600) / 60
        let s = remainingSeconds % 60
        return String(format: "%02d:%02d:%02d", h, m, s)
    }
}
