import SwiftUI

struct StockChartCardView: View {
    let stock: StockData
    let isVisible: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Red Header Bar
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.pocketRed)
                .frame(height: 36)
                .padding(.horizontal, -20)
                .padding(.top, -24)
                .clipShape(
                    RoundedCorner(radius: 20, corners: [.topLeft, .topRight])
                )
            
            // Stock Info
            HStack(spacing: 12) {
                // Ticker Icon
                Circle()
                    .fill(Color.pocketRed)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text("T")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                    )
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(stock.ticker)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.pocketSecondaryText)
                    
                    Text("$\(String(format: "%.1f", stock.price))")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .opacity(isVisible ? 1 : 0)
            .animation(.easeIn(duration: 0.4).delay(0.2), value: isVisible)
            
            // Mini Chart
            MiniChartView(
                dataPoints: stock.chartPoints,
                lineColor: stock.color,
                animated: isVisible
            )
            .frame(height: 60)
            .opacity(isVisible ? 1 : 0)
            .animation(.easeIn(duration: 0.4).delay(0.4), value: isVisible)
            
            // Stocks Agent Status
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    Circle()
                        .fill(Color.agentStocks)
                        .frame(width: 24, height: 24)
                    
                    Text("Stocks Agent")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Text("Running")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.pocketSecondaryText)
                }
                
                Text("Continuously analyzing the market and\nmanaging your position.")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.pocketSecondaryText)
                    .lineSpacing(3)
                    .padding(.leading, 32)
            }
            .opacity(isVisible ? 1 : 0)
            .animation(.easeIn(duration: 0.4).delay(0.6), value: isVisible)
            
            Spacer(minLength: 0)
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 20)
    }
}

#Preview {
    StockChartCardView(
        stock: .tslaSample,
        isVisible: true
    )
    .background(Color.pocketCardBackground)
    .cornerRadius(20)
    .padding()
    .background(Color.black)
}
