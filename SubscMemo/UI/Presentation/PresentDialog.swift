//
//  PresentDialog.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/24.
//

import SwiftUI

enum DialogContent: View {

    case selectPaymentCycle(isPresented: Binding<Bool>, text: Binding<String>)
    case selectMainCategory(isPresented: Binding<Bool>, datas: [String], selectedData: Binding<String>)
    case selectSubCategory(isPresented: Binding<Bool>, datas: [String], selectedData: Binding<String>)
    case selectDate(isPresented: Binding<Bool>, dateRange: ClosedRange<Date>, savedDate: Binding<Date?>, selectingDate: Date)

    var body: some View {
        switch self {
        case .selectPaymentCycle(let isPresented, let text):
            return AnyView(
                PaymentCyclePickerView(
                    isPresented: isPresented,
                    selectedCycleText: text
                )
            )
        case .selectMainCategory(let isPresented, let datas, let selectedData):
            return AnyView(
                OptionalablePickerView(
                    datas: datas,
                    isOptionalPick: false,
                    isPresented: isPresented,
                    selectedData: selectedData
                )
            )
        case .selectSubCategory(let isPresented, let datas, let selectedData):
            return AnyView(
                OptionalablePickerView(
                    datas: datas,
                    isOptionalPick: true,
                    isPresented: isPresented,
                    selectedData: selectedData
                )
            )
        case .selectDate(let isPresented, let dateRange, let savedDate, let selectingDate):
            return AnyView(
                DatePickerWithButtons(
                    dateRange: dateRange,
                    showDatePicker: isPresented,
                    savedDate: savedDate,
                    selectingDate: selectingDate
                )
            )
        }
    }
}

final class DialogPresentation: ObservableObject {
    @Published var isPresented = false
    @Published var dialogContent: DialogContent?

    func show(content: DialogContent?) {

        if let presentDialog = content {
            dialogContent = presentDialog
            isPresented = true
        } else {
            isPresented = false
        }
    }
}

struct CustomDialog: ViewModifier {
    @ObservedObject var presentationManager: DialogPresentation

    func body(content: Content) -> some View {
        ZStack {
            content

            if presentationManager.isPresented {
                Rectangle().foregroundColor(Color.black.opacity(0.3))
                    .edgesIgnoringSafeArea(.all)

                presentationManager.dialogContent
                    .padding(32)
            }
        }
    }
}

extension View {
    func customDialog(
        presentationManager: DialogPresentation
    ) -> some View {
        self.modifier(CustomDialog(presentationManager: presentationManager))
    }
}
