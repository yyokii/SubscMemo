//
//  SubscListView.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/10.
//

import SwiftUI

struct SubscListView: View {
    @ObservedObject var subscListVM = SubscListViewModel()

    //    enum Presentation: View, Hashable, Identifiable {
    //
    //        case new
    //        case edit(item: SubscItem)
    //
    //        var body: some View {
    //            switch self {
    //            case .new: return AnyView(EditSubscView(item: SubscItem.makeNewItem()))
    //            case .edit(let item): return AnyView(EditSubscView(item: item))
    //            }
    //        }
    //    }
    //    @State var presentation: Presentation?

    @State var isPresented: Bool = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {

                PaymentSummaryView()

                ExploreSubscRowView()

                List(subscListVM.subscCellViewModels) { model in

                    NavigationLink(destination: EditSubscView(editSubscVM: EditSubscViewModel(item: model.item)), label: {
                        SubscCell(subscCellVM: model)
                    })
                }

                Button(action: {
                    isPresented.toggle()
                }, label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("New Item")
                    }
                })

                .padding()
                .accentColor(Color(UIColor.systemRed))
            }
            .navigationBarTitle("Items")
            .sheet(isPresented: $isPresented, content: {
                EditSubscView(editSubscVM: EditSubscViewModel.newItem())
            })
        }
    }
}

enum InputError: Error {
    case empty
}

struct SubscCell: View {
    @ObservedObject var subscCellVM: SubscCellViewModel
    var onCommit: (Result<SubscItem, InputError>) -> Void = { _ in }

    var body: some View {
        VStack {
            Text(subscCellVM.item.title)
        }
    }
}

#if DEBUG

struct TaskListView_Previews: PreviewProvider {

    static var previews: some View {
        return Group {
            SubscListView(subscListVM: demoSubscListVM, isPresented: false)
            SubscListView(subscListVM: demoSubscListVM, isPresented: false)
            SubscListView(subscListVM: demoSubscListVM, isPresented: false)
            SubscListView(subscListVM: demoSubscListVM, isPresented: false)
        }
    }
}

#endif
