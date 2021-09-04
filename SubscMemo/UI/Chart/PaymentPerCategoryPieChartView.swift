//
//  PaymentPerCategoryPieChartView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/07/08.
//

import SwiftUI

struct PaymentPerCategoryPieChartView: View {
    @StateObject var vm = PaymentPerCategoryPieChartViewModel()

    var body: some View {
        PieChartView(data: $vm.pieChartDatas, title: "カテゴリー毎の支払い率")
    }
}

#if DEBUG

struct PaymentPerCategoryPieChartView_Previews: PreviewProvider {

    static var previews: some View {
        return
            Group {
                PaymentPerCategoryPieChartView(vm: demoPaymentPerCategoryPieChartVM)
                    .environment(\.colorScheme, .light)

                PaymentPerCategoryPieChartView(vm: demoPaymentPerCategoryPieChartVM)
                    .environment(\.colorScheme, .dark)
            }
    }
}

#endif
