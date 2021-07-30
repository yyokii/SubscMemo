//
//  Alert+Provider.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/03/20.
//

import SwiftUI

final class AlertProvider: ObservableObject {

    struct Alert {
        var title: String
        let message: String
        let primaryButtomText: String
        let primaryButtonAction: (() -> Void)?
        let secondaryButtonText: String
    }

    /// アラートを表示するかどうかを示すフラグ。Viewが監視する。
    @Published var shouldShowAlert = false

    var alert: Alert? = nil {
        didSet {
            shouldShowAlert = alert != nil
        }
    }
}

extension AlertProvider {
    func showConfirmAlert(
        title: String,
        message: String,
        positiveAction: (() -> Void)?
    ) {
        alert = AlertProvider.Alert(
            title: title,
            message: message,
            primaryButtomText: "OK",
            primaryButtonAction: positiveAction,
            secondaryButtonText: "キャンセル"
        )
    }

    func showErrorAlert(message: String?) {
        alert = AlertProvider.Alert(
            title: "エラー",
            message: message ?? "申し訳ございません。時間を置いてもう一度お試しください。",
            primaryButtomText: "OK",
            primaryButtonAction: {},
            secondaryButtonText: ""
        )
    }

    func showSuccessAlert(
        title: String,
        message: String,
        action: (() -> Void)?
    ) {
        alert = AlertProvider.Alert(
            title: title,
            message: message,
            primaryButtomText: "OK",
            primaryButtonAction: action,
            secondaryButtonText: ""
        )
    }
}

extension Alert {
    init(_ alert: AlertProvider.Alert) {
        if !alert.primaryButtomText.isEmpty && !alert.secondaryButtonText.isEmpty {
            self.init(title: Text(alert.title),
                      message: Text(alert.message),
                      primaryButton: .default(Text(alert.primaryButtomText),
                                              action: alert.primaryButtonAction),
                      secondaryButton: .cancel(Text(alert.secondaryButtonText)))
        } else {
            self.init(
                title: Text(alert.title),
                message: Text(alert.message),
                dismissButton: .default(Text(alert.primaryButtomText),
                                        action: alert.primaryButtonAction)
            )
        }
    }
}
