//
//  PieChartView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/04/27.
//

import SwiftUI

struct PieChartView: View {
    var data: [PieChartData]
    var title: String
    var legend: String?
    var dropShadow: Bool

    public init(data: [PieChartData], title: String, dropShadow: Bool? = true) {
        self.data = data
        self.title = title
        self.dropShadow = dropShadow!
    }

    public var body: some View {

        ZStack {
            Rectangle()
                .fill(Color.adaptiveWhite)
                .cornerRadius(20)

            VStack(alignment: .leading) {
                HStack {
                    Text(self.title)
                        .adaptiveFont(.matterSemiBold, size: 12)
                        .foregroundColor(Color.adaptiveBlack)
                    Spacer()
                    Image(systemName: "chart.pie.fill")
                        .imageScale(.large)
                        .foregroundColor(Color.gray)
                }
                .padding()

                HStack {
                    PieChartRow(data: data, backgroundColor: Color.adaptiveWhite)

                    VStack(alignment: .leading) {
                        ForEach(data, id: \.id) { chartData in
                            HStack {
                                Rectangle()
                                    .fill(chartData.color)
                                    .frame(width: 16, height: 8)
                                Text("\(chartData.label)")
                                    .adaptiveFont(.matter, size: 12)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .frame(height: 240)
    }
}

#if DEBUG
struct PieChartView_Previews: PreviewProvider {

    static var previews: some View {

        ForEach( ["iPhone SE (1st generation)",
                  "iPhone X",
                  "iPhone XS Max",
                  "iPad Pro (9.7-inch)"],
                 id: \.self) { deviceName in
            PieChartView(data: demoPieChartDatas, title: "たいとる")
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
#endif
