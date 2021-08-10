//
//  UIImage+AverageColor.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/08/09.
//

import SwiftUI
import UIKit

extension CIImage {
    var averageColor: Color? {
        /*
         filterで利用するためにCIVectorを作成
         > the CGRect x, y, width, height values are stored in the first X, Y, Z, W values of the CIVector.
         */
        let extentVector = CIVector(x: self.extent.origin.x, y: self.extent.origin.y, z: self.extent.size.width, w: self.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: self, kCIInputExtentKey: extentVector]),
              let outputImage = filter.outputImage else {
            return nil
        }

        var bitmap = [UInt8](repeating: 0, count: 4)
        /*
         About CFNull: https://developer.apple.com/documentation/corefoundation/cfnull-rkr
         About workingColorSpace: https://developer.apple.com/documentation/coreimage/cicontextoption/1437728-workingcolorspace
         */
        let context = CIContext(options: [.workingColorSpace: kCFNull])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return Color(.sRGB, red: Double(bitmap[0]) / 255, green: Double(bitmap[1]) / 255, blue: Double(bitmap[2]) / 255, opacity: Double(bitmap[3]) / 255)
    }
}
