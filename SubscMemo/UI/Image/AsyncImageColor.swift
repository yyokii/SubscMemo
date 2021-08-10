//
//  AsyncImageColor.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/08/10.
//

import SwiftUI

public struct AsyncImageColor<PlaceholderView: View>: View {

    public init(
        url: URL,
        contentMode: ContentMode = .fit,
        @ViewBuilder placeholder: @escaping Placeholder) {
        self.contentMode = contentMode
        self.placeholder = placeholder
        _loader = ObservedObject(wrappedValue: AsyncImageColorLoader(url: url))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: loadImage)
    }

    public typealias Placeholder = () -> PlaceholderView

    private let contentMode: ContentMode
    private let placeholder: Placeholder

    @ObservedObject private var loader: AsyncImageColorLoader

    public var body: some View {
        content
    }

    @ViewBuilder
    private var content: some View {
        if let color = loader.averageColor {
            Rectangle()
                .fill(color)
        } else {
            placeholder()
        }
    }

    private func loadImage() { loader.load() }
}

#if DEBUG

struct AsyncImageColor_Previews: PreviewProvider {

    static var previews: some View {
        let urlString = "https://picsum.photos/200"
        let url = URL(string: urlString)
        return AsyncImageColor(url: url!) {
            Color.black
        }.aspectRatio(contentMode: .fit)
    }
}

#endif
