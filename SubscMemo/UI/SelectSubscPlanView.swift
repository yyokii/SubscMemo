//
//  SelectSubscPlanView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/13.
//

import SwiftUI

struct SelectSubscPlanView: View {
    @State var plans: [SubscPlanViewData]
    @ObservedObject var selectSubscPlanVM: SelectSubscPlanViewModel

    var body: some View {
        VStack(spacing: 8) {
            ForEach(plans) { plan in
                SelectSubscPlanItemView(
                    plan: plan,
                    selectedPlanID: $selectSubscPlanVM.selectedPlanID
                )
            }

            SelectNoneSubscPlanItemView(selectedPlanID: $selectSubscPlanVM.selectedPlanID)
        }
    }
}

struct SelectSubscPlanItemView: View {
    var plan: SubscPlanViewData
    @Binding var selectedPlanID: String

    var isSelected: Bool {
        plan.planID == selectedPlanID
    }

    var body: some View {
        HStack {
            Image(systemName: isSelected ? "checkmark.circle.fill" : "checkmark.circle")
                .renderingMode(.template)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(isSelected ? Color.green : Color.gray)

            Spacer()

            Text(plan.planName)
                .adaptiveFont(.matterSemiBold, size: 12)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(2)
                .foregroundColor(isSelected ? .adaptiveBlack : Color.gray)

            Text(plan.priceText)
                .adaptiveFont(.matterSemiBold, size: 12)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(2)
                .foregroundColor(isSelected ? .adaptiveBlack : Color.gray)

            Text("/" + (plan.cycle?.title ?? ""))
                .adaptiveFont(.matterSemiBold, size: 12)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(2)
                .foregroundColor(isSelected ? .adaptiveBlack : Color.gray)
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: {
            guard let planID = plan.planID else { return }
            selectedPlanID = planID
        })
    }
}

struct SelectNoneSubscPlanItemView: View {
    @Binding var selectedPlanID: String

    var isSelected: Bool {
        selectedPlanID == ""
    }

    var body: some View {
        HStack {
            Image(systemName: isSelected ? "checkmark.circle.fill" : "checkmark.circle")
                .renderingMode(.template)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(isSelected ? Color.green : Color.gray)

            Spacer()

            Text("選択しない")
                .adaptiveFont(.matterSemiBold, size: 12)
                .foregroundColor(isSelected ? .adaptiveBlack : Color.gray)
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: {
            selectedPlanID = ""
        })
    }
}

#if DEBUG

struct SelectSubscItemView_Previews: PreviewProvider {

    static var content: some View {
        NavigationView {
            SelectSubscPlanView(plans: demoSubscPlanViewDatas, selectSubscPlanVM: demoSelectSubscPlanVM)
        }
    }

    static var previews: some View {
        Group {
            content
                .environment(\.colorScheme, .light)

            content
                .environment(\.colorScheme, .dark)
        }
    }
}

#endif
