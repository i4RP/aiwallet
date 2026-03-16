import SwiftUI

struct MainTabView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @StateObject private var portfolioViewModel = PortfolioViewModel()
    @StateObject private var chatViewModel = ChatViewModel()
    @StateObject private var marketViewModel = MarketViewModel()
    @State private var selectedTab: AppTab = .home

    var body: some View {
        ZStack(alignment: .bottom) {
            // Tab Content
            Group {
                switch selectedTab {
                case .home:
                    HomeView(
                        portfolioViewModel: portfolioViewModel,
                        authViewModel: authViewModel
                    )
                case .chat:
                    ChatView(chatViewModel: chatViewModel)
                case .market:
                    MarketView(marketViewModel: marketViewModel)
                case .settings:
                    SettingsView(authViewModel: authViewModel)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Custom Tab Bar
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
    }
}

// MARK: - Custom Tab Bar
struct CustomTabBar: View {
    @Binding var selectedTab: AppTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(AppTab.allCases, id: \.rawValue) { tab in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedTab = tab
                    }
                }, label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 20))
                            .foregroundColor(selectedTab == tab ? .pocketCyan : .pocketSecondaryText)

                        Text(tab.title)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(selectedTab == tab ? .pocketCyan : .pocketSecondaryText)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 10)
                    .padding(.bottom, 6)
                })
            }
        }
        .background(
            Rectangle()
                .fill(Color.pocketCardBackground)
                .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: -4)
                .ignoresSafeArea(edges: .bottom)
        )
    }
}

#Preview {
    MainTabView(authViewModel: AuthViewModel())
        .preferredColorScheme(.dark)
}
