//
//  TabBar.swift
//  SubscMemo
//
//  Created by 東原与生 on 2020/12/29.
//

import SwiftUI

struct TabBar: View {
    var body: some View {

        TabContent()
    }
}

struct TabContent: View {

    @State var selectedtab = "house"

    init() {

        UITabBar.appearance().isHidden = true
    }

    // Location For each Curve...
    @State var xAxis: CGFloat = 0

    @Namespace var animation

    var body: some View {

        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedtab) {

                SubscListView()
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("house")

                ExploreSubscRowView()
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("magnifyingglass")
            }

            // Custom tab Bar...

            HStack(spacing: 0) {

                Spacer()
                ForEach(tabs, id: \.self) {image in

                    GeometryReader {reader in
                        Button(action: {
                            withAnimation(.spring()) {
                                selectedtab = image
                                xAxis = reader.frame(in: .global).minX
                            }
                        }, label: {
                            Image(systemName: image)
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(selectedtab == image ? Color.black : Color.white)
                                .padding(selectedtab == image ? 15 : 0)
                                .background(Color.white.opacity(selectedtab == image ? 1 : 0).clipShape(Circle()))
                                .matchedGeometryEffect(id: image, in: animation)
                                .offset(x: selectedtab == image ? (reader.frame(in: .global).minX - reader.frame(in: .global).midX) : 0, y: selectedtab == image ? -50 : 0)

                        })
                        .onAppear(perform: {

                            if image == tabs.first {
                                xAxis = reader.frame(in: .global).minX
                            }
                        })
                    }
                    .frame(width: 25, height: 30)

                    if image != tabs.last {Spacer(minLength: 0)}
                }
                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.vertical)
            .background(Color.gray.clipShape(CustomShape(xAxis: xAxis)).cornerRadius(12))
            .padding(.horizontal)
            // Bottom Edge...
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

var tabs = ["house", "magnifyingglass"]

// Curve...

struct CustomShape: Shape {

    var xAxis: CGFloat

    // Animating Path...

    var animatableData: CGFloat {
        get {return xAxis}
        set {xAxis = newValue}
    }

    func path(in rect: CGRect) -> Path {

        return Path {path in

            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))

            let center = xAxis

            path.move(to: CGPoint(x: center - 50, y: 0))

            let to1 = CGPoint(x: center, y: 35)
            let control1 = CGPoint(x: center - 25, y: 0)
            let control2 = CGPoint(x: center - 25, y: 35)

            let to2 = CGPoint(x: center + 50, y: 0)
            let control3 = CGPoint(x: center + 25, y: 35)
            let control4 = CGPoint(x: center + 25, y: 0)

            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
#endif
