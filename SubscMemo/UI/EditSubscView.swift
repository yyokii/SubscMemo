//
//  EditSubscView.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/15.
//

import SwiftUI

struct EditSubscView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject var editSubscVM = EditSubscViewModel()
    @State private var item: SubscItem = SubscItem.makeNewItem()

    var body: some View {

        ScrollView {
            VStack {
                VStack(alignment: .leading) {
                    LabelTextField(title: "Title", placeHolder: "Fill in the title", label: $item.title)

                    LabelTextField(title: "Price", placeHolder: "Fill in the price", label: $item.price.intToString(0))

                    LabelTextField(title: "Cycle", placeHolder: "", label: $item.cycle)

                    LabelTextField(title: "Category", placeHolder: "", label: $item.category)

                    LabelTextField(title: "Description", placeHolder: "", label: $item.description)
                }

                Button(action: {
                    editSubscVM.addItem(item: item)
                }, label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("New Item")
                    }
                })
            }
            .padding()
        }
    }
}

struct LabelTextField: View {
    var title: String
    var placeHolder: String

    @Binding var label: String

    var body: some View {

        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)

            TextField(placeHolder, text: $label)
                .padding(.all)
                .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
        }
        .padding(.horizontal, 15)
    }
}

struct AddNewSubscView_Previews: PreviewProvider {
    static var previews: some View {
        EditSubscView()
    }
}
