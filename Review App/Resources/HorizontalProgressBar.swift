//
//  HorizontalProgressBar.swift
//  MeccaFitnessPro
//
//  Created by CodeCue on 14/05/2022.
//

import SwiftUI


struct HorizontalProgressBar: View {
    
    let progress : Float

    let color : Color

    let backgroundColor : Color

    let totalProgress : Float
    
    init(color : Color = AppColors.appPrimaryColor , totalProgress : Float = 100.0 , progress : Float , backgroundColor : Color = AppColors.textColor) {
        self.color = color
        self.totalProgress = totalProgress
        self.progress = progress
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(self.backgroundColor)
                
                Rectangle().frame(width: ((geometry.size.width/CGFloat(self.totalProgress))*CGFloat(self.progress)), height: geometry.size.height)
                    .foregroundColor(color)
                    .cornerRadius(45.0)
                    .animation(.linear)
                
            }.cornerRadius(45.0)
        }
    }
}
