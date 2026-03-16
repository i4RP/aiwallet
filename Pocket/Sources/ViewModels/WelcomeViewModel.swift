import SwiftUI
import Combine

class WelcomeViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var currentCardIndex: Int = 0
    @Published var showCardContent: Bool = false
    @Published var autoScrollEnabled: Bool = true
    
    // MARK: - Data
    let portfolio = PortfolioData.sample
    let agents = Agent.samples
    let stock = StockData.tslaSample
    
    let chatMessages: [ChatMessage] = [
        ChatMessage(
            sender: .agent("Stocks Trader"),
            text: "TSLA hit my entry range."
        ),
        ChatMessage(
            sender: .user,
            text: "Nice. What did you do?"
        ),
        ChatMessage(
            sender: .agent("Stocks Trader"),
            text: "Executed a buy",
            tradeBadge: TradeBadge(action: .bought, amount: 24.3, ticker: "TSLA")
        )
    ]
    
    // MARK: - Timer
    private var timer: AnyCancellable?
    private let autoScrollInterval: TimeInterval = 4.0
    
    init() {
        startAutoScroll()
    }
    
    deinit {
        stopAutoScroll()
    }
    
    // MARK: - Auto Scroll
    func startAutoScroll() {
        timer = Timer.publish(every: autoScrollInterval, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self, self.autoScrollEnabled else { return }
                withAnimation(.easeInOut(duration: 0.6)) {
                    self.currentCardIndex = (self.currentCardIndex + 1) % CarouselCardType.allCases.count
                }
                self.animateCardContent()
            }
    }
    
    func stopAutoScroll() {
        timer?.cancel()
        timer = nil
    }
    
    func animateCardContent() {
        showCardContent = false
        withAnimation(.easeIn(duration: 0.4).delay(0.3)) {
            showCardContent = true
        }
    }
    
    func selectCard(_ index: Int) {
        autoScrollEnabled = false
        withAnimation(.easeInOut(duration: 0.5)) {
            currentCardIndex = index
        }
        animateCardContent()
        
        // Resume auto-scroll after 8 seconds of inactivity
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) { [weak self] in
            self?.autoScrollEnabled = true
        }
    }
}
