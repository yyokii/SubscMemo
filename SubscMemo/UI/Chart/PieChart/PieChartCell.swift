//
//  PieChartCell.swift
//  SubscMemo
//
//  Created by Higashihara Yoki on 2021/04/27.
//

import SwiftUI

struct PieSlice: Identifiable {
    var id = UUID()
    var color: Color
    var startDeg: Double
    var endDeg: Double
    var value: Double
    var normalizedValue: Double
}

public struct PieChartCell: View {
    @State private var show: Bool = false
    var rect: CGRect
    var radius: CGFloat {
        return min(rect.width, rect.height)/2
    }
    var startDeg: Double
    var endDeg: Double
    var path: Path {
        var path = Path()
        // https://developer.apple.com/documentation/coregraphics/1455756-cgcontextaddarc
        path.addArc(
            center: rect.mid,
            radius: self.radius,
            startAngle: Angle(degrees: self.startDeg - 90),
            endAngle: Angle(degrees: self.endDeg - 90),
            clockwise: false
        )
        path.addLine(to: rect.mid)
        path.closeSubpath()
        return path
    }
    var index: Int
    var backgroundColor: Color
    var accentColor: Color
    public var body: some View {
        path
            .fill()
            .foregroundColor(accentColor) // 扇型の色
            .overlay(path.stroke(backgroundColor, lineWidth: 2)) // 枠線の色
            .scaleEffect(self.show ? 1 : 0)
            .animation(Animation.spring().delay(Double(self.index) * 0.04))
            .onAppear {
                self.show = true
            }
    }
}

extension CGRect {
    var mid: CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
}

#if DEBUG
struct PieChartCell_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            PieChartCell(
                rect: geometry.frame(in: .local),
                startDeg: 0.0,
                endDeg: 90.0,
                index: 0,
                backgroundColor:
                    Color(
                        red: 252.0/255.0,
                        green: 236.0/255.0,
                        blue: 234.0/255.0
                    ),
                accentColor:
                    Color(
                        red: 225.0/255.0,
                        green: 97.0/255.0,
                        blue: 76.0/255.0
                    )
            )
        }
        .frame(width: 100, height: 100)

    }
}
#endif
