//
//  ConversionChartHistory.swift
//  cowrywise-take-home
//
//  Created by Ademola Fadumo on 18/07/2023.
//

import Foundation
import Charts
import SwiftUI

struct ConversionChartHistory: View {
    
    var data: [CurrencyConversionDTO]
    
    var body: some View {
        Chart(data) { convertedValue in
            AreaMark(
                x: .value("Month", convertedValue.createdAt),
                yStart: .value("Dollar", convertedValue.to.first?.mid ?? 0),
                yEnd: .value("minValue", 0)
            ).interpolationMethod(.catmullRom)
        }
        .foregroundStyle(.linearGradient(colors: [.white.opacity(0.5), Color(Colors.primary)], startPoint: .top, endPoint: .bottom))
        .chartYAxis(.hidden)
    }
}
