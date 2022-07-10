//
//  ChartVIew.swift
//  StockMarket
//
//  Created by Daichi Morihara on 2022/06/27.
//

import SwiftUI

struct ChartVIew: View {
    
    let data: [Double]
    let maxY: Double
    let minY: Double
    let priceChange: Double
    let lineColor: Color
    var yAxis: Double {
        maxY - minY
    }
    
    init(data: [Double]) {
        self.data = data
        self.maxY = data.max() ?? 0
        self.minY = data.min() ?? 0
        self.priceChange = (data.first ?? 0) - (data.last ?? 0)
        self.lineColor = priceChange < 0 ? Color.theme.red : Color.theme.green
    }
        
    var body: some View {
        VStack {
            chartView
                .frame(height: 200)
                .background(chartBackground)
                .overlay(chartYAxis, alignment: .leading)
        }
        .font(.caption)
        .foregroundColor(.theme.secondary)
        
    }
}

struct ChartVIew_Previews: PreviewProvider {
    static var previews: some View {
        ChartVIew(data: dev.data)
    }
}

extension ChartVIew {
    private var chartView: some View {
        GeometryReader { geo in
            Path { path in
                for idx in data.indices {
                    let x = geo.size.width * CGFloat(data.count - 1 - idx) / CGFloat(data.count - 1)
                    let y = geo.size.height * CGFloat(1 - (data[idx] - minY) / yAxis)
                    if idx == 0 {
                        path.move(to: CGPoint(x: x, y: y))
                    }
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
        }
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAxis: some View {
        VStack {
            Text(maxY.stringWith2Decimals())
            Spacer()
            let price = (maxY + minY) / 2
            Text(price.stringWith2Decimals())
            Spacer()
            Text(minY.stringWith2Decimals())
        }
    }
}
