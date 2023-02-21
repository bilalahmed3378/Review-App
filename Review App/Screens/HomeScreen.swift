//
//  HomeScreen.swift
//  Review App
//
//  Created by Bilal Ahmed on 21/02/2023.
//

import SwiftUI

struct HomeScreen: View {
    @State var search = ""
    var body: some View {
        ZStack{
            VStack{
                TextField("Search user name here", text: self.$search)
                    .foregroundColor(AppColors.textColor)
                    .font(AppFonts.ceraPro_16)
                    .padding(15)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(AppColors.textColor))
                    .overlay(
                        HStack{
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
                                .padding(.trailing,20)
                        }
                    )
                    .padding(.leading,20)
                    .padding(.trailing,20)
                    .padding(.top,10)
                
                ScrollView(){
                    LazyVStack{
                        ForEach(0...5, id: \.self){index in
                            
                            NavigationLink(destination: {
                                UserProfileScreen()
                            }, label: {
                                HStack{
                                    Image(uiImage: UIImage(named: AppImages.profilePic)!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 75, height: 75)
                                        .clipShape(Circle())
                                    
                                    VStack(alignment: .leading){
                                        Text("Salman Ahmed")
                                            .foregroundColor(.black)
                                            .font(AppFonts.ceraPro_16)
                                        
                                        Text("Be the best of whatever you are")
                                            .foregroundColor(AppColors.textColor)
                                            .font(AppFonts.ceraPro_14)
                                            .padding(.top,2)
                                        
                                        HStack{
                                            Spacer()
                                            
                                            HStack{
                                                
                                                Image(systemName: "star.fill")
                                                    .resizable()
                                                    .aspectRatio( contentMode: .fit)
                                                    .frame(width: 10, height: 10)
                                                    .foregroundColor(.yellow)
                                                    .padding(.trailing,2)
                                                
                                                Image(systemName: "star.fill")
                                                    .resizable()
                                                    .aspectRatio( contentMode: .fit)
                                                    .frame(width: 10, height: 10)
                                                    .foregroundColor(.yellow)
                                                    .padding(.trailing,2)
                                                
                                                Image(systemName: "star.fill")
                                                    .resizable()
                                                    .aspectRatio( contentMode: .fit)
                                                    .frame(width: 10, height: 10)
                                                    .foregroundColor(.yellow)
                                                    .padding(.trailing,2)
                                                
                                                Image(systemName: "star.fill")
                                                    .resizable()
                                                    .aspectRatio( contentMode: .fit)
                                                    .frame(width: 10, height: 10)
                                                    .foregroundColor(.yellow)
                                                    .padding(.trailing,2)
                                                
                                                Image(systemName: "star.fill")
                                                    .resizable()
                                                    .aspectRatio( contentMode: .fit)
                                                    .frame(width: 10, height: 10)
                                                    .foregroundColor(.yellow)
                                                    .padding(.trailing,2)
                                                
                                              
                                            }
                                            
                                            Text("(1039)")
                                                .foregroundColor(.black)
                                                .font(AppFonts.ceraPro_14)
                                        }
                                        
                                    }
                                    .padding(.leading,3)
                                }
                                .padding(10)
                                .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                            })
                           
                        }
                    }
                    .padding(.leading,20)
                    .padding(.trailing,20)
                    .padding(.top,10)
                    
                }
            }
        }
    }
}


