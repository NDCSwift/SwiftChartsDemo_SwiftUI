//
//  Project: ChartLab
//  File: ContentView.swift
//  Created by Noah Carpenter
//
//  📺 YouTube: Noah Does Coding
//  https://www.youtube.com/@NoahDoesCoding
//  Like and Subscribe for coding tutorials and fun! 💻✨
//  Dream Big. Code Bigger 🚀
//

import SwiftUI

/// The gallery: one scrolling page, one chart per group box.
struct ContentView: View {
    // Made once here and handed to every chart, so they all draw the same ninety days.
    private let payments = Payment.samples

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    GroupBox("Per client") {
                        ClientBarChart(payments: payments)
                    }
                    GroupBox("Daily earnings") {
                        EarningsTrendChart(payments: payments)
                    }
                    GroupBox("Weekly, by client") {
                        WeeklyClientChart(payments: payments)
                    }
                    GroupBox("Share of earnings") {
                        ClientDonutChart(payments: payments)
                    }
                }
                .padding()
            }
            .navigationTitle("ChartLab")
        }
    }
}

#Preview {
    ContentView()
}
