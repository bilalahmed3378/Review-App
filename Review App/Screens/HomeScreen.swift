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
                            .padding(.top,10)
                            .padding(.leading,20)
                            .padding(.trailing,20)
                        
                        
                        ScrollView(.vertical, showsIndicators: false){
                            VStack{
                                
                               
                                
                                LazyVStack{
                                    ForEach(self.getAllUsers.apiResponse!.docs.indices, id: \.self){index in
                                        
                                        
                                        AllUsers(userList: self.getAllUsers.apiResponse!.docs[index])
                                            .padding(.top,1)
                                        
                                    }
                                }
                                
                            }
                            .padding(.leading,20)
                            .padding(.trailing,20)
                            .padding(.top,10)
                            .padding(.bottom,80)
                            
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
                
                else{
                    
                    VStack{
                        
                        Spacer()
                        
                        Text("Unable to get users.")
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
        .onAppear{
            self.getAllUsers.getAllUsers()
        }
    }
    
   
}


struct AllUsers : View{
    @State var toDetail : Bool = false

    let userList : GetAllUsersDocsModel
    
    var body: some View{
        
        NavigationLink(destination: UserProfileScreen(user_id: self.userList._id), isActive: self.$toDetail){
            EmptyView()
        }
        
        Button(action: {
            self.toDetail = true
        }, label: {
            HStack{
                KFImage(URL(string: self.userList.profileImage))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                
                VStack(alignment: .leading){
                    
                    Text("\(self.userList.firstname) \(self.userList.lastname)")
                        .foregroundColor(.black)
                        .font(AppFonts.ceraPro_16)
                    
                    Text("\(self.userList.tagline)")
                        .foregroundColor(AppColors.textColor)
                        .font(AppFonts.ceraPro_14)
                        .padding(.top,2)
                    
               
                    
                }
                .padding(.leading,3)
                
                Spacer()
            }
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
            .padding(.top,10)
         
        })
        
           
    }
    
    
}
