//
//  BarChartFormatter.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 1/18/22.
//

import Foundation
import Charts

class BarCharValueFormatter: NSObject, ValueFormatter{
    public func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        let correctValue = Int(value)
        return String(correctValue)
    }
}
