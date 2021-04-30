//
//  ChartData.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/01.
//

import SwiftUI

protocol ChartData: Identifiable {
    var data: Double { get }
    var color: Color { get }
    var label: String { get }
}

public struct PieChartData: ChartData {
    public var id = UUID()

    var data: Double
    var color: Color
    var label: String
}

#if DEBUG
let demoPieChartDatas = [
    PieChartData(data: 10, color: Color.gray, label: "data01"),
    PieChartData(data: 20, color: Color.blue, label: "data02"),
    PieChartData(data: 30, color: Color.red, label: "data03"),
    PieChartData(data: 40, color: Color.orange, label: "data04"),
    PieChartData(data: 50, color: Color.green, label: "data05")

]
#endif
