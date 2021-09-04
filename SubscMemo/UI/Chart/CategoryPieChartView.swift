//
//  CategoryPieChartView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/08.
//

import SwiftUI

struct CategoryPieChartView: View {
    @StateObject var vm = CategoryPieChartViewModel()

    var body: some View {
        PieChartView(data: $vm.pieChartDatas, title: "利用カテゴリー率")
    }
}

#if DEBUG

struct CategoryPieChartView_Previews: PreviewProvider {

    static var previews: some View {
        return
            Group {
                CategoryPieChartView(vm: demoCategoryPieChartVM)
                    .environment(\.colorScheme, .light)

                CategoryPieChartView(vm: demoCategoryPieChartVM)
                    .environment(\.colorScheme, .dark)
            }
    }
}

#endif
