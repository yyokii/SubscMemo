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
    var color: Color
    var label: String
}

let pieChartColors: [Color] = [
    Color.hex(0xCD6155),
    Color.hex(0xEC7063),
    Color.hex(0xCD8155),
    Color.hex(0xCD9155),
    Color.hex(0xCE6155),
    Color.hex(0xCD6255),
    Color.hex(0xCD6355),
    Color.hex(0xCD6455),
    Color.hex(0xCD6555),
    Color.hex(0xCD6655),
    Color.hex(0xCD6755),
    Color.hex(0xCD6855),
    Color.hex(0xCD6955),
    Color.hex(0xCD6115),
    Color.hex(0xCD6125),
    Color.hex(0xCD6135),
    Color.hex(0xCD6145),
    Color.hex(0xCD6165)
]

#if DEBUG
let demoPieChartDatas = [
    PieChartData(data: 10, color: Color.gray, label: "data01"),
    PieChartData(data: 20, color: Color.blue, label: "data02"),
    PieChartData(data: 30, color: Color.red, label: "data03"),
    PieChartData(data: 40, color: Color.orange, label: "data04"),
    PieChartData(data: 50, color: Color.green, label: "data05")

]
#endif
