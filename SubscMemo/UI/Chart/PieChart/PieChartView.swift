//
//  PieChartView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/04/27.
//

import SwiftUI

struct PieChartView: View {
    @Binding var data: [PieChartData]
    var title: String
    #warning("これ大丈夫？ダークモードとか")
    var dropShadow: Bool = true

    public var body: some View {

        ZStack {
            Rectangle()
                .fill(Color.adaptiveWhite)
                .cornerRadius(20)
                .if(dropShadow) { view in
                    view.adaptiveShadow()
                }

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

                if data.count > 0 {
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
                } else {
                    VStack(alignment: .center) {
                        Text("📊 サービスを追加するとグラフが表示されます")
                            .adaptiveFont(.matterMedium, size: 10)
                            .padding()

                        Spacer()
                    }
                }
            }
        }
        .frame(height: 240)
    }
}

#if DEBUG
struct PieChartView_Previews: PreviewProvider {

    static let demoSubscItems = [
        SubscribedItem(
            categoryIDs: ["categoryID-01"],
            cycle: "monthly",
            description: "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription",
            id: "demo-01",

            isUserOriginal: false,
            memo: "demo-memo",
            name: "demo-01",
            planID: nil,
            planName: "",
            price: 100,
            payAt: nil,
            serviceID: "",
            serviceURL: ""
        ),
        SubscribedItem(
            categoryIDs: ["categoryID-02"],
            cycle: "monthly",
            description: "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription",
            id: "demo-02",
            isUserOriginal: false,
            memo: "demo-memo",
            name: "demo-01",
            planID: nil,
            planName: "",
            price: 100,
            payAt: nil,
            serviceID: "",
            serviceURL: ""
        ),
        SubscribedItem(
            categoryIDs: ["categoryID-03"],
            cycle: "monthly",
            description: "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription",
            id: "demo-02",
            isUserOriginal: false,
            memo: "demo-memo",
            name: "demo-01",
            planID: nil,
            planName: "",
            price: 100,
            payAt: nil,
            serviceID: "",
            serviceURL: ""
        ),

        SubscribedItem(
            categoryIDs: ["categoryID-04"],
            cycle: "monthly",
            description: "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription",
            id: "demo-02",
            isUserOriginal: false,
            memo: "demo-memo",
            name: "demo-01",
            planID: nil,
            planName: "",
            price: 100,
            payAt: nil,
            serviceID: "",
            serviceURL: ""
        ),
        SubscribedItem(
            categoryIDs: ["categoryID-05"],
            cycle: "monthly",
            description: "descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription",
            id: "demo-02",
            isUserOriginal: false,
            memo: "demo-memo",
            name: "demo-01",
            planID: nil,
            planName: "",
            price: 100,
            payAt: nil,
            serviceID: "",
            serviceURL: ""
        )
    ]

    static let demoSubscCategories = [
        SubscCategory(id: "id-01", categoryID: "categoryID-01", iconImageURL: "https://via.placeholder.com/50", name: "ソーシャルネットワーキング"),
        SubscCategory(id: "id-02", categoryID: "categoryID-02", iconImageURL: "https://via.placeholder.com/50", name: "写真/動画"),
        SubscCategory(id: "id-03", categoryID: "categoryID-03", iconImageURL: "https://via.placeholder.com/50", name: "教育"),
        SubscCategory(id: "id-04", categoryID: "categoryID-04", iconImageURL: "https://via.placeholder.com/50", name: "ミュージック"),
        SubscCategory(id: "id-05", categoryID: "categoryID-05", iconImageURL: "https://via.placeholder.com/50", name: "スポーツ")
    ]

    static var previews: some View {

        // Empty
        PieChartView(data: .constant([]),
                     title: "たいとる",
                     dropShadow: true)

        Group {
            ForEach( ["iPhone SE (1st generation)",
                      "iPhone X",
                      "iPhone XS Max",
                      "iPad Pro (9.7-inch)"],
                     id: \.self) { deviceName in

                PieChartView(data: .constant(demoPieChartDatas), title: "たいとる", dropShadow: true)
                    .previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
            }
        }
    }
}
#endif
