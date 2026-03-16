import SwiftUI

struct CarouselCardContainer: View {
    @ObservedObject var viewModel: WelcomeViewModel
    
    var body: some View {
        TabView(selection: $viewModel.currentCardIndex) {
            // Card 1: Portfolio Overview
            cardWrapper(index: 0) {
                PortfolioCardView(
                    portfolio: viewModel.portfolio,
                    agents: viewModel.agents,
                    isVisible: viewModel.currentCardIndex == 0
                )
            }
            
            // Card 2: Chat with Agent
            cardWrapper(index: 1) {
                ChatCardView(
                    messages: viewModel.chatMessages,
                    isVisible: viewModel.currentCardIndex == 1
                )
            }
            
            // Card 3: Stock Chart
            cardWrapper(index: 2) {
                StockChartCardView(
                    stock: viewModel.stock,
                    isVisible: viewModel.currentCardIndex == 2
                )
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 380)
        .onChange(of: viewModel.currentCardIndex) { _ in
            viewModel.animateCardContent()
        }
    }
    
    @ViewBuilder
    private func cardWrapper<Content: View>(index: Int, @ViewBuilder content: () -> Content) -> some View {
        content()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.pocketCardBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.pocketCardBorder, lineWidth: 1)
                    )
            )
            .padding(.horizontal, 24)
            .tag(index)
    }
}

#Preview {
    CarouselCardContainer(viewModel: WelcomeViewModel())
        .background(Color.black)
}
