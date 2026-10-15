# 📊 SwiftChartsDemo_SwiftUI

A SwiftUI project that teaches Swift Charts as a grammar, not a gallery: **every chart is one sentence — a mark, a value on x, a value on y.**

---

## 🤔 What this is

ChartLab draws one dataset, ninety days of freelance payments, as four charts in a scrolling gallery. Each chart is the same sentence with one word changed:

| Chart | The change | Where |
|---|---|---|
| Per client | `BarMark`: bars at the same x stack, so ninety payments become four totals | `ClientBarChart` |
| Daily earnings | `LineMark` + `AreaMark` composed, a dashed `RuleMark` average, a touch callout, and scrolling | `EarningsTrendChart` |
| Weekly, by client | `foregroundStyle(by:)`: stacked, coloured and given a legend without writing a colour | `WeeklyClientChart` |
| Share of earnings | `SectorMark` with an `innerRadius`: a donut | `ClientDonutChart` |

## ✅ Why you'd use it

- **One idea instead of seven chart types.** Change the mark and you change the chart; stack two marks and you've composed a new one.
- **Colours that agree.** `chartForegroundStyleScale(domain:)` gives each client the same colour in every chart.
- **A chart you can touch.** `chartXSelection` turns a drag into a date, with no gesture code, and the callout stays inside the chart at the edges.
- **Scrolling that opens on today.** `chartScrollableAxes`, `chartXVisibleDomain` and `chartScrollPosition(initialX:)`.
- **Heavily commented.** Every mark and modifier says why it's there.

## 📺 Watch on YouTube

[![Watch on YouTube](https://img.shields.io/badge/YouTube-Watch%20the%20Tutorial-red?style=for-the-badge&logo=youtube)](https://www.youtube.com/@NoahDoesCoding)

> This project was built for the [NoahDoesCoding YouTube channel](https://www.youtube.com/@NoahDoesCoding).

---

## 🚀 Getting Started

### 1. Clone

```bash
git clone https://github.com/NDCSwift/SwiftChartsDemo_SwiftUI.git
cd SwiftChartsDemo_SwiftUI
```

### 2. Open

```bash
open ChartLab.xcodeproj
```

### 3. Run on an iPhone simulator

Pick an **iPhone** simulator as the run destination and press **⌘R**. No Apple Developer account is needed for the Simulator.

### 4. Team (device only)

Select the project in the navigator → **Signing & Capabilities** → set your own **Team**. Not required for the Simulator.

### 5. Bundle ID (device only)

The default bundle identifier is `com.example.ChartLab`. Change it to something unique (e.g. `com.yourname.ChartLab`) if you plan to run on a device.

## 🛠️ Notes

Experiments worth trying, each a one-line change:

- **Change the mark.** In `ClientBarChart`, swap `BarMark` for `LineMark`. It compiles, and scribbles between four clients ninety times: a line only means something when x moves, like time.
- **Feed the donut raw data.** In `ClientDonutChart`, chart `payments` instead of `totals`. You get ninety slivers, because slices don't stack the way bars do.
- **Drop the colour domain.** Delete `.chartForegroundStyleScale(domain:)` from either chart, and the same client turns a different colour in the weekly bars and the donut.
- **More data.** Change the `90` in `Payment.samples` to `365` for a year.

Also:

- Once the daily chart scrolls, selecting takes a **press and hold** before you drag, the same as the Stocks app.
- For tens of thousands of points, look at the vectorized `BarPlot` and `LinePlot`. Same grammar, built for size.

## 📦 Requirements

- Xcode 27 (the project file uses Xcode 27's format; the Swift files themselves work with Xcode 15 or later)
- iOS 17.0+ deployment target (`chartXSelection`, `chartScrollableAxes` and `SectorMark` need iOS 17)
- Swift / SwiftUI / Swift Charts
