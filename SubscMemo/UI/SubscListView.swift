//
//  SubscListView.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/10.
//

//    enum Presentation: View, Hashable, Identifiable {
//        var id: Self { self }
//        case new
//        case edit(item: SubscItem)
//        var body: some View {
//            switch self {
//            case .new: return  AnyView(EditItemView(item: SubscItem()))
//            case .edit(let item): return AnyView(EditItemView(item: item))
//            }
//        }
//    }

//    @State var presentation: Presentation?

import SwiftUI

struct SubscListView: View {
    @ObservedObject var subscListVM = SubscListViewModel()

    @State var presentAddNewItem = false
    //  @State var showSettingsScreen = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(subscListVM.subscCellViewModels) { subscCellVM in
                        SubscCell(subscCellVM: subscCellVM)
                    }
                    if presentAddNewItem {
                        SubscCell(subscCellVM: SubscCellViewModel.newItem()) { result in
                            if case .success(let item) = result {
                                self.subscListVM.addItem(item: item)
                            }
                            self.presentAddNewItem.toggle()
                        }
                    }
                }
                Button(action: { self.presentAddNewItem.toggle() }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("New Task")
                    }
                }
                .padding()
                .accentColor(Color(UIColor.systemRed))
            }
            .navigationBarTitle("Tasks")
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        SubscListView()
    }
}

enum InputError: Error {
    case empty
}

struct SubscCell: View {
    @ObservedObject var subscCellVM: SubscCellViewModel
    var onCommit: (Result<SubscItem, InputError>) -> Void = { _ in }

    var body: some View {
        HStack {
            Image(systemName: subscCellVM.completionStateIconName)
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    self.subscCellVM.item.completed.toggle()
                }
            TextField("Enter task title", text: $subscCellVM.item.title,
                      onCommit: {
                        if !self.subscCellVM.item.title.isEmpty {
                            self.onCommit(.success(self.subscCellVM.item))
                        } else {
                            self.onCommit(.failure(.empty))
                        }
                      }).id(subscCellVM.id)
        }
    }
}
