//
//  SubscListItemView.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/04/11.
//

import SwiftUI

/// サービス探すときのアイテムの実装サンプル
struct SubscListItemView: View {

    var title = "Build an app with SwiftUI"
    var image = "Illustration1"
    var color = Color.blue
    var shadowColor = Color.gray

    var body: some View {
        return VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(30)
                .lineLimit(4)

            Image(systemName: "scribble")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: 246, height: 150)
                .padding(.bottom, 30)
        }
        .background(color)
        .cornerRadius(30)
        .frame(width: 246, height: 360)
        .shadow(color: shadowColor, radius: 20, x: 0, y: 20)
    }
}

#if DEBUG

struct SubscListItemView_Previews: PreviewProvider {

    static var previews: some View {
        return
            Group {
                SubscListItemView()
            }
    }
}

#endif
