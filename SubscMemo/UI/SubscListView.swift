//
//  SubscListView.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/10.
//

enum Presentation: View, Hashable, Identifiable {
    var id: Self { self }

    case new
    var body: some View {
        switch self {
        case .new: return  AnyView(EditSubscView())
        }
    }
}

import SwiftUI

struct SubscListView: View {
    @ObservedObject var subscListVM = SubscListViewModel()

    @State var presentation: Presentation?

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(subscListVM.subscCellViewModels) { subscCellVM in
                        SubscCell(subscCellVM: subscCellVM)
                    }
                }

                Button(action: {
                    self.presentation = .new
                }, label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("New Task")
                    }
                })

                .padding()
                .accentColor(Color(UIColor.systemRed))
            }
            .navigationBarTitle("Tasks")
            .sheet(item: self.$presentation) { $0 }
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
            TextField("Enter item title", text: $subscCellVM.item.title,
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
