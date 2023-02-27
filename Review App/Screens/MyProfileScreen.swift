//
//  MyProfileScreen.swift
//  Review App
//
//  Created by Bilal Ahmed on 21/02/2023.
//
import Foundation
import SwiftUI
import Kingfisher

struct MyProfileScreen: View {
    
    @StateObject var getProfileApi = GetProfileApi()
    @StateObject var getReviews = GetReviewsApi()

    let dateFormatter = ISO8601DateFormatter()

    @State var isLoadingFirstTime = true
    
    @Binding var isUserLoggedIn : Bool
    
    @State var currentDate = ""
    
    init(isUserLoggedIn : Binding<Bool>){
        self._isUserLoggedIn = isUserLoggedIn
    }

    
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
                      LogoutScreen(isUserLoggedIn: self.$isUserLoggedIn)
                  }, label: {
                      Image(systemName: "rectangle.portrait.and.arrow.right")
                          .resizable()
                          .aspectRatio( contentMode: .fit)
                          .frame(width: 20, height: 20)
                          .foregroundColor(.red)
                          .padding(.trailing,5)
                  
                  })
                       
                    
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
                
                if(self.getProfileApi.isLoading){

                    VStack{

                        Spacer()

                        HStack{

                            Spacer()

                            ProgressView()
                                .padding()
                                .onDisappear{
                                    
//                                        self.getReviews.getReviews(id: self.getProfileApi.apiResponse!.docs!._id)
                                    self.getReviews.getReviews(id: "63edd1c7d0f679057597fe19")

                                    
                                    
                                    
                                }


                            Spacer()

                        }


                        Spacer()

                    }


                }
                
                else if(self.getProfileApi.isApiCallDone && (!self.getProfileApi.isApiCallSuccessful)){
                    
                    VStack{
                        
                        
                        Spacer()
                        
                        Text("Unable to access internet.")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                        
                        Button(action: {
                            withAnimation{
                                self.getProfileApi.getProfile()
                            }
                        }){
                            Text("Try Agin")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 5).fill(.blue))
                            
                        }
                        .padding(.top,30)
                        
                        Spacer()
                        
                    }
                }
                
                else if(self.getProfileApi.isApiCallDone && self.getProfileApi.isApiCallSuccessful && (!self.getProfileApi.dataRetrivedSuccessfully)){
                    
                    VStack{
                        
                        Spacer()
                        
                        Text("Unable to get profile.")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                        
                        Button(action: {
                            withAnimation{
                                self.getProfileApi.getProfile()
                            }
                        }){
                            Text("Try Agin")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 5).fill(.blue))
                            
                        }
                        .padding(.top,30)
                        
                        Spacer()
                        
                    }
                    
                }
                
                else if(self.getProfileApi.isApiCallDone && self.getProfileApi.isApiCallSuccessful){
                    
                    if(self.getProfileApi.dataRetrivedSuccessfully){
                        
                        ScrollView(.vertical, showsIndicators: false){
                            VStack{
                                ZStack(alignment: .top){
                                    KFImage(URL(string: self.getProfileApi.apiResponse!.docs!.coverImage))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: UIScreen.screenWidth - 40, height: 200)
                                        .cornerRadius(10)
                                        .padding(.top,20)
                                    
                                    VStack{
                                        Spacer()
                                        
                                        KFImage(URL(string: self.getProfileApi.apiResponse!.docs!.profileImage))
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 75, height: 75)
                                            .clipShape(Circle())
                                    }
                                    
                                }
                                .frame(height: 250)
                                
                                Text("\(self.getProfileApi.apiResponse!.docs!.firstname) \(self.getProfileApi.apiResponse!.docs!.lastname)")
                                    .foregroundColor(.black)
                                    .font(AppFonts.ceraPro_20)
                                    .fontWeight(.bold)
                                    .padding(.top,5)
                                    
                                
                                Text("\(self.getProfileApi.apiResponse!.docs!.tagline)")
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
                                    Text("\(self.getProfileApi.apiResponse!.docs!.description)")
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
                                
                                if(self.getReviews.isLoading){

                                    VStack{

                                        Spacer()

                                        HStack{

                                            Spacer()

                                            ProgressView()
                                                .padding()


                                            Spacer()

                                        }


                                        Spacer()

                                    }


                                }
                                
                                else if(self.getReviews.isApiCallDone && (!self.getReviews.isApiCallSuccessful)){
                                    
                                    VStack{
                                        
                                        
                                        Spacer()
                                        
                                        Text("Unable to access internet.")
                                            .font(.system(size: 14))
                                            .foregroundColor(.black)
                                        
                                        Button(action: {
                                            withAnimation{
                                                if !(self.getProfileApi.apiResponse!.docs!._id.isEmpty){
                                                    self.getReviews.getReviews(id: self.getProfileApi.apiResponse!.docs!._id)
                                                }                                            }
                                        }){
                                            Text("Try Agin")
                                                .font(.system(size: 14))
                                                .foregroundColor(.white)
                                                .padding()
                                                .background(RoundedRectangle(cornerRadius: 5).fill(.blue))
                                            
                                        }
                                        .padding(.top,30)
                                        
                                        Spacer()
                                        
                                    }
                                }

                                else if(self.getReviews.isApiCallDone && self.getReviews.isApiCallSuccessful){
                                    
                                    if(self.getReviews.dataRetrivedSuccessfully){
                                        
                                        LazyVStack{
                                            ForEach(self.getReviews.apiResponse!.docs!.indices, id: \.self){index in
                                                
                                                HStack(alignment: .top){
                                                    KFImage(URL(string: self.getReviews.apiResponse!.docs![index].reviewerId!.profileImage))
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 40, height: 40)
                                                        .clipShape(Circle())
                                                    
                                                    VStack(alignment: .leading){
//                                                        let date = dateFormatter.date(from: self.getReviews.apiResponse!.docs![index].createdAt)

                                                        HStack{
                                                            Text("\(self.getReviews.apiResponse!.docs![index].reviewFor!.firstname) \(self.getReviews.apiResponse!.docs![index].reviewFor!.lastname)")
                                                                .foregroundColor(.black)
                                                                .font(AppFonts.ceraPro_16)
                                                                .fontWeight(.bold)
                                                            
                                                            Spacer()
                                                            
                                                            Text(self.currentDate)
                                                                .foregroundColor(AppColors.textColor)
                                                                .font(AppFonts.ceraPro_14)
                                                                .onAppear{
                                                                    
                                                                  let arr  = self.getReviews.apiResponse!.docs![index].createdAt.split(separator: "T")
                                                                    
                                                                    self.currentDate = String(arr[0])
                                                                    
                                                                }

                                                           
                                                            
                                                        }
                                                        
                                                    
                                                        
                                                        RatingView(rating: Double(self.getReviews.apiResponse!.docs![index].ratings))
                                                            .padding(.top,3)
                                                        
                                                        Text("\(self.getReviews.apiResponse!.docs![index].message)")
                                                            .foregroundColor(.black)
                                                            .font(AppFonts.ceraPro_14)
                                                            .fontWeight(.ultraLight)
                                                            .padding(.top,3)
                                                        
                                                    }
                                                    
                                                }
                                                .padding(.top,20)
                                            }
                                        }
                                    }
                                    
                                    else{
                                        VStack{
                                            
                                            Spacer()
                                            
                                            Text("No Review Available")
                                                .font(.system(size: 14))
                                                .foregroundColor(.black)
                                            
                                           
                                            
                                            Spacer()
                                            
                                        }
                                    }
                                    
                                }
                                
                                else{
                                    
                                    VStack{
                                        
                                        Spacer()
                                        
                                        Text("Unable to get reviews.")
                                            .font(.system(size: 14))
                                            .foregroundColor(.black)
                                        
                                        Button(action: {
                                            withAnimation{
                                                if !(self.getProfileApi.apiResponse!.docs!._id.isEmpty){
                                                    self.getReviews.getReviews(id: self.getProfileApi.apiResponse!.docs!._id)
                                                }                                            }
                                        }){
                                            Text("Try Agin")
                                                .font(.system(size: 14))
                                                .foregroundColor(.white)
                                                .padding()
                                                .background(RoundedRectangle(cornerRadius: 5).fill(.blue))
                                            
                                        }
                                        .padding(.top,30)
                                        
                                        Spacer()
                                        
                                    }
                                    
                                }
                                
                               
                               
                            }
                            .padding(.leading,20)
                            .padding(.trailing,20)
                            .padding(.bottom,80)
                        }
                    }
                    
                    else{
                        VStack{
                            
                            Spacer()
                            
                            Text("Unable to get support tickets.")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                            
                            Button(action: {
                                withAnimation{
                                    self.getProfileApi.getProfile()

                                }
                            }){
                                Text("Try Agin")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 5).fill(.blue))
                                
                            }
                            .padding(.top,30)
                            
                            Spacer()
                            
                        }
                    }
                }
                
                else{
                    
                    VStack{
                        
                        Spacer()
                        
                        Text("Unable to get profile.")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                        
                        Button(action: {
                            withAnimation{
                                self.getProfileApi.getProfile()
                            }
                        }){
                            Text("Try Agin")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 5).fill(.blue))
                            
                        }
                        .padding(.top,30)
                        
                        Spacer()
                        
                    }
                    
                }
                
                
            }
        }
        .navigationBarHidden(true)
        .onAppear{
            
            if(self.isLoadingFirstTime){
                
                self.getProfileApi.getProfile()
                
                self.isLoadingFirstTime = false
                
            }
        }
    }
}


