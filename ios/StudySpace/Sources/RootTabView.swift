import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            CalendarScreen()
                .tabItem { Label("Calendar", systemImage: "calendar") }

            TimerScreen()
                .tabItem { Label("Timer", systemImage: "timer") }
        }
    }
}
