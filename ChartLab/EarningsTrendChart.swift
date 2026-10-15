//
//  Project: ChartLab
//  File: EarningsTrendChart.swift
//  Created by Noah Carpenter
//
//  📺 YouTube: Noah Does Coding
//  https://www.youtube.com/@NoahDoesCoding
//  Like and Subscribe for coding tutorials and fun! 💻✨
//  Dream Big. Code Bigger 🚀
//

import SwiftUI
import Charts

/// Daily earnings: a line and an area composed, an average rule, a touch callout, and scrolling.
struct EarningsTrendChart: View {
    let payments: [Payment]

    // The date under the finger, written by chartXSelection. nil when nothing is touched.
    @State private var selectedDate: Date?

    // Adds every amount up from zero, then divides. Double(...) because Swift won't divide a
    // Double by an Int.
    private var average: Double {
        payments.map(\.amount).reduce(0, +) / Double(payments.count)
    }

    // The selection is a date, not a payment, so find the payment on that day. Equality would
    // almost never match: the finger lands at some exact second. `first` is fine because the
    // sample data has one payment a day; with several, you'd sum the day instead.
    private var selectedPayment: Payment? {
        guard let selectedDate else { return nil }
        return payments.first { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
    }

    var body: some View {
        // The ForEach form (instead of Chart(payments)) leaves room for marks that aren't one per
        // payment, like the average line below.
        Chart {
            ForEach(payments) { payment in
                // unit: .day bins the dates by day and labels the axis with dates, not times.
                LineMark(
                    x: .value("Day", payment.date, unit: .day),
                    y: .value("Amount", payment.amount)
                )
                // Curves through every point. Smooths the line without moving any data.
                .interpolationMethod(.catmullRom)

                // A second mark saying the same sentence. Two marks, one chart: nobody wrote an
                // "area chart" type. Same interpolation, or the fill and the line disagree.
                AreaMark(
                    x: .value("Day", payment.date, unit: .day),
                    y: .value("Amount", payment.amount)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(.blue.opacity(0.15))
            }

            // Outside the ForEach, so it's drawn once. A RuleMark with only a y value is a line
            // straight across the chart. Orange and dashed so nobody mistakes it for data.
            RuleMark(y: .value("Average", average))
                .foregroundStyle(.orange)
                .lineStyle(StrokeStyle(lineWidth: 1, dash: [5, 3]))
                // Pins any SwiftUI view to a mark. Trailing, so it sits by the newest days once
                // the chart scrolls.
                .annotation(position: .top, alignment: .trailing) {
                    Text("Average \(average, format: .currency(code: "USD").precision(.fractionLength(0)))")
                        .font(.caption)
                        .foregroundStyle(.orange)
                }

            if let selectedPayment {
                // The same RuleMark, given an x instead of a y: a vertical line at that day.
                RuleMark(x: .value("Day", selectedPayment.date, unit: .day))
                    .foregroundStyle(.secondary)
                    // overflowResolution keeps the callout inside the chart near the edges,
                    // instead of hanging off the side or into the heading above.
                    .annotation(
                        position: .top,
                        overflowResolution: .init(x: .fit(to: .chart), y: .fit(to: .chart))
                    ) {
                        VStack {
                            Text(selectedPayment.client)
                                .font(.caption.bold())
                            Text(selectedPayment.amount, format: .currency(code: "USD"))
                                .font(.caption)
                        }
                        .padding(6)
                        .background(.background.secondary, in: .rect(cornerRadius: 8))
                    }

                // A dot on the line at that day, big enough to see under a thumb.
                PointMark(
                    x: .value("Day", selectedPayment.date, unit: .day),
                    y: .value("Amount", selectedPayment.amount)
                )
                .symbolSize(80)
            }
        }
        // Turns a drag into a Date on the x-axis and writes it into the binding. No gesture code.
        .chartXSelection(value: $selectedDate)
        // Scroll horizontally, a month on screen at a time. A date axis measures in seconds.
        // Once the chart scrolls, selecting takes a press and hold first, like the Stocks app.
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 3600 * 24 * 30)
        // A scrolling chart starts at the beginning of its data. Starting at "now" settles it on
        // the latest thirty days instead.
        .chartScrollPosition(initialX: Date.now)
        .frame(height: 220)
    }
}

#Preview {
    EarningsTrendChart(payments: Payment.samples)
}
