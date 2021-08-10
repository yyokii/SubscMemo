//
//  SubscribedItemDetailView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/06/03.
//

import SwiftUI

struct SubscribedItemDetailView: View {
    @State var presentContent: PresentContent?
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var vm: SubscribedItemDetailViewModel
    let iconColor: Color

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Spacer()

                    Button(action: {
                        vm.confirmDelete()
                    }, label: {
                        Image(systemName: "trash")
                            .resizable()
                            .frame(width: 25, height: 25)
                    })
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 30)
                }

                HStack {
                    ServiceIconImageView(iconColor: iconColor,
                                         serviceURL: vm.subscItem.serviceURL?.absoluteString,
                                         serviceName: vm.subscItem.serviceName)
                        .frame(width: 70, height: 70)
                        .cornerRadius(35)
                }
                .frame(maxWidth: .infinity)

                VStack(alignment: .leading) {

                    ServiceNameView(
                        serviceName: vm.subscItem.serviceName,
                        serviceURL: vm.subscItem.serviceURL,
                        linkTapAction: { url in
                            presentContent = .safariView(url: url)
                        }
                    )

                    Text(vm.subscItem.mainCategoryName)
                        .adaptiveFont(.matterSemiBold, size: 16)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(2)
                        .padding(.top)
                        .foregroundColor(.gray)

                    SubscPlanListView(plans: [vm.plan])
                        .padding(.top, 20)

                    Text(vm.subscItem.description)
                        .adaptiveFont(.matterSemiBold, size: 16)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, 40)
                        .foregroundColor(.gray)
                }
                .padding()
                .padding(.top, 40)
            }
        }
        .alert(isPresented: $vm.alertProvider.shouldShowAlert ) {
            guard let alert = vm.alertProvider.alert else { fatalError("💔: Alert not available")
            }
            return Alert(alert)
        }
        .onAppear(perform: {
            vm.loadItemData()
        })
        .sheet(item: $presentContent, content: { $0 })
    }
}

#if DEBUG

struct SubscribedItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SubscribedItemDetailView(vm: demoSubscribedItemDetailVM, iconColor: .orange)
                .environment(\.colorScheme, .light)

            SubscribedItemDetailView(vm: demoSubscribedItemDetailVM, iconColor: .gray)
                .environment(\.colorScheme, .dark)
        }
    }
}

#endif
