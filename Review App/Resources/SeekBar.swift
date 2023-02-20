//
//  SeekBar.swift
//  MeccaFitness
//
//  Created by CodeCue on 21/02/2022.
//

import SwiftUI

struct SeekBar: View {
    
    let lable : String
    let maxRange : CGFloat
    let color : Color
    @Binding var value : Int
    
    @State var drawWidth : CGFloat = UIScreen.screenWidth - 72
    @State var maxDragLimit : CGFloat = UIScreen.screenWidth - 72
    @State var minDragLimit : CGFloat = 0
    
    @State var isLessThenMax : Bool = false
    @State var isLessThen40 : Bool = false
    
    
    
    // from start circle center to end circle center
    @State var totalDragLength : CGFloat = (UIScreen.main.bounds.size.width - 40)
    
    

    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                if (drawWidth <= maxDragLimit && drawWidth >= 0){
                    if(value.translation.width >= 0){
                        if((drawWidth + value.translation.width) >= maxDragLimit){
                            drawWidth = maxDragLimit
                        }
                        else{
                            drawWidth += value.translation.width
                        }
                    }
                    else if (value.translation.width <= 0){
                        if((drawWidth + value.translation.width) <= 0){
                            drawWidth = 0
                        }
                        else{
                            drawWidth += value.translation.width
                        }
                    }
                    
                    if (drawWidth < maxDragLimit){
                        withAnimation{
                            self.isLessThenMax = true
                        }
                    }
                    else{
                        withAnimation{
                            self.isLessThenMax = false
                        }
                    }
                    if(drawWidth <= 40 ){
                        withAnimation{
                            isLessThen40 = true
                        }
                    }
                    else{
                        withAnimation{
                            isLessThen40 = false
                        }
                    }
                    
                    self.value = Int((self.drawWidth/self.maxDragLimit)*maxRange)
                }
            }
            .onEnded { value in
                withAnimation {
                    
                }
            }
    }
    
    
    
    
    
    var body: some View {
        
        ZStack(alignment: .top){
            
            HStack(spacing:0){
                Spacer()
                    .frame(width: drawWidth+24 , height: 8)
                    .background(RoundedRectangle(cornerRadius: 6).fill(self.color))
                    .padding(.leading,8)
                Spacer()
            }
            .frame(width : UIScreen.screenWidth-40 ,height: 8)
            .background(RoundedRectangle(cornerRadius: 6).fill(.gray.opacity(0.2)))
            .padding(.top,4)
            
           
            
            VStack(spacing: 0){
                HStack(spacing:0){
                    
                    HStack{
                        
                    }
                    .frame(width: 16, height: 16)
                    .background(Circle().fill(self.color))
                        
                    Spacer()
                        .frame(width: drawWidth , height: 8)
                    
                    HStack{
                        
                    }
                    .frame(width: 16, height: 16)
                    .background(Circle().fill(self.color))
                    .gesture(drag)
                    
                    if(self.isLessThenMax){
                        Spacer()
                    }
                    
                }
                .frame(width: UIScreen.screenWidth-40, height: 16)
                
                
                
                HStack(spacing:0){
                    
                    Text(self.lable.contains("$") ? "\(self.lable)0" : "0\(self.lable)")
                        .font(AppFonts.ceraPro_12)
                        .foregroundColor(AppColors.textColor)
                        .lineLimit(3)
                        
                    if(self.isLessThen40){
                        Spacer()
                            .frame(width: drawWidth , height: 8)
                    }
                    else{
                        Spacer()
                            .frame(width: self.lable.contains("$") ? drawWidth-20 : drawWidth-40 , height: 8)
                    }
                    
                    Text(self.lable.contains("$") ? "\(self.lable)\(self.value)" : "\(self.value)\(self.lable)")
                        .font(AppFonts.ceraPro_12)
                        .foregroundColor(AppColors.textColor)
                        .lineLimit(3)
                    
                    if(self.isLessThenMax){
                        Spacer()
                    }
                    
                }
                .frame(width: UIScreen.screenWidth-40, height: 16)
                .padding(.top,10)
                
            }
            
        }
        .onAppear{
            withAnimation{
                drawWidth = (CGFloat(self.value)*self.maxDragLimit)/self.maxRange
            }
            if (drawWidth < maxDragLimit){
                withAnimation{
                    self.isLessThenMax = true
                }
            }
            else{
                withAnimation{
                    self.isLessThenMax = false
                }
            }
            if(drawWidth <= 40 ){
                withAnimation{
                    isLessThen40 = true
                }
            }
            else{
                withAnimation{
                    isLessThen40 = false
                }
            }
            
        }
        
        
        
    }
    
}

