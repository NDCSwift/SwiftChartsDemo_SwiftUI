//
//  Project: ChartLab
//  File: ClientDonutChart.swift
//  Created by Noah Carpenter
//
//  📺 YouTube: Noah Does Coding
//  https://www.youtube.com/@NoahDoesCoding
//  Like and Subscribe for coding tutorials and fun! 💻✨
//  Dream Big. Code Bigger 🚀
//

import SwiftUI
import Charts

/// Each client's share of the ninety days, as a donut.
struct ClientDonutChart: View {
    let payments: [Payment]

    // A sector chart wants one row per slice. Fed the raw payments, it draws ninety slivers:
    // bars at the same x stack, but slices just sit side by side. So group first.
    //
    // Each row is a labelled tuple, which is plenty for a chart. `$0`/`$1` are shorthand for the
    // closure's first and second argument. Biggest first, so the slices go largest to smallest.
    private var totals: [(client: String, total: Double)] {
        Dictionary(grouping: payments, by: \.client)
            .map { (client: $0.key, total: $0.value.map(\.amount).reduce(0, +)) }
            .sorted { $0.total > $1.total }
    }

    var body: some View {
        // A tuple can't be Identifiable, so `id` says the client name tells rows apart.
        Chart(totals, id: \.client) { entry in
            // No x or y: an angle. The bigger the value, the wider the slice.
            SectorMark(
                angle: .value("Amount", entry.total),
                innerRadius: .ratio(0.6), // cuts the middle out, which makes it a donut
                angularInset: 2 // a two-point gap between slices
            )
            .cornerRadius(4)
            .foregroundStyle(by: .value("Client", entry.client))
        }
        // The same domain as the weekly chart, so the same client gets the same colour.
        .chartForegroundStyleScale(domain: Payment.clients)
        .frame(height: 220)
    }
}

#Preview {
    ClientDonutChart(payments: Payment.samples)
}
