//
//  Marquee.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/04/14.
//

import SwiftUI

struct Marquee<Content>: View where Content: View {
    let duration: TimeInterval
    let messages: () -> Content

    init(
        duration: TimeInterval,
        @ViewBuilder messages: @escaping () -> Content
    ) {
        self.duration = duration
        self.messages = messages
    }

    @State private var isLoaded = false
    @State private var size: CGSize = .zero

    var body: some View {
        VStack {

            Text("demo: \(self.size.width)")

            if self.isLoaded {
                GeometryReader { outer in
                    ScrollView(.horizontal) {
                        HStack(spacing: outer.size.width * 2 / 3) {
                            Color.red
                                .frame(width: outer.size.width * 1 / 3) // 2/3 + 1/3 で 3/3分の空白を用意している
                            self.messages()
                        }
                        .fixedSize()
                        .offset(x: self.size.width)
                        .animation(
                            Animation
                                .linear(duration: self.duration)
                                .repeatForever(autoreverses: false),
                            value: self.size.width // .zeroからinner.size（のwidth）までアニメーションさせる
                        )
                        .background(
                            GeometryReader { inner in
                                Color.clear
                                    .onAppear {
                                        self.size = inner.size // 1回のアニメーションの終了座標
                                    }
                            }
                        )
                    }
                    .disabled(true)
                }
                .frame(height: self.size.height)
            }
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            DispatchQueue.main.async {
                self.isLoaded = true
            }
        }
    }
}

private struct NagBanner: View {

    var body: some View {
        Marquee(duration: TimeInterval(messages.count) * 9) {
            ForEach(messages, id: \.self) { message in
                Text(message)
                    .adaptiveFont(.matterMedium, size: 14)
            }
        }
    }
}

let messages = [
    "Remove this annoying banner.",
    "Please, we don’t like it either."
]

#if DEBUG
struct NagBanner_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ZStack(alignment: .bottomLeading) {
                NagBanner()
            }
        }
    }
}
#endif
