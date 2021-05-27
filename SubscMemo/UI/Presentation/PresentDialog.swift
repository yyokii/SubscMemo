//
//  PresentDialog.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/24.
//

import SwiftUI

enum DialogContent: View {

    case contentDetail01(isPresented: Binding<Bool>)
    case contentDetail02(isPresented: Binding<Bool>)
    case selectPaymentCycle(isPresented: Binding<Bool>, text: Binding<String>)

    var body: some View {
        switch self {
        case .contentDetail01(let isPresented):
            return AnyView(
                DemoDialogContent01(isPresented: isPresented)
            )
        case .contentDetail02(let isPresented):
            return AnyView(
                DemoDialogContent02(isPresented: isPresented)
            )
        case .selectPaymentCycle(let isPresented, let text):
            return AnyView(
                PaymentCyclePickerView(isPresented: isPresented, selectedCycleText: text)

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

#if DEBUG

struct DemoDialogView: View {

    @State private var dialogPresentataion = DialogPresentation()

    var body: some View {
        VStack {
            Text("Demo")
                .padding()

            Button(action: {
                dialogPresentataion.show(
                    content: .contentDetail01(isPresented: $dialogPresentataion.isPresented))
            }) {
                Text("Present dialog01")
                    .autocapitalization(.allCharacters)
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .padding()

            Button(action: {
                dialogPresentataion.show(
                    content: .contentDetail02(isPresented: $dialogPresentataion.isPresented))
            }) {
                Text("Present dialog02")
                    .autocapitalization(.allCharacters)
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .padding()

            Button(action: {
                dialogPresentataion.show(content: nil)
            }) {
                Text("Set no content")
                    .autocapitalization(.allCharacters)
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .padding()

        }
        .customDialog(presentationManager: dialogPresentataion)
    }
}

struct DemoDialogContent01: View {

    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            Text("Demo Title")
                .font(.title)
                .padding()

            Text("Demo Message\nDemo Message\nDemo Message")
                .font(.subheadline)
                .padding()

            Button(action: {
                isPresented = false
            }) {
                Text("Close Dialog")
                    .padding()
            }
        }
        .background(Color.white)
        .cornerRadius(8)
    }
}

struct DemoDialogContent02: View {

    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            Text("Demo Title02")
                .font(.title)
                .padding()

            Text("Demo Message\nDemo Message\nDemo Message")
                .font(.subheadline)
                .padding()

            Button(action: {
                isPresented = false
            }) {
                Text("❎")
                    .padding()
            }
        }
        .background(Color.blue)
        .cornerRadius(8)
    }
}

struct CustomDialog_Previews: PreviewProvider {

    static var previews: some View {
        DemoDialogView()
            .environment(\.colorScheme, .light)
    }
}

#endif
