import SwiftUI

@main
struct PocketApp: App {
    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .preferredColorScheme(.dark)
        }
    }
}
