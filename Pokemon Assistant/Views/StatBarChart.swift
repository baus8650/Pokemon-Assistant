//
//  StatBarChart.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 1/18/22.
//

import Foundation
import Charts

class StatBarChart {
    
    let barChart: HorizontalBarChartView!
    let barChartData: BarChartData!
    
    
    init(for chart: HorizontalBarChartView, with dataSet: BarChartDataSet) {
        barChartData = BarChartData(dataSet: dataSet)
        barChart = chart
        setUpBarChart()
    }
    
    let valueFormatter = BarCharValueFormatter()
    let axisFormatter = BarChartXAxisFormatter()
    func setUpBarChart() {
        barChart?.leftAxis.drawAxisLineEnabled = false
        barChart?.rightAxis.drawAxisLineEnabled = false
        barChart?.legend.enabled = false
        barChart?.xAxis.valueFormatter = axisFormatter
        barChart?.rightAxis.axisMinimum = 0
        barChart?.rightAxis.axisMaximum = 280
        barChart?.leftAxis.axisMinimum = 0
        barChart?.leftAxis.axisMaximum = 280
        barChart?.xAxis.drawGridLinesEnabled = false
        barChart?.rightAxis.drawGridLinesEnabled = false
        barChart?.leftAxis.drawGridLinesEnabled = false
        barChart?.leftAxis.drawLabelsEnabled = false
        barChart?.rightAxis.drawLabelsEnabled = false
        barChart?.drawValueAboveBarEnabled = true
        barChart?.xAxis.labelPosition = .bottom
        barChart?.animate(yAxisDuration: 0.4)
        barChart?.animate(xAxisDuration: 0.4)
        barChart?.data = barChartData
        barChart?.data?.setValueFormatter(valueFormatter)
    }
    
}
