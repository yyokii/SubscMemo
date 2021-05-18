//
//  EditSubscView.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/15.
//

import SwiftUI

struct EditSubscView: View {

    @ObservedObject var editSubscVM = EditSubscViewModel.newItem()

    var body: some View {

        ScrollView {
            VStack {

                VStack(alignment: .leading) {
                    LabelTextField(title: "Title", placeHolder: "Fill in the title", label: $editSubscVM.item.name)

                    LabelTextField(title: "Price", placeHolder: "Fill in the price", label: $editSubscVM.item.price.intToString(0))

                    LabelTextField(title: "Cycle", placeHolder: "", label: $editSubscVM.item.cycle)

                    LabelTextField(title: "Category", placeHolder: "", label: $editSubscVM.item.mainCategoryID)

                    LabelTextField(title: "Description", placeHolder: "", label: $editSubscVM.item.description)
                }

                Button(action: {
                    editSubscVM.deleteItem(item: editSubscVM.item)
                }, label: {
                    HStack {
                        Image(systemName: "trash")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Delete")
                    }
                }).padding()

                Button(action: {
                    editSubscVM.addItem(item: editSubscVM.item)
                }, label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("New Item")
                    }
                }).padding()
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
        EditSubscView(editSubscVM: EditSubscViewModel.newItem())
    }
}
