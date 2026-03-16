import SwiftUI

@main
struct PocketApp: App {
    @StateObject private var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            Group {
                switch authViewModel.authState {
                case .unauthenticated, .authenticating:
                    WelcomeView(authViewModel: authViewModel)
                case .authenticated:
                    MainTabView(authViewModel: authViewModel)
                }
            }
            .animation(.easeInOut(duration: 0.4), value: authViewModel.authState == .authenticated)
            .preferredColorScheme(.dark)
        }
    }
}
