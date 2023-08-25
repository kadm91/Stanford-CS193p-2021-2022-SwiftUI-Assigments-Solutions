//
//  CircularProgressStyle.swift
//  Assigment-4-Animated-Set
//
//  Created by Kevin Martinez on 7/23/23.
//

import SwiftUI


 struct CircularProgressViewStyle: ProgressViewStyle {
    
     func makeBody(configuration: LinearProgressViewStyle.Configuration) -> some View {
     
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .foregroundColor(.gray)
                    .opacity(0.2)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(configuration.fractionCompleted ?? 0))
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.accentColor)
                  
                
                let percentage = Int((configuration.fractionCompleted ?? 0) * 100)
            
                Text("\(percentage)%")
                    
                
                
            }
            
            .frame(width: 60, height: 60)
        
    }
}

struct CircularProgressStyle_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView("0.0%", value: 76, total: 100)
            .progressViewStyle(CircularProgressViewStyle())
    }
}
