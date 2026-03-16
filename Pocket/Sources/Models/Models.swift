import SwiftUI

// MARK: - Agent Model
struct Agent: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
    let icon: String
    
    static let samples: [Agent] = [
        Agent(name: "Stocks", color: .agentStocks, icon: "chart.line.uptrend.xyaxis"),
        Agent(name: "Predictions", color: .agentPredictions, icon: "brain"),
        Agent(name: "Defi", color: .agentDefi, icon: "bitcoinsign.circle")
    ]
}

// MARK: - Chat Message Model
struct ChatMessage: Identifiable {
    let id = UUID()
    let sender: MessageSender
    let text: String
    let time: String
    let tradeBadge: TradeBadge?
    
    init(sender: MessageSender, text: String, time: String = "3:45 pm", tradeBadge: TradeBadge? = nil) {
        self.sender = sender
        self.text = text
        self.time = time
        self.tradeBadge = tradeBadge
    }
}

enum MessageSender {
    case agent(String)
    case user
}

// MARK: - Trade Badge Model
struct TradeBadge: Identifiable {
    let id = UUID()
    let action: TradeAction
    let amount: Double
    let ticker: String
    
    var displayText: String {
        "\(action.rawValue) \(String(format: "%.1f", amount)) \(ticker)"
    }
}

enum TradeAction: String {
    case bought = "Bought"
    case sold = "Sold"
}

// MARK: - Stock Data Model
struct StockData: Identifiable {
    let id = UUID()
    let ticker: String
    let price: Double
    let chartPoints: [CGFloat]
    let color: Color
    
    static let tslaSample = StockData(
        ticker: "TSLA",
        price: 569.8,
        chartPoints: [0.5, 0.45, 0.55, 0.40, 0.48, 0.42, 0.50, 0.45, 0.52, 0.48, 0.55, 0.50, 0.58, 0.62, 0.65, 0.70],
        color: .pocketRed
    )
}

// MARK: - Carousel Card Type
enum CarouselCardType: Int, CaseIterable {
    case portfolio = 0
    case chat = 1
    case stockChart = 2
}

// MARK: - Portfolio Data
struct PortfolioData {
    let balance: Double
    let changePercent: Double
    let isDown: Bool
    
    static let sample = PortfolioData(
        balance: 62.18,
        changePercent: 6.1,
        isDown: true
    )
}
