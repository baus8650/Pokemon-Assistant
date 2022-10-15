//
//  BarChartXAxisFormatter.swift
//  Pokemon Assistant
//
//  Created by Tim Bausch on 1/18/22.
//

import Foundation
import Charts

class BarChartXAxisFormatter: NSObject, AxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let labels = ["Speed", "Sp. Defense", "Sp. Attack", "Defense", "Attack", "HP"]
        return labels[Int(value)]
    }
    
    
}
