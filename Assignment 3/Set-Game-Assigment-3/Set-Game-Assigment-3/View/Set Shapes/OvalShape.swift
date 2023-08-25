//
//  OvalShape.swift
//  Set-Game-Assigment-3
//
//  Created by Kevin Martinez on 7/14/23.
//

import SwiftUI


struct OvalShape: Shape {
   private let cornerRadiusPercentage: CGFloat = 0.5
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        let cornerRadius: CGFloat = (rect.width / 2) * cornerRadiusPercentage
        let width = rect.width
        let height = width / 2

                  p.move(to: CGPoint(x: cornerRadius, y: 0))
                  p.addLine(to: CGPoint(x: width - cornerRadius, y: 0))
                  p.addArc(center: CGPoint(x: width - cornerRadius, y: cornerRadius),
                              radius: cornerRadius,
                              startAngle: Angle(degrees: -90),
                              endAngle: Angle(degrees: 0),
                              clockwise: false)
                  p.addLine(to: CGPoint(x: width, y: height - cornerRadius))
                  p.addArc(center: CGPoint(x: width - cornerRadius, y: height - cornerRadius),
                              radius: cornerRadius,
                              startAngle: Angle(degrees: 0),
                              endAngle: Angle(degrees: 90),
                              clockwise: false)
                  p.addLine(to: CGPoint(x: cornerRadius, y: height))
                  p.addArc(center: CGPoint(x: cornerRadius, y: height - cornerRadius),
                              radius: cornerRadius,
                              startAngle: Angle(degrees: 90),
                              endAngle: Angle(degrees: 180),
                              clockwise: false)
                  p.addLine(to: CGPoint(x: 0, y: cornerRadius))
                  p.addArc(center: CGPoint(x: cornerRadius, y: cornerRadius),
                              radius: cornerRadius,
                              startAngle: Angle(degrees: 180),
                              endAngle: Angle(degrees: 270),
                              clockwise: false)
        
        return p
            .offsetBy(dx: rect.minX - p.boundingRect.minX, dy: rect.midY - p.boundingRect.midY)
        
     }
}
