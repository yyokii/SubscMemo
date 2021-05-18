//
//  Translator.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/13.
//

import Foundation

/// 取得したデータを表示データへ変換する
protocol Translator {
    associatedtype Input
    associatedtype Output

    func translate(from input: Input) -> Output
}
