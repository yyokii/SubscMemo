//
//  AsyncImage.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/04.
//

import Foundation
import SwiftUI

/**
 This view can be used to show an image that is fetched from
 an url using an async network request. A `placeholder` will
 be displayed when an image is being fetched as well as when
 the fetch operation fails.

 This is a very basic implementation, so you may want to use
 a library like Kingfisher for more complex operations.
 */
@available(iOS 14, macOS 11.0, tvOS 14, watchOS 7.0, *)
public struct AsyncImage<PlaceholderView: View>: View {

    public init(
        url: URL,
        contentMode: ContentMode = .fit,
        @ViewBuilder placeholder: @escaping Placeholder) {
        self.contentMode = contentMode
        self.placeholder = placeholder
        _loader = ObservedObject(wrappedValue: AsyncImageLoader(url: url))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: loadImage)
    }

    public typealias Placeholder = () -> PlaceholderView

    private let contentMode: ContentMode
    private let placeholder: Placeholder

    @ObservedObject private var loader: AsyncImageLoader

    public var body: some View {
        content
    }

    @ViewBuilder
    private var content: some View {
        if let image = loader.image {
            image
                .resizable()
                .aspectRatio(contentMode: contentMode)
        } else {
            placeholder()
        }
    }

    private func loadImage() { loader.load() }
}

@available(iOS 14, macOS 11.0, tvOS 14, watchOS 7.0, *)
struct AsyncImage_Previews: PreviewProvider {

    static var previews: some View {
        let urlString = "https://via.placeholder.com/150"
        let url = URL(string: urlString)
        return AsyncImage(url: url!) {
            Color.gray
        }.aspectRatio(contentMode: .fit)
    }
}
