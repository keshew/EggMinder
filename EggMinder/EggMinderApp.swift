import SwiftUI

@main
struct EggMinderApp: App {
    @StateObject var notificationManager = NotificationManager()
    var body: some Scene {
        WindowGroup {
            if UserDefaultsManager().checkLogin() {
                EggTabBarView()
            } else {
                EggOboardingView()
                    .onAppear {
                        notificationManager.requestPermission()
                    }
            }
        }
        
    }
}
