//
//  AsyncImageLoader.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/04.
//

import Combine
import SwiftUI

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(macOS)
import Cocoa
#endif

public class AsyncImageLoader: ObservableObject {

    public init(
        cache: Cache<URL, Image> = Cache(),
        url: URL,
        session: URLSession = .shared) {
        self.cache = cache
        self.url = url
        self.session = session
    }

    deinit {
        cancel()
    }

    private let cache: Cache<URL, Image>
    private let url: URL
    private let session: URLSession
    private var cancellable: AnyCancellable?

    @Published public var image: Image?

    private func getImage(from data: Data?) -> Image? {
        guard let data = data else { return nil }
        #if os(iOS) || os(tvOS) || os(watchOS)
        let image = UIImage(data: data) ?? UIImage()
        return Image(uiImage: image)
        #elseif os(macOS)
        let image = NSImage(data: data) ?? NSImage()
        return Image(nsImage: image)
        #else
        print("Unsupported platform")
        return nil
        #endif
    }

    public func load() {

        if let cached = cache[url] {
            self.image = cached
            return
        }

        cancellable = session.dataTaskPublisher(for: url)
            .map { $0.data }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.image = self?.getImage(from: $0)
            }
    }

    public func cancel() {
        cancellable?.cancel()
    }
}
