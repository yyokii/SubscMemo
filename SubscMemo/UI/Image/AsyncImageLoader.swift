//
//  AsyncImageLoader.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/04.
//

import Combine
import SwiftUI
import UIKit

public class AsyncImageLoader: ObservableObject {
    static var cache: AnyCache = AnyCache(data: CacheImpl<URL, Image>())
    private let url: URL
    private let session: URLSession
    private var cancellable: AnyCancellable?

    @Published public var image: Image?

    public init(
        url: URL,
        session: URLSession = .shared) {
        self.url = url
        self.session = session
    }

    private func getImage(from data: Data?) -> Image? {
        guard let data = data else { return nil }
        let image = UIImage(data: data) ?? UIImage()
        return Image(uiImage: image)
    }

    public func load() {
        if let cached = AsyncImageLoader.cache.data[url] {
            self.image = cached
            return
        }

        cancellable = session.dataTaskPublisher(for: url)
            .map { $0.data }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self = self else { return }

                let image = self.getImage(from: $0)
                self.image = image
                if let image = image {
                    AsyncImageLoader.cache.data[self.url] = image
                }
            }
    }

    public func cancel() {
        cancellable?.cancel()
    }
}
