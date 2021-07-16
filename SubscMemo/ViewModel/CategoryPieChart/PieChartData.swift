//
//  PieChartData.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/09.
//

import SwiftUI

public struct PieChartData: ChartData {
    public var id = UUID()

    var data: Double
    var color: Color = Color.randomColor()
    var label: String
}

#if DEBUG
let demoPieChartDatas = [
    PieChartData(data: 10, label: "data01"),
    PieChartData(data: 20, label: "data02"),
    PieChartData(data: 30, label: "data03"),
    PieChartData(data: 40, label: "data04"),
    PieChartData(data: 50, label: "data05")

]
#endif
