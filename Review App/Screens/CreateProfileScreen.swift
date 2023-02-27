//
//  CreateProfileScreen.swift
//  Review App
//
//  Created by Bilal Ahmed on 21/02/2023.
//

import SwiftUI

struct CreateProfileScreen: View {
    
    @ObservedObject var addProfileDataApi = AddProfileApi()

    @State var showToast : Bool = false
    @State var toHome : Bool = false

    
    @State var toastMessage : String = ""
    
    @State var firstName = ""
    @State var lastName = ""

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
            
            NavigationLink( destination: MainTabContainer(isUserLoggedIn: self.$toHome), isActive: self.$toHome){
                EmptyView()
            }
           
           
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
                            Text("First Name")
                                .foregroundColor(.black)
                                .font(AppFonts.ceraPro_16)
                                .fontWeight(.bold)
                            
                            Spacer()
                        }
                        .padding(.top,20)
                        
                        
                        
                        TextField("Enter your full name", text: self.$firstName)
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
                    
                    
                    
                    TextField("Enter your full name", text: self.$lastName)
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
                        
                        
                    Group{
                        
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
                    }
                    
                    
                    if(self.addProfileDataApi.isLoading){
                        ProgressView()
                            .padding(20)
                            .onDisappear{
                                
                                if(self.addProfileDataApi.isApiCallDone && (!self.addProfileDataApi.isApiCallSuccessful)){
                                    self.toastMessage = "Unable to access internet. Please check your internet connection and try again."
                                    self.showToast = true
                                }
                                else if (self.addProfileDataApi.isApiCallDone && self.addProfileDataApi.isApiCallSuccessful  && (!self.addProfileDataApi.addedSuccessful)){
                                    self.toastMessage = "Unable to add profile. Please try again later."
                                    self.showToast = true
                                }
                                else if(self.addProfileDataApi.isApiCallDone && self.addProfileDataApi.isApiCallSuccessful  && self.addProfileDataApi.addedSuccessful){
                                    AppData().profileSetup()
                                    self.toastMessage = "Profile Created successfully"
                                    self.showToast = true
                                    
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            self.toHome = true
                                        }
                                    
                                  
                                    
                                }
                                
                            }
                    }
                    else{
                        Button(action: {
                            
                            if(self.profilePhoto == nil){
                                self.toastMessage = "Please select profile image."
                                self.showToast = true
                            }
                            if(self.coverPhoto == nil){
                                self.toastMessage = "Please select cover image."
                                self.showToast = true
                            }
                            else if(self.firstName.isEmpty){
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
                                
                                
                                
                                self.addProfileDataApi.isLoading = true
                                
                                
                                let size = self.profilePhoto!.asUIImage().getSizeIn(.megabyte)
                                
                                print("image data size ===> \(size)")

                                
                                if(size > 1){
                                    self.toastMessage = "Image must be less then 1 mb"
                                    self.showToast = true
                                    self.addProfileDataApi.isLoading = false
                                }
                                else{
                                    
                                    let imageData  = (((self.profilePhoto!.asUIImage()).jpegData(compressionQuality: 1)) ?? Data())
                                    
                                    let imageDataCover  = (((self.coverPhoto!.asUIImage()).jpegData(compressionQuality: 1)) ?? Data())

                                    
                                    
                                    self.addProfileDataApi.addUserProfileData(firstname: self.firstName, lastname: self.lastName, tagline: self.tagLine, description: self.Description, profileImage: imageData, coverImage: imageDataCover)
                                    
                                }
                                
    //                            self.updateProfileApi.updateUserProfile(firstName: self.firstName, lastName: self.lastName, latitude: self.latitude.description, longitude: self.longitude.description, phone: self.phone, biography: self.aboutMe, address: self.address, gender: self.selectedGender.lowercased(), dob: self.dateFormatter.string(from: self.dateOfBirth), age: self.age)
                                
                            }
                        }, label: {
                            
                            BlueButton(lable: "Create Profile")
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
            
            
            if(self.showToast){
                Toast(isShowing: self.$showToast, message: self.toastMessage)
            }
              
            
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

