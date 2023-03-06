//
//  EditProfileScreen.swift
//  Review App
//
//  Created by Bilal Ahmed on 21/02/2023.
//

import SwiftUI
import Kingfisher

struct EditProfileScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var editProfileDataApi = EditProfileApi()
    
    @StateObject var getProfileApi = GetProfileApi()
    



    @State var showToast : Bool = false
    
    @State var profilePicked : Bool = false
    
    @State var coverPicked : Bool = false



    
    @State var toastMessage : String = ""
    
    

    

    @State var firstName = ""
    @State var lastName = ""

    @State var tagLine = ""
    @State var Description = ""

    @State var coverPhoto : UIImage? = nil
    
    @State var profilePhoto : UIImage? = nil
    
    @State var showBottomSheet: Bool = false

    @State var isProfileImage : Bool = false
    


    
    var body: some View {
        ZStack{
            
                Color.white
                .ignoresSafeArea(edges: .bottom)
            
            VStack{
                
                HStack{
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        
                    }, label: {
                        Image(systemName: "arrowshape.turn.up.backward")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.black)
                            .frame(width: 20, height: 20)
                    })
                    
                    Spacer()
                }
                .padding(.top,5)
                .padding(.leading,20)
                
                
                if(self.getProfileApi.isLoading){
                    
                    VStack{
                        
                        Spacer()
                        
                        HStack{
                            
                            Spacer()
                            
                            ProgressView()
                                .padding()
                                .onDisappear{
                                    self.tagLine = self.getProfileApi.apiResponse!.docs!.tagline
                                    self.Description = self.getProfileApi.apiResponse!.docs!.description
                                    self.firstName = self.getProfileApi.apiResponse!.docs!.firstname
                                    self.lastName = self.getProfileApi.apiResponse!.docs!.lastname
                                    
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
                
                else if(self.getProfileApi.isApiCallDone && self.getProfileApi.isApiCallSuccessful){
                    
                    if(self.getProfileApi.dataRetrivedSuccessfully){
                        VStack{
                           
                            
                            ScrollView(.vertical, showsIndicators: false){
                                
                                VStack{
                                    
                                    Group{
                                        
                                        
                                        
                                        //screen name
                                        HStack{
                                            
                                            Text("Edit Profile")
                                                .foregroundColor(.black)
                                                .font(AppFonts.ceraPro_24)
                                                .fontWeight(.bold)
                                            Spacer()
                                        }
                                        
                                        HStack{
                                            Text("Update your profile to view and rate others profile")
                                                .foregroundColor(.black)
                                                .font(AppFonts.ceraPro_16)
                                            
                                            Spacer()
                                        }
                                        .padding(.top,15)
                                        
                                        
                                        HStack{
                                            
                                            if(self.profilePicked == false){

                                                KFImage(URL(string: self.getProfileApi.apiResponse!.docs!.profileImage))
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 75, height: 75)
                                                    .clipShape(Circle())
                                            }
                                            else{
                                                
                                                Image(uiImage: self.profilePhoto!)
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
                                        
                                        if(coverPicked == false){
                                            
                                            KFImage(URL(string: self.getProfileApi.apiResponse!.docs!.coverImage))
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: UIScreen.screenWidth - 40, height: 200)
                                                    .cornerRadius(10)
                                                    .padding(.top,20)
                                        }
                                        else{
                                            
                                            Image(uiImage: self.coverPhoto!)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: UIScreen.screenWidth - 40, height: 200)
                                            .cornerRadius(10)
                                            .padding(.top,20)
                                        }
                                      
                                            
                                        
                                       
                                    })
                                    
                                    Group{
                                        
                                        HStack{
                                            Text("First Name")
                                                .foregroundColor(.black)
                                                .font(AppFonts.ceraPro_16)
                                                .fontWeight(.bold)
                                            
                                            Spacer()
                                        }
                                        .padding(.top,20)
                                        
                                        
                                        
                                        TextField("Enter your first name", text: self.$firstName)
                                            .foregroundColor(AppColors.textColor)
                                            .padding(15)
                                            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(AppColors.textColor))
                                        
                                        
                                        HStack{
                                            Text("Last Name")
                                                .foregroundColor(.black)
                                                .font(AppFonts.ceraPro_16)
                                                .fontWeight(.bold)
                                            
                                            Spacer()
                                        }
                                        .padding(.top,20)
                                        
                                        
                                        
                                        TextField("Enter your last name", text: self.$lastName)
                                            .foregroundColor(AppColors.textColor)
                                            .padding(15)
                                            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(AppColors.textColor))
                                    }
                                    
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
                                    
                                    
                                    
                                    if(self.editProfileDataApi.isLoading){
                                        ProgressView()
                                            .padding(20)
                                            .onDisappear{
                                                
                                                if(self.editProfileDataApi.isApiCallDone && (!self.editProfileDataApi.isApiCallSuccessful)){
                                                    self.toastMessage = "Unable to access internet. Please check your internet connection and try again."
                                                    self.showToast = true
                                                }
                                                else if (self.editProfileDataApi.isApiCallDone && self.editProfileDataApi.isApiCallSuccessful  && (!self.editProfileDataApi.addedSuccessful)){
                                                    self.toastMessage = "Unable to add profile. Please try again later."
                                                    self.showToast = true
                                                }
                                                else if(self.editProfileDataApi.isApiCallDone && self.editProfileDataApi.isApiCallSuccessful  && self.editProfileDataApi.addedSuccessful){
                                                    AppData().profileSetup()
                                                    self.toastMessage = "Profile Updated successfully"
                                                    self.showToast = true
                                                    
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                        presentationMode.wrappedValue.dismiss()
                                                    }
                                                    
                                                    
                                                    
                                                }
                                                
                                            }
                                    }
                                    else{
                                        Button(action: {
                                            
                                           
                                            if(self.firstName.isEmpty){
                                                self.toastMessage = "Please enter first name."
                                                self.showToast = true
                                            }
                                            else if(self.lastName.isEmpty){
                                                self.toastMessage = "Please enter last name."
                                                self.showToast = true
                                            }
                                            else if(self.tagLine.isEmpty){
                                                self.toastMessage = "Please enter phone number."
                                                self.showToast = true
                                            }
                                            else if(self.Description.isEmpty){
                                                self.toastMessage = "Please select date of birth. Age can't be 0"
                                                self.showToast = true
                                            }
                                            
                                            
                                            else{
                                                
                                                
                                                    
                                                self.editProfileDataApi.editUserProfileData(firstname: self.firstName, lastname: self.lastName, tagline: self.tagLine, description: self.Description, profileImage: self.profilePhoto, coverImage: self.coverPhoto)
                                                    
                                            }
                                        }, label: {
                                            
                                            BlueButton(lable: "Update")
                                                .padding(.top,20)
                                                .padding(.bottom,10)
                                            
                                            
                                            
                                            
                                            
                                        })
                                        .disabled(showToast == true)
                                        
                                        
                                    }
                                    
                                    
                                    
                                }
                                .padding(.leading,20)
                                .padding(.trailing,20)
                                
                                
                            }
                            .padding(.top,10)
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
            
            if(self.showToast){
                Toast(isShowing: self.$showToast, message: self.toastMessage)
            }
            
        }
        .navigationBarHidden(true)
        .sheet(isPresented: self.$showBottomSheet) {
            
            ImagePicker(sourceType: .photoLibrary) { image in
                
                let imageSize = image.getSizeIn(.megabyte)
                
                print("image data size ===> \(imageSize)")
                
                
                
                if(imageSize > 1){
                    self.toastMessage = "Image must be less then 1 mb"
                    self.showToast = true
                }
                
                else{
                    
                    
                    if(self.isProfileImage){
                        self.profilePhoto = image
                        self.profilePicked = true
                    }
                    
                    else{
                        self.coverPhoto = image
                        self.coverPicked = true
                        
                        
                    }
                    
                }
                
            }
            
        }
        .onAppear{
            
                self.getProfileApi.getProfile()
                
        }
       
    }
}

