import SwiftUI

struct MiniChartView: View {
    let dataPoints: [CGFloat]
    let lineColor: Color
    let animated: Bool
    
    @State private var animationProgress: CGFloat = 0
    
    init(dataPoints: [CGFloat], lineColor: Color = .pocketRed, animated: Bool = true) {
        self.dataPoints = dataPoints
        self.lineColor = lineColor
        self.animated = animated
    }
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let minVal = dataPoints.min() ?? 0
            let maxVal = dataPoints.max() ?? 1
            let range = maxVal - minVal
            
            ZStack {
                // Line Chart
                Path { path in
                    guard dataPoints.count > 1 else { return }
                    
                    for (index, point) in dataPoints.enumerated() {
                        let x = width * CGFloat(index) / CGFloat(dataPoints.count - 1)
                        let normalizedY = range > 0 ? (point - minVal) / range : 0.5
                        let y = height * (1 - normalizedY)
                        
                        if index == 0 {
                            path.move(to: CGPoint(x: x, y: y))
                        } else {
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    }
                }
                .trim(from: 0, to: animated ? animationProgress : 1)
                .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                
                // End Point Dot
                if animationProgress >= 1 || !animated {
                    let lastPoint = dataPoints.last ?? 0
                    let lastX = width
                    let normalizedY = range > 0 ? (lastPoint - minVal) / range : 0.5
                    let lastY = height * (1 - normalizedY)
                    
                    Circle()
                        .fill(lineColor)
                        .frame(width: 6, height: 6)
                        .position(x: lastX, y: lastY)
                }
            }
        }
        .onAppear {
            if animated {
                withAnimation(.easeInOut(duration: 1.5)) {
                    animationProgress = 1
                }
            }
        }
    }
}

#Preview {
    MiniChartView(
        dataPoints: StockData.tslaSample.chartPoints,
        lineColor: .pocketRed
    )
    .frame(height: 60)
    .padding()
    .background(Color.black)
}
