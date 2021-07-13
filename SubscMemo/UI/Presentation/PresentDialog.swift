//
//  PresentDialog.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/24.
//

import SwiftUI

enum DialogContent: View {
    case selectDate(isPresented: Binding<Bool>, dateRange: ClosedRange<Date>, savedDate: Binding<Date?>, selectingDate: Date)

    @ViewBuilder
    var body: some View {
        switch self {
        case .selectDate(let isPresented, let dateRange, let savedDate, let selectingDate):
            DatePickerWithButtons(
                dateRange: dateRange,
                showDatePicker: isPresented,
                savedDate: savedDate,
                selectingDate: selectingDate
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
