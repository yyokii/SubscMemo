//
//  ExploreSubscRowView.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/12/15.
//

import SwiftUI

struct ExploreSubscRowView: View {

    @ObservedObject var exploreSubscRowVM = ExploreSubscRowViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(exploreSubscRowVM.exploreSubscItemViewModels) { item in
                        ExploreSubscItemView(exploreSubscItemVM: item)
                    }
                }
                .padding(20)
                .padding(.leading, 10)
            }
        }
    }
}

struct ExploreSubscItemView: View {

    @ObservedObject var exploreSubscItemVM: ExploreSubscItemViewModel

    var body: some View {
        return VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(exploreSubscItemVM.item.name)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color("accent"))
                        .padding(.top)

                    Text("Certificate")
                        .foregroundColor(.white)
                }
                Spacer()

                Image("Logo")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .padding(.horizontal)
            Spacer()

            //            Image(item.image)
            //                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            //                .offset(y: 50)
        }
        .frame(width: 150, height: 80)
        .background(Color.appBlack)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

#if DEBUG
struct ExploreSubscRowView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreSubscRowView(exploreSubscRowVM: demoExploreSubscRowVM)
    }
}
#endif
