//
//  Project: ChartLab
//  File: WeeklyClientChart.swift
//  Created by Noah Carpenter
//
//  📺 YouTube: Noah Does Coding
//  https://www.youtube.com/@NoahDoesCoding
//  Like and Subscribe for coding tutorials and fun! 💻✨
//  Dream Big. Code Bigger 🚀
//

import SwiftUI
import Charts

/// Weekly bars, stacked and coloured by client, with no colour written by hand.
struct WeeklyClientChart: View {
    let payments: [Payment]

    var body: some View {
        Chart(payments) { payment in
            // unit: .weekOfYear bins seven days into each bar.
            BarMark(
                x: .value("Week", payment.date, unit: .weekOfYear),
                y: .value("Amount", payment.amount)
            )
            // Note the `by:`. We hand Charts a value, not a colour, and it picks a colour per
            // client, stacks them, and builds the legend.
            .foregroundStyle(by: .value("Client", payment.client))
        }
        // Replaces the automatic x-axis: one mark per month, each a grid line and a short month
        // name. Anything left out (like AxisTick) isn't drawn.
        .chartXAxis {
            AxisMarks(values: .stride(by: .month)) { _ in
                AxisGridLine()
                AxisValueLabel(format: .dateTime.month(.abbreviated))
            }
        }
        // Keeps the automatic y marks, formatted as dollars.
        .chartYAxis {
            AxisMarks(format: .currency(code: "USD").precision(.fractionLength(0)))
        }
        // Colours are handed out in the order Charts meets each value. A fixed domain, shared
        // with the donut, gives each client the same colour in both charts.
        .chartForegroundStyleScale(domain: Payment.clients)
        .frame(height: 220)
    }
}

#Preview {
    WeeklyClientChart(payments: Payment.samples)
}
