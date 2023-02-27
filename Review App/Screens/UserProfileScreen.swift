//
//  UserProfileScreen.swift
//  Review App
//
//  Created by Bilal Ahmed on 21/02/2023.
//

import SwiftUI

struct UserProfileScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var getUserProfileApi = GetUserProfileDetailsApi()


    @State var description = ""
    @State var writeReview = ""

    @State var showSheet : Bool = false
    @State var reviewSheet : Bool = false

    let  user_id : String
   
    
    init(user_id : String){
        self.user_id = user_id
    }
    
    
    
    var body: some View {
        ZStack{
            
            VStack{
                
                HStack{
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "arrowshape.turn.up.backward")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(AppColors.appPrimaryColor)
                    })
                    
                    Spacer()
                   
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
                            
                            Text("See All")
                                .foregroundColor(AppColors.appPrimaryColor)
                                .font(AppFonts.ceraPro_14)
                            
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
                                        
                                        HStack{
                                            Text("06 replies")
                                                .foregroundColor(AppColors.appPrimaryColor)
                                                .font(AppFonts.ceraPro_14)
                                            
                                            Spacer()
                                            
                                            
                                            Image(systemName: "hand.thumbsdown.fill")
                                                .resizable()
                                                .aspectRatio( contentMode: .fit)
                                                .frame(width: 16, height: 16)
                                                .foregroundColor(.red)
                                            
                                            Text("6")
                                                .foregroundColor(.red)
                                                .font(AppFonts.ceraPro_14)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "hand.thumbsup.fill")
                                                .resizable()
                                                .aspectRatio( contentMode: .fit)
                                                .frame(width: 16, height: 16)
                                                .foregroundColor(.blue)
                                            
                                            Text("6")
                                                .foregroundColor(.blue)
                                                .font(AppFonts.ceraPro_14)
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                self.showSheet = true
                                                self.reviewSheet = false
                                            }, label: {
                                                Image(systemName: "arrowshape.turn.up.left.fill")
                                                    .resizable()
                                                    .aspectRatio( contentMode: .fit)
                                                    .frame(width: 16, height: 16)
                                                    .foregroundColor(.blue)
                                                
                                                Text("Reply")
                                                    .foregroundColor(.blue)
                                                    .font(AppFonts.ceraPro_14)
                                            })
                                          
                                            
                                            
                                        }
                                    }
                                    
                                }
                                .padding(.top,20)
                            }
                        }
                        
                        Button(action: {
                            self.showSheet = true
                            self.reviewSheet = true
                        }, label: {
                            BlueButton(lable: "Write a review")
                                .padding(.top,30)
                        })
                       
                       
                    }
                    .padding(.leading,20)
                    .padding(.trailing,20)
                    .padding(.bottom,20)
                }
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: self.$showSheet){
            if(self.reviewSheet){
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        
                        HStack{
                            Image(uiImage: UIImage(named: AppImages.profilePic)!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading){
                                HStack{
                                    Text("Salman Ahmed")
                                        .foregroundColor(.black)
                                        .font(AppFonts.ceraPro_16)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        self.showSheet = false
                                    }, label: {
                                        Image(systemName: "xmark.circle")
                                            .resizable()
                                            .aspectRatio( contentMode: .fit)
                                            .frame(width: 18, height: 18)
                                        
                                    })
                                
                                }
                                
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
                        .padding(.top,10)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                        
                        
                        HStack{
                            
                            Image(systemName: "star.fill")
                                .resizable()
                                .aspectRatio( contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.yellow)
                                .padding(.trailing,2)
                            
                            
                            Image(systemName: "star.fill")
                                .resizable()
                                .aspectRatio( contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.yellow)
                                .padding(.trailing,2)
                            
                            Image(systemName: "star.fill")
                                .resizable()
                                .aspectRatio( contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.yellow)
                                .padding(.trailing,2)
                            
                            Image(systemName: "star.fill")
                                .resizable()
                                .aspectRatio( contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.yellow)
                                .padding(.trailing,2)
                            
                            Image(systemName: "star.fill")
                                .resizable()
                                .aspectRatio( contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.yellow)
                                .padding(.trailing,2)
                            
                            
                            
                            
                        }
                        .padding(.top,20)
                        
                        Text("Excellent!")
                            .foregroundColor(.black)
                            .font(AppFonts.ceraPro_14)
                            .padding(.top,20)
                        
                        HStack{
                            
                            Text("Review")
                                .foregroundColor(.black)
                                .font(AppFonts.ceraPro_16)
                            
                            Spacer()
                        }
                        .padding(.top,20)
                        .padding(.leading,20)
                        .padding(.trailing,20)
                        
                        
                        
                        TextEditor(text: $writeReview)
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
                                        if(self.description.isEmpty){
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
                            .padding(.leading,20)
                            .padding(.trailing,20)
                        
                        
                        BlueButton(lable: "SUBMIT")
                            .padding(.top,20)
                            .padding(.leading,20)
                            .padding(.trailing,20)
                        
                        Spacer()
                        
                    }
                }
            }
            else{
                VStack{
                    ScrollView(.vertical, showsIndicators: false){
                        
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
                                
                                HStack{
                                    Text("06 replies")
                                        .foregroundColor(AppColors.appPrimaryColor)
                                        .font(AppFonts.ceraPro_14)
                                    
                                    Spacer()
                                    
                                    
                                    Image(systemName: "hand.thumbsdown.fill")
                                        .resizable()
                                        .aspectRatio( contentMode: .fit)
                                        .frame(width: 16, height: 16)
                                        .foregroundColor(.red)
                                    
                                    Text("6")
                                        .foregroundColor(.red)
                                        .font(AppFonts.ceraPro_14)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "hand.thumbsup.fill")
                                        .resizable()
                                        .aspectRatio( contentMode: .fit)
                                        .frame(width: 16, height: 16)
                                        .foregroundColor(.blue)
                                    
                                    Text("6")
                                        .foregroundColor(.blue)
                                        .font(AppFonts.ceraPro_14)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "arrowshape.turn.up.left.fill")
                                        .resizable()
                                        .aspectRatio( contentMode: .fit)
                                        .frame(width: 16, height: 16)
                                        .foregroundColor(.blue)
                                    
                                    Text("Reply")
                                        .foregroundColor(.blue)
                                        .font(AppFonts.ceraPro_14)
                                    
                                    
                                }
                            }
                            
                        }
                        .padding(.top,20)
                        .padding(.leading,20)
                        .padding(.trailing,20)
                        
                        Divider()
                            .padding(.top,5)
                            .padding(.bottom,10)
                        
                        HStack{
                            
                            Text("Review (1045)")
                                .foregroundColor(.black)
                                .font(AppFonts.ceraPro_16)
                                .fontWeight(.bold)
                            
                            Spacer()
                          
                            
                        }
                        .padding(.leading,20)
                        .padding(.trailing,20)
                        
                        LazyVStack{
                            ForEach(0...3, id: \.self){index in
                                HStack{
                                    Spacer()
                                    Text("abc**kj")
                                        .foregroundColor(AppColors.textColor)
                                }
                                .padding(.leading,20)
                                .padding(.trailing,20)
                                .padding(.top,10)
                                
                                
                                HStack{
                                    Text("l Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.")
                                        .font(AppFonts.ceraPro_14)
                                        .foregroundColor(AppColors.textColor)
                                        .padding(15)
                                }
                                    .frame(width: UIScreen.screenWidth - 40)
                                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(AppColors.textColor))
                                
                                Divider()
                            }
                        }
                        
                      
                        HStack{
                            TextEditor(text: $description)
                                .foregroundColor(AppColors.textColor)
                                .padding(10)
                                .frame(height: 100)
                                .overlay(
                                
                                VStack{
                                    HStack{
                                        if(self.description.isEmpty){
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
                            
                            Image(systemName: "paperplane.fill")
                                .resizable()
                                .aspectRatio( contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(AppColors.appPrimaryColor)
                                .padding(.trailing,5)
                            
                            
                        }
                        .background(RoundedRectangle(cornerRadius: 10)
                            .stroke(AppColors.textColor, lineWidth: 1))
                        .padding(.leading,20)
                        .padding(.trailing,20)
                        .padding(.top,20)
                    }
                 
                }
            }
            
        }
        .onAppear{
            self.getUserProfileApi.getUserProfile(id: self.user_id)
        }
    }
}


