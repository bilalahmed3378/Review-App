//
//  GradientButton.swift
//  MeccaFitness
//
//  Created by CodeCue on 13/02/2022.
//

import SwiftUI

struct BlueButton: View {
    
    let lable : String
    
    var body: some View {
        
        HStack{
            Spacer()
            Text(lable)
                .foregroundColor(.white)
                .font(AppFonts.ceraPro_14)
            Spacer()
        }
        .padding()
        .background(AppColors.appPrimaryColor)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}


