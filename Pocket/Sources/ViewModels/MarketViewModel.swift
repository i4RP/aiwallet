import SwiftUI
import Combine

class MarketViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var marketItems: [MarketItem] = MarketItem.samples
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var selectedTimeframe: MarketTimeframe = .day

    enum MarketTimeframe: String, CaseIterable {
        case hour = "1H"
        case day = "1D"
        case week = "1W"
        case month = "1M"
        case year = "1Y"
    }

    // MARK: - Computed Properties
    var filteredItems: [MarketItem] {
        if searchText.isEmpty {
            return marketItems
        }
        return marketItems.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.symbol.localizedCaseInsensitiveContains(searchText)
        }
    }

    // MARK: - Actions
    func refreshMarket() {
        isLoading = true
        // TODO: Fetch real market data from API
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.isLoading = false
        }
    }

    func selectTimeframe(_ timeframe: MarketTimeframe) {
        selectedTimeframe = timeframe
        refreshMarket()
    }
}
