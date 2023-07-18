//
//  ConversionChartHistory.swift
//  cowrywise-take-home
//
//  Created by Ademola Fadumo on 18/07/2023.
//

import Foundation
import Charts
import SwiftUI

struct SavingsModel: Identifiable {
    let id = UUID()
    let amount: Double
    let createAt: Date
}

struct ConversionChartHistory: View {
    let list = [
        SavingsModel(amount: 24, createAt: dateFormatter.date(from: "23/11/2022") ?? Date()),
        SavingsModel(amount: 20, createAt: dateFormatter.date(from: "24/11/2022") ?? Date()),
        SavingsModel(amount: 35, createAt: dateFormatter.date(from: "25/11/2022") ?? Date()),
        SavingsModel(amount: 15, createAt: dateFormatter.date(from: "26/11/2022") ?? Date()),
    ]
    
    func formatDate(_ date: Date) -> String {
        let cal = Calendar.current
        let dateComponent = cal.dateComponents([.day, .month], from: date)
        guard let day = dateComponent.day, let month = dateComponent.month else {
            return "-"
        }
        
        return "\(day)/\(month)"
    }
    
    static var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yy"
        return df
    }()
    
    var body: some View {
        Chart(list) { savingsModel in
            AreaMark(
                x: .value("Month", savingsModel.createAt),
                yStart: .value("Dollar", savingsModel.amount),
                yEnd: .value("minValue", 0)
            ).interpolationMethod(.catmullRom)
        }
        .foregroundStyle(.linearGradient(colors: [.white.opacity(0.5), Color(Colors.primary)], startPoint: .top, endPoint: .bottom))
        .chartYAxis(.hidden)
    }
}
