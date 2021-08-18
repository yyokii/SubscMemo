//
//  AsyncImageColorLoader.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/08/09.
//

import Combine
import SwiftUI
import UIKit

public class AsyncImageColorLoader: ObservableObject {
    static var cache: AnyCache = AnyCache(data: CacheImpl<URL, Color>())
    private let url: URL
    private let session: URLSession
    private var cancellable: AnyCancellable?

    @Published public var averageColor: Color?

    public init(
        url: URL,
        session: URLSession = .shared) {
        self.url = url
        self.session = session
    }

    private func getImageAverageColor(from data: Data?) -> Color? {
        guard let data = data,
              let image = CIImage(data: data),
              let averageColor = image.averageColor else { return nil }
        return averageColor
    }

    public func load() {
        if let cached: Color = AsyncImageColorLoader.cache.data[url] {
            self.averageColor = cached
            return
        }

        cancellable = session.dataTaskPublisher(for: url)
            .map { $0.data }
            .map { [weak self] in
                self?.getImageAverageColor(from: $0)
            }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self = self else { return }

                self.averageColor = $0
                if let color = $0 {
                    AsyncImageColorLoader.cache.data[self.url] = color
                }
            }
    }

    public func cancel() {
        cancellable?.cancel()
    }
}
