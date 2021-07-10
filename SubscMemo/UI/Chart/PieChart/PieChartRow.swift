//
//  PieChartRow.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/04/27.
//

import SwiftUI

public struct PieChartRow: View {
    var data: [PieChartData]
    var backgroundColor: Color
    var slices: [PieSlice] {
        var tempSlices: [PieSlice] = []
        var lastEndDeg: Double = 0
        let maxValue = data
            .map { $0.data }
            .reduce(0, +)
        for slice in data {
            let normalized: Double = Double(slice.data)/Double(maxValue) // 各値の全体に対する割合
            let startDeg = lastEndDeg // 前のデータ終了地点より、cellを作成する（初期値は0）
            let endDeg = lastEndDeg + (normalized * 360)
            lastEndDeg = endDeg
            tempSlices.append(PieSlice(color: slice.color, startDeg: startDeg, endDeg: endDeg, value: slice.data, normalizedValue: normalized))
        }
        return tempSlices
    }
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<slices.count, id: \.self) { index in
                    PieChartCell(
                        rect: geometry.frame(in: .local),
                        startDeg: slices[index].startDeg,
                        endDeg: slices[index].endDeg,
                        index: index,
                        backgroundColor: backgroundColor,
                        accentColor: slices[index].color
                    )
                }
            }
        }
    }
}

#if DEBUG
struct PieChartRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PieChartRow(
                data: demoPieChartDatas,
                backgroundColor:
                    Color(
                        red: 252.0/255.0,
                        green: 236.0/255.0,
                        blue: 234.0/255.0
                    )
            )
            .frame(width: 100, height: 100)
        }
    }
}
#endif
