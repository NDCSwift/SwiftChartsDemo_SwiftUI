//
//  Project: ChartLab
//  File: ClientBarChart.swift
//  Created by Noah Carpenter
//
//  📺 YouTube: Noah Does Coding
//  https://www.youtube.com/@NoahDoesCoding
//  Like and Subscribe for coding tutorials and fun! 💻✨
//  Dream Big. Code Bigger 🚀
//

import SwiftUI
import Charts // Charts is its own framework, so every file that draws a chart imports it.

/// Every chart is one sentence: a mark, a value on x, a value on y.
struct ClientBarChart: View {
    let payments: [Payment]

    var body: some View {
        Chart(payments) { payment in
            // The `.value` labels aren't decoration: they name the axes and are what VoiceOver reads.
            //
            // Bars at the same x stack on top of each other, so ninety payments become four bars,
            // each as tall as that client's total. Look closely and you'll see the seams.
            //
            // Experiment: change BarMark to LineMark. It compiles, and it scribbles between the
            // four clients ninety times. A line only means something when x moves, like time.
            BarMark(
                x: .value("Client", payment.client),
                y: .value("Amount", payment.amount)
            )
        }
        .frame(height: 220)
    }
}

#Preview {
    ClientBarChart(payments: Payment.samples)
}
