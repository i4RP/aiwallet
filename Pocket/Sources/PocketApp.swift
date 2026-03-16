import SwiftUI

@main
struct PocketApp: App {
    @StateObject private var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            WelcomeView(authViewModel: authViewModel)
                .preferredColorScheme(.dark)
        }
    }
}
