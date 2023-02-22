//
//  Toast.swift
//  cars conneted
//
//  Created by Bilal Ahmed on 13/12/2022.
//

import Foundation
import SwiftUI

struct Toast: View {
    
    @Binding var isShowing : Bool
    let message : String
    
    var body: some View {
        
        VStack{
            
            
            VStack(alignment:.leading){
                
                
                HStack{
                    
                    
                    
                    
                    Spacer()
                    
                    
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20,alignment:.center)
                        .foregroundColor(.red)
                        .onTapGesture(perform: {
                            isShowing = false
                        })
                }
                
                Text(self.message)
                    .font(AppFonts.ceraPro_14)
                    .foregroundColor(.black)
                    .padding(.bottom,10)
                    .padding(.top , 5)
            }
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 0).fill(.white))
            .cornerRadius(10.0)
            .padding(.top , 60)
            .padding(.leading , 20)
            .padding(.trailing , 20)
            .shadow(radius: 10,  y: 10)
            
            Spacer()
            
          
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if(self.isShowing){
                    isShowing.toggle()
                }
            }
        })
    }
    
}
