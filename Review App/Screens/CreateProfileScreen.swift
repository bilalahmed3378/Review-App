//
//  CreateProfileScreen.swift
//  Review App
//
//  Created by Bilal Ahmed on 21/02/2023.
//

import SwiftUI

struct CreateProfileScreen: View {
    
    @State var name = ""
    @State var tagLine = ""
    @State var Description = ""

    @State var coverPhoto : Image? = nil
    
    @State var profilePhoto : Image? = nil
    
    @State var showBottomSheet: Bool = false

    @State var isProfileImage : Bool = false

    
    var body: some View {
        ZStack{
            
                Color.white
                .ignoresSafeArea(edges: .bottom)
                
            ScrollView(.vertical, showsIndicators: false){
                
                VStack{
                    
                        Group{
                            Spacer()
                            //screen name
                            HStack{
                               
                                Text("Profile")
                                    .foregroundColor(.black)
                                    .font(AppFonts.ceraPro_24)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            
                            HStack{
                                Text("Create your profile to view and rate others profile")
                                    .foregroundColor(.black)
                                    .font(AppFonts.ceraPro_16)
                                
                                Spacer()
                            }
                            .padding(.top,5)
                            
                            
                            HStack{
                                if(self.profilePhoto != nil){
                                    profilePhoto?
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 75, height: 75)
                                        .clipShape(Circle())
                                    
                                }
                                else{
                                    Image(uiImage: UIImage(named: AppImages.profilePic)!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 75, height: 75)
                                        .clipShape(Circle())
                                }
                                
                                Button(action: {
                                    self.showBottomSheet = true
                                    self.isProfileImage = true
                                }, label: {
                                    Image(systemName: "square.and.arrow.up")
                                        .resizable()
                                        .aspectRatio( contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(AppColors.appPrimaryColor)
                                        .padding(.leading,5)
                                    
                                    Text("Upload Profile")
                                        .foregroundColor(AppColors.appPrimaryColor)
                                        .font(AppFonts.ceraPro_16)
                                })
                              
                                
                                Spacer()
                            }
                            .padding(.top,20)
                        }
                        
                    Button(action: {
                        self.showBottomSheet = true
                        self.isProfileImage = false
                    }, label: {
                        if(self.coverPhoto != nil){
                            coverPhoto?
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.screenWidth - 40, height: 200)
                                .cornerRadius(10)
                                .padding(.top,20)
                            
                        }else{
                            Image(uiImage: UIImage(named: AppImages.profileCoverPic)!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.screenWidth - 40, height: 200)
                                .cornerRadius(10)
                                .padding(.top,20)
                        }
                    })
                   
                        
                        HStack{
                            Text("Name")
                                .foregroundColor(.black)
                                .font(AppFonts.ceraPro_16)
                                .fontWeight(.bold)
                            
                            Spacer()
                        }
                        .padding(.top,20)
                        
                        
                        
                        TextField("Enter your full name", text: self.$name)
                            .foregroundColor(AppColors.textColor)
                            .padding(15)
                            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(AppColors.textColor))
                        
                        
                        HStack{
                            Text("Tagline")
                                .foregroundColor(.black)
                                .font(AppFonts.ceraPro_16)
                                .fontWeight(.bold)
                            
                            Spacer()
                        }
                        .padding(.top,20)
                        
                        
                        
                        TextField("Add a Tagline", text: self.$tagLine)
                            .foregroundColor(AppColors.textColor)
                            .padding(15)
                            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(AppColors.textColor))
                        
                        
                        
                        HStack{
                            Text("Description")
                                .foregroundColor(.black)
                                .font(AppFonts.ceraPro_16)
                                .fontWeight(.bold)
                            
                            Spacer()
                        }
                        .padding(.top,20)
                        
                        
                    ZStack{
                        Color.white
                        
                        TextEditor(text: $Description)
                            .foregroundColor(AppColors.textColor)
                            .padding(10)
                            .frame(height: 150)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(AppColors.textColor, lineWidth: 1)
                            )
                            .overlay(
                                
                                VStack{
                                    HStack{
                                        if(self.Description.isEmpty){
                                            Text("Add description")
                                                .font(AppFonts.ceraPro_16)
                                                .foregroundColor(AppColors.textColor)
                                        }
                                        Spacer()
                                    }
                                    .padding(.top,15)
                                    .padding(.leading,10)
                                    Spacer()
                                }
                                
                            )
                    }
                        
                      
                        
                        NavigationLink(destination: {
                            MainTabContainer()
                        }, label: {
                            BlueButton(lable: "Create Profile")
                                .padding(.top,20)
                                .padding(.bottom,10)
                        })
                      
                        
                    }
                    .padding(.leading,20)
                    .padding(.trailing,20)
                  
                    
                }
            .padding(.top,10)
              
            
        }
        .navigationBarHidden(true)
        .sheet(isPresented: self.$showBottomSheet) {
            
            ImagePicker(sourceType: .photoLibrary) { image in
                
                if(self.isProfileImage){
                    self.profilePhoto = Image(uiImage: image)

                }
                
                else{
                    self.coverPhoto = Image(uiImage: image)

                }
                     
            }
            
        }
    }
}

