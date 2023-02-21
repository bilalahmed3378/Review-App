//
//  MyProfileScreen.swift
//  Review App
//
//  Created by Bilal Ahmed on 21/02/2023.
//

import SwiftUI

struct MyProfileScreen: View {
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    
                    Text("My Profile")
                        .foregroundColor(.black)
                        .font(AppFonts.ceraPro_24)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    NavigationLink(destination: {
                        EditProfileScreen()
                    }, label: {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(AppColors.appPrimaryColor)
                    })
                   
                }
                .padding(.leading,20)
                .padding(.trailing,20)
                .padding(.top,5)
                
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        ZStack(alignment: .top){
                            Image(uiImage: UIImage(named: AppImages.profileCoverPic)!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.screenWidth - 40, height: 200)
                                .cornerRadius(10)
                                .padding(.top,20)
                            
                            VStack{
                                Spacer()
                                Image(uiImage: UIImage(named: AppImages.profilePic)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 75, height: 75)
                                    .clipShape(Circle())
                            }
                            
                        }
                        .frame(height: 250)
                        
                        Text("Salman Ahmed")
                            .foregroundColor(.black)
                            .font(AppFonts.ceraPro_20)
                            .fontWeight(.bold)
                            .padding(.top,5)
                            
                        
                        Text("Be the best of whatever you are")
                            .foregroundColor(.black)
                            .font(AppFonts.ceraPro_16)
                            .padding(.top,5)
                        
                            
                        HStack{
                            
                            Text("Description")
                                .foregroundColor(.black)
                                .font(AppFonts.ceraPro_16)
                                .fontWeight(.bold)
                            
                            Spacer()
                        }
                        .padding(.top,20)
                        
                        HStack{
                            Text("l Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.")
                                .font(AppFonts.ceraPro_14)
                                .foregroundColor(AppColors.textColor)
                                .padding(15)
                        }
                            .frame(width: UIScreen.screenWidth - 40)
                            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(AppColors.textColor))
                        
                        HStack{
                            
                            Text("Review (1045)")
                                .foregroundColor(.black)
                                .font(AppFonts.ceraPro_16)
                                .fontWeight(.bold)
                            
                            Spacer()
                        }
                        .padding(.top,20)
                        
                        LazyVStack{
                            ForEach(0...4, id: \.self){index in
                                HStack(alignment: .top){
                                    Image(uiImage: UIImage(named: AppImages.profilePic)!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                    
                                    VStack(alignment: .leading){
                                        
                                        HStack{
                                            Text("Sa*********142")
                                                .foregroundColor(.black)
                                                .font(AppFonts.ceraPro_16)
                                                .fontWeight(.bold)
                                            
                                            Spacer()
                                            
                                            Text("Today")
                                                .foregroundColor(AppColors.textColor)
                                                .font(AppFonts.ceraPro_14)
                                            
                                        }
                                        
                                        HStack{
                                            
                                            Image(systemName: "star.fill")
                                                .resizable()
                                                .aspectRatio( contentMode: .fit)
                                                .frame(width: 14, height: 14)
                                                .foregroundColor(.yellow)
                                                .padding(.trailing,1)
                                            
                                            Image(systemName: "star.fill")
                                                .resizable()
                                                .aspectRatio( contentMode: .fit)
                                                .frame(width: 14, height: 14)
                                                .foregroundColor(.yellow)
                                                .padding(.trailing,1)

                                            
                                            Image(systemName: "star.fill")
                                                .resizable()
                                                .aspectRatio( contentMode: .fit)
                                                .frame(width: 14, height: 14)
                                                .foregroundColor(.yellow)
                                                .padding(.trailing,1)

                                            
                                            Image(systemName: "star.fill")
                                                .resizable()
                                                .aspectRatio( contentMode: .fit)
                                                .frame(width: 14, height: 14)
                                                .foregroundColor(.yellow)
                                                .padding(.trailing,1)

                                            
                                            Image(systemName: "star.fill")
                                                .resizable()
                                                .aspectRatio( contentMode: .fit)
                                                .frame(width: 14, height: 14)
                                                .foregroundColor(.yellow)
                                        }
                                        
                                        Text("Perfect for kepping your feet dry and warm in damp conditions")
                                            .foregroundColor(.black)
                                            .font(AppFonts.ceraPro_14)
                                            .fontWeight(.ultraLight)
                                        
                                    }
                                    
                                }
                                .padding(.top,20)
                            }
                        }
                       
                    }
                    .padding(.leading,20)
                    .padding(.trailing,20)
                    .padding(.bottom,80)
                }
            }
        }
        .navigationBarHidden(true)
    }
}


