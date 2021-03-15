//
//  SubscListView.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/10/10.
//

import SwiftUI

struct SubscListView: View {
    @ObservedObject var subscListVM = SubscListViewModel()

    @State var presentContent: PresentContent?

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {

                UserProfileView()
                    .contentShape(Rectangle())
                    .onTapGesture {
                        presentContent = .loginAndSignUp
                    }

                PaymentSummaryView()

                ExploreSubscRowView()

                List(subscListVM.subscCellViewModels) { model in

                    NavigationLink(destination: EditSubscView(editSubscVM: EditSubscViewModel(item: model.item)), label: {
                        SubscCell(subscCellVM: model)
                    })
                }

                Button(action: {
                    presentContent = .createSubscItem
                }, label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("New Item")
                    }
                })
                .navigationBarTitle("Home")
                .padding()
                .accentColor(Color(UIColor.systemRed))
            }
            .sheet(item: $presentContent, content: { $0 })
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
            SubscListView(subscListVM: demoSubscListVM)
        }
    }
}

#endif
