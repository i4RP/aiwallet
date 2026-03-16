import SwiftUI

struct MarketView: View {
    @ObservedObject var marketViewModel: MarketViewModel

    var body: some View {
        VStack(spacing: 0) {
            // Header
            MarketHeaderView(searchText: $marketViewModel.searchText)

            // Timeframe Selector
            TimeframeSelectorView(
                selectedTimeframe: marketViewModel.selectedTimeframe,
                onSelect: { marketViewModel.selectTimeframe($0) }
            )

            // Market List
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(marketViewModel.filteredItems) { item in
                        MarketRowView(item: item)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 80)
            }
        }
        .background(Color.pocketBackground.ignoresSafeArea())
    }
}

// MARK: - Market Header
struct MarketHeaderView: View {
    @Binding var searchText: String

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Market")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)

                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)

            // Search Bar
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 15))
                    .foregroundColor(.pocketSecondaryText)

                TextField("Search tokens...", text: $searchText)
                    .font(.system(size: 15))
                    .foregroundColor(.white)

                if !searchText.isEmpty {
                    Button(action: { searchText = "" }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 15))
                            .foregroundColor(.pocketSecondaryText)
                    })
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.pocketCardBackground)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(Color.pocketCardBorder, lineWidth: 1)
                    )
            )
            .padding(.horizontal, 20)
        }
    }
}

// MARK: - Timeframe Selector
struct TimeframeSelectorView: View {
    let selectedTimeframe: MarketViewModel.MarketTimeframe
    let onSelect: (MarketViewModel.MarketTimeframe) -> Void

    var body: some View {
        HStack(spacing: 6) {
            ForEach(MarketViewModel.MarketTimeframe.allCases, id: \.self) { timeframe in
                Button(action: { onSelect(timeframe) }, label: {
                    Text(timeframe.rawValue)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(selectedTimeframe == timeframe ? .white : .pocketSecondaryText)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 6)
                        .background(
                            Capsule()
                                .fill(selectedTimeframe == timeframe ? Color.pocketCyan.opacity(0.2) : Color.clear)
                        )
                })
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
}

// MARK: - Market Row
struct MarketRowView: View {
    let item: MarketItem

    var body: some View {
        HStack(spacing: 12) {
            // Token Icon
            Circle()
                .fill(tokenColor(for: item.symbol))
                .frame(width: 40, height: 40)
                .overlay(
                    Text(String(item.symbol.prefix(1)))
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                )

            // Name & Symbol
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)

                Text(item.symbol)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.pocketSecondaryText)
            }

            Spacer()

            // Mini Chart
            MiniChartView(
                dataPoints: item.chartPoints,
                lineColor: item.isUp ? .pocketGreen : .pocketRed,
                animated: false
            )
            .frame(width: 60, height: 30)

            // Price & Change
            VStack(alignment: .trailing, spacing: 4) {
                Text(formatPrice(item.price))
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)

                HStack(spacing: 3) {
                    Image(systemName: item.isUp ? "arrow.up.right" : "arrow.down.right")
                        .font(.system(size: 10, weight: .semibold))

                    Text("\(String(format: "%.1f", item.changePercent))%")
                        .font(.system(size: 12, weight: .medium))
                }
                .foregroundColor(item.isUp ? .pocketGreen : .pocketRed)
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.pocketCardBackground)
        )
    }

    private func tokenColor(for symbol: String) -> Color {
        switch symbol {
        case "BTC": return Color(red: 0.96, green: 0.62, blue: 0.13)
        case "ETH": return Color.agentPredictions
        case "SOL": return Color.agentDefi
        case "LINK": return Color(red: 0.22, green: 0.42, blue: 0.92)
        default: return Color.pocketSecondaryText
        }
    }

    private func formatPrice(_ price: Double) -> String {
        if price >= 1000 {
            return "$\(String(format: "%.0f", price))"
        } else if price >= 1 {
            return "$\(String(format: "%.2f", price))"
        } else {
            return "$\(String(format: "%.4f", price))"
        }
    }
}

#Preview {
    MarketView(marketViewModel: MarketViewModel())
        .preferredColorScheme(.dark)
}
