//
//  Project: ChartLab
//  File: Payment.swift
//  Created by Noah Carpenter
//
//  📺 YouTube: Noah Does Coding
//  https://www.youtube.com/@NoahDoesCoding
//  Like and Subscribe for coding tutorials and fun! 💻✨
//  Dream Big. Code Bigger 🚀
//

import Foundation

/// One payment from one client on one day. Every chart in the app draws these same rows.
///
/// `Identifiable` because a chart, like a `List`, needs to tell one row from the next.
struct Payment: Identifiable {
    let id = UUID()
    let date: Date
    let client: String
    let amount: Double
}

extension Payment {
    // Four clients and what each charges per hour. The rates are different on purpose, so the
    // charts have something to show.
    static let hourlyRates = [
        "Northwind": 95.0,
        "Bluebird": 60.0,
        "Juniper": 140.0,
        "Atlas": 45.0,
    ]

    // A dictionary has no order of its own, so sorting the names gives one fixed list. Charts that
    // share this list as their colour domain give each client the same colour everywhere.
    static let clients = hourlyRates.keys.sorted()

    // Ninety days of sample data, one payment per day. Change the 90 to 365 for a year.
    //
    // Both force unwraps are safe: a four-entry dictionary always has a random element, and going
    // back a few days on the calendar always lands on a date. `static let` means it's made once,
    // so every chart in a run draws the same ninety days.
    static let samples: [Payment] = (0..<90).map { day in
        let (client, rate) = hourlyRates.randomElement()!
        return Payment(
            date: Calendar.current.date(byAdding: .day, value: -day, to: .now)!,
            client: client,
            amount: rate * Double.random(in: 1...4)
        )
    }
}
