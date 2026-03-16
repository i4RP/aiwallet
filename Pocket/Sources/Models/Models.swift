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

// MARK: - Tab Definition
enum AppTab: Int, CaseIterable {
    case home = 0
    case chat = 1
    case market = 2
    case settings = 3

    var title: String {
        switch self {
        case .home: return "Home"
        case .chat: return "Chat"
        case .market: return "Market"
        case .settings: return "Settings"
        }
    }

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .chat: return "bubble.left.and.bubble.right.fill"
        case .market: return "chart.line.uptrend.xyaxis"
        case .settings: return "gearshape.fill"
        }
    }
}

// MARK: - Asset Model
struct Asset: Identifiable {
    let id = UUID()
    let name: String
    let symbol: String
    let iconName: String
    let balance: Double
    let value: Double
    let changePercent: Double
    let isUp: Bool
    let chainType: AssetChainType

    enum AssetChainType {
        case ethereum
        case solana
    }

    static let samples: [Asset] = [
        Asset(
            name: "Ethereum",
            symbol: "ETH",
            iconName: "ethereum",
            balance: 0.0185,
            value: 48.62,
            changePercent: 2.3,
            isUp: true,
            chainType: .ethereum
        ),
        Asset(
            name: "Solana",
            symbol: "SOL",
            iconName: "solana",
            balance: 0.082,
            value: 13.56,
            changePercent: 5.7,
            isUp: false,
            chainType: .solana
        )
    ]
}

// MARK: - Wallet Info
struct WalletInfo: Identifiable {
    let id = UUID()
    let address: String
    let chainType: WalletChainType
    let isEmbedded: Bool

    enum WalletChainType: String {
        case ethereum = "Ethereum"
        case solana = "Solana"
    }

    var shortAddress: String {
        guard address.count > 10 else { return address }
        return "\(address.prefix(6))...\(address.suffix(4))"
    }

    static let samples: [WalletInfo] = [
        WalletInfo(
            address: "0x1234...abcd",
            chainType: .ethereum,
            isEmbedded: true
        ),
        WalletInfo(
            address: "5FHn...9xKz",
            chainType: .solana,
            isEmbedded: true
        )
    ]
}

// MARK: - Agent Status
enum AgentStatus: String {
    case running = "Running"
    case paused = "Paused"
    case stopped = "Stopped"

    var color: Color {
        switch self {
        case .running: return .pocketGreen
        case .paused: return .agentStocks
        case .stopped: return .pocketRed
        }
    }
}

// MARK: - Agent Detail
struct AgentDetail: Identifiable {
    let id = UUID()
    let agent: Agent
    let status: AgentStatus
    let description: String
    let profitLoss: Double

    static let samples: [AgentDetail] = [
        AgentDetail(
            agent: Agent.samples[0],
            status: .running,
            description: "Analyzing stock markets and executing trades",
            profitLoss: 12.5
        ),
        AgentDetail(
            agent: Agent.samples[1],
            status: .running,
            description: "Predicting market trends with AI models",
            profitLoss: -3.2
        ),
        AgentDetail(
            agent: Agent.samples[2],
            status: .paused,
            description: "Managing DeFi positions and yield farming",
            profitLoss: 8.7
        )
    ]
}

// MARK: - Market Item
struct MarketItem: Identifiable {
    let id = UUID()
    let name: String
    let symbol: String
    let price: Double
    let changePercent: Double
    let isUp: Bool
    let chartPoints: [CGFloat]

    static let samples: [MarketItem] = [
        MarketItem(
            name: "Bitcoin",
            symbol: "BTC",
            price: 67_432.50,
            changePercent: 1.8,
            isUp: true,
            chartPoints: [0.4, 0.42, 0.45, 0.43, 0.48, 0.50, 0.52, 0.55, 0.53, 0.58]
        ),
        MarketItem(
            name: "Ethereum",
            symbol: "ETH",
            price: 2_628.30,
            changePercent: 2.3,
            isUp: true,
            chartPoints: [0.5, 0.48, 0.52, 0.55, 0.53, 0.58, 0.60, 0.57, 0.62, 0.65]
        ),
        MarketItem(
            name: "Solana",
            symbol: "SOL",
            price: 165.42,
            changePercent: 5.7,
            isUp: false,
            chartPoints: [0.7, 0.68, 0.65, 0.63, 0.60, 0.58, 0.55, 0.52, 0.50, 0.48]
        ),
        MarketItem(
            name: "Chainlink",
            symbol: "LINK",
            price: 14.85,
            changePercent: 3.1,
            isUp: true,
            chartPoints: [0.3, 0.35, 0.38, 0.40, 0.42, 0.45, 0.48, 0.50, 0.52, 0.55]
        ),
        MarketItem(
            name: "Uniswap",
            symbol: "UNI",
            price: 7.23,
            changePercent: 1.2,
            isUp: false,
            chartPoints: [0.6, 0.58, 0.55, 0.57, 0.54, 0.52, 0.50, 0.48, 0.50, 0.47]
        )
    ]
}
