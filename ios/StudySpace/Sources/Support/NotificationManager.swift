import UserNotifications

final class NotificationManager {
    static let shared = NotificationManager()
    private let timerNotificationId = "studyspace.timer.finished"

    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, _ in }
    }

    func scheduleTimerFinished(in seconds: TimeInterval) {
        cancelTimerFinished()
        guard seconds > 0 else { return }

        let content = UNMutableNotificationContent()
        content.title = "StudySpace"
        content.body = "Your timer is up!"
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(identifier: timerNotificationId, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

    func cancelTimerFinished() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [timerNotificationId])
    }
}
