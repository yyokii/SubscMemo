//
//  CategoryPieChartView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/08.
//

import SwiftUI

struct CategoryPieChartView: View {
    @StateObject var categoryPieChartVM = CategoryPieChartViewModel()

    var body: some View {
        PieChartView(data: categoryPieChartVM.pieChartDatas, title: "利用カテゴリー率")
    }
}

#if DEBUG

struct CategoryPieChartView_Previews: PreviewProvider {

    static var previews: some View {
        return
            Group {
                CategoryPieChartView(categoryPieChartVM: demoCategoryPieChartVM)
                    .environment(\.colorScheme, .light)

                CategoryPieChartView(categoryPieChartVM: demoCategoryPieChartVM)
                    .environment(\.colorScheme, .dark)
            }
    }
}

#endif
