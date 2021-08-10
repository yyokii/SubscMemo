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

    public init(
        url: URL,
        session: URLSession = .shared) {
        self.url = url
        self.session = session
    }

    private let url: URL
    private let session: URLSession
    private var cancellable: AnyCancellable?

    @Published public var averageColor: Color?

    private func getImageAverageColor(from data: Data?) -> Color? {
        guard let data = data,
              let image = CIImage(data: data),
              let averageColor = image.averageColor else { return nil }
        return averageColor
    }

    public func load() {
        cancellable = session.dataTaskPublisher(for: url)
            .map { $0.data }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.averageColor = self?.getImageAverageColor(from: $0)
            }
    }

    public func cancel() {
        cancellable?.cancel()
    }
}
