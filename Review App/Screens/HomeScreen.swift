//
//  HomeScreen.swift
//  Review App
//
//  Created by Bilal Ahmed on 21/02/2023.
//

import SwiftUI
import Kingfisher

struct HomeScreen: View {
    @State var search = ""
    @StateObject var getAllUsers : GetAllUsersApi = GetAllUsersApi()
    
    @State var usersList: [GetAllUsersDocsModel] = []


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
                
                if(self.getAllUsers.isLoading){

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
                
                else if(self.getAllUsers.isApiCallDone && (!self.getAllUsers.isApiCallSuccessful)){
                    
                    VStack{
                        
                        
                        Spacer()
                        
                        Text("Unable to access internet.")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                        
                        Button(action: {
                            withAnimation{
                                self.getAllUsers.getAllUsers()
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
                
                
                else if(self.getAllUsers.isApiCallDone && self.getAllUsers.isApiCallSuccessful){
                    
                    if(self.getAllUsers.dataRetrivedSuccessfully){
                        
                        ScrollView(.vertical, showsIndicators: false){
                            LazyVStack{
                                ForEach(self.getAllUsers.apiResponse!.docs.indices, id: \.self){index in
                                    
                                    HStack{
                                        KFImage(URL(string: self.getAllUsers.apiResponse!.docs[index].profileImage))
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 75, height: 75)
                                            .clipShape(Circle())
                                        
                                        VStack(alignment: .leading){
                                            
                                            Text("\(self.getAllUsers.apiResponse!.docs[index].firstname) \(self.getAllUsers.apiResponse!.docs[index].lastname)")
                                                .foregroundColor(.black)
                                                .font(AppFonts.ceraPro_16)
                                            
                                            Text("\(self.getAllUsers.apiResponse!.docs[index].tagline)")
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
                                 
                                       
                                    
                                   
                                }
                            }
                            .padding(.leading,20)
                            .padding(.trailing,20)
                            .padding(.top,10)
                            
                        }
                    }
                    
                    else{
                        VStack{
                            
                            Spacer()
                            
                            Text("Unable to get Users.")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                            
                            Button(action: {
                                withAnimation{
                                    self.getAllUsers.getAllUsers()
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
        }
        .onAppear{
            self.getAllUsers.getAllUsers()
        }
    }
}


