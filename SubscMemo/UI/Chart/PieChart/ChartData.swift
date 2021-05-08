//
//  ChartData.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/05/01.
//

import SwiftUI

protocol ChartData: Identifiable {
    var data: Double { get }
    var color: Color { get }
    var label: String { get }
}
