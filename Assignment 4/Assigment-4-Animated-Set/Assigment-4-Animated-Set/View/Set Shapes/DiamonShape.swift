//
//  DiamonShape.swift
//  Assigment-4-Animated-Set
//
//  Created by Kevin Martinez on 7/23/23.
//

import SwiftUI

struct DiamonShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        // Constants below represent where the CreateCardContentView Shape will be located in the rectangle
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let width = rect.width
        let height = width / 2
        
        // constant below is where the path to draw will move when we draw this shape on the rect
        
        let topPoint = CGPoint (x: center.x, y: center.y + height / 2)
        let leftPoint = CGPoint (x: center.x - height, y: center.y)
        let rightPoint = CGPoint (x: center.x + height, y: center.y)
        let bottomPoint = CGPoint (x: center.x, y: center.y - height / 2)
        
        p.move(to: topPoint)
        p.addLine(to: leftPoint)
        p.addLine(to: bottomPoint)
        p.addLine(to: rightPoint )
        p.addLine(to: topPoint)
        
        return p
    }
}

