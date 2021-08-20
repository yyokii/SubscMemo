//
//  PagingBannerView.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/08/18.
//

import SwiftUI

struct PagingBannerView: View {
    @State var selectedIndex: Int = 0
    @StateObject var vm = PagingBannerViewModel()

    var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(0..<vm.contents.count) { index in
                let item = vm.contents[index]
                item
                    .getView()
                    .tag(index)

            }
        }
        .tabViewStyle(PageTabViewStyle())
        .background(Color.black)
        //        .frame(height: 200)
        .aspectRatio(3.2, contentMode: .fit)
        .onChange(of: selectedIndex, perform: { newValue in
            vm.onChangeBanner(to: newValue)
        })
        .onReceive(vm.$selectedIndex) { index in
            withAnimation {
                selectedIndex = index
            }
        }
    }
}

#if DEBUG

struct DemoPagingBannerView: View {
    var body: some View {
        NavigationView {
            VStack {
                PagingBannerView()
                    .navigationTitle("DemoPagingBanner")

                Spacer()
            }
        }
    }
}

struct PagingBanner_Previews: PreviewProvider {
    static var previews: some View {
        DemoPagingBannerView()
            .environment(\.colorScheme, .light)
    }
}

#endif
