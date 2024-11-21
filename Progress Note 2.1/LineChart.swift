//
//  LineChart.swift
//  Progress Note 2.1
//
//  Created by Purin Prateepmanowong on 11/10/24.
//

import SwiftUI
import Charts

struct LineChart: View {
    var dataPoints: [(Date, Double)]

    var body: some View {
        Chart {
            ForEach(dataPoints, id: \.0) { date, value in
                LineMark(
                    x: .value("Date", date),
                    y: .value("Value", value)
                )
            }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { value in
                AxisValueLabel(format: .dateTime.month().day())
            }
        }
        .chartYAxis {
            AxisMarks { value in
                AxisValueLabel()
            }
        }
    }
}
