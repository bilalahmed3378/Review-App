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
    
    @State var reviewsList: [GetReviewsdocsModel] = []
    
    @State var showSheet : Bool = false



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
                .padding(.top,10)
                
                if(self.getProfileApi.isLoading){

                    VStack{

                        Spacer()

                        HStack{

                            Spacer()

                            ProgressView()
                                .padding()
                                .onDisappear{
                                    
//                                        self.getReviews.getReviews(id: self.getProfileApi.apiResponse!.docs!._id)
                                    if !(self.getProfileApi.apiResponse!.docs!._id.isEmpty){
                                        self.getReviews.getReviews(id: self.getProfileApi.apiResponse!.docs!._id, reviewList: self.$reviewsList)
                                    } 
                                    
                                   
                                    
                                    
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
                                    
                                    Text("Reviews")
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
                                                    self.getReviews.getReviews(id: self.getProfileApi.apiResponse!.docs!._id, reviewList: self.$reviewsList)
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
                                                            
                                                            let halfIndex = self.getReviews.apiResponse!.docs![index].reviewFor!.firstname.index(self.getReviews.apiResponse!.docs![index].reviewFor!.firstname.startIndex, offsetBy: self.getReviews.apiResponse!.docs![index].reviewFor!.firstname.count / 2)
                                                                   let firstHalf = String(self.getReviews.apiResponse!.docs![index].reviewFor!.firstname[..<halfIndex])
//                                                                   let secondHalf = String(self.getReviews.apiResponse!.docs![index].reviewFor!.firstname[halfIndex...])
                                                            
                                                            let halfIndexLast = self.getReviews.apiResponse!.docs![index].reviewFor!.lastname.index(self.getReviews.apiResponse!.docs![index].reviewFor!.lastname.startIndex, offsetBy: self.getReviews.apiResponse!.docs![index].reviewFor!.lastname.count / 2)
//                                                                   let firstHalfLast = String(self.getReviews.apiResponse!.docs![index].reviewFor!.lastname[..<halfIndex])
                                                                   let secondHalfLast = String(self.getReviews.apiResponse!.docs![index].reviewFor!.lastname[halfIndexLast...])
                                                            
                                                            HStack(spacing: 0) {
                                                                       Text(firstHalf)
//                                                                       Text(secondHalf)
//                                                                           .hidden()
                                                                
                                                                Text("*******")
                                                                
//                                                                Text(firstHalfLast)
//                                                                    .hidden()
                                                                Text(secondHalfLast)
                                                                    
                                                                
                                                                   }
                                                            
//                                                            Text("\(self.getReviews.apiResponse!.docs![index].reviewFor!.firstname) \(self.getReviews.apiResponse!.docs![index].reviewFor!.lastname)")
//                                                                .foregroundColor(.black)
//                                                                .font(AppFonts.ceraPro_16)
//                                                                .fontWeight(.bold)
                                                          
                                                            
                                                            
                                                            Spacer()
                                                            
                                                            Text(self.currentDate)
                                                                .foregroundColor(AppColors.textColor)
                                                                .font(AppFonts.ceraPro_14)
                                                                .onAppear{
                                                                    
                                                                  let arr  = self.getReviews.apiResponse!.docs![index].createdAt.split(separator: "T")
                                                                    
                                                                    self.currentDate = String(arr[0])
                                                                    
                                                                }

                                                           
                                                            
                                                        }
                                                        
                                                        HStack{
                                                            
                                                            
                                                            RatingView(rating: Double(self.getReviews.apiResponse!.docs![index].ratings))
                                                                .padding(.top,3)
                                                            
                                                            Spacer()
                                                            
                                                            
                                                            Button(action: {
                                                                self.showSheet = true
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
                                                            .sheet(isPresented: self.$showSheet){
                                                                
                                                                    ReplySheetMyProfile(replyId: getReviews.apiResponse!.docs![index]._id)
                                                                
                                                            }
                                                              
                                                            
                                                            
                                                        }
                                                       
                                                        
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
                                                    self.getReviews.getReviews(id: self.getProfileApi.apiResponse!.docs!._id, reviewList: self.$reviewsList)
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
            
                self.getProfileApi.getProfile()
              
        }
    }
}



struct ReplySheetMyProfile : View{
    @State var description = ""
    
    @State var currentDate = ""

    @StateObject var getReplyOnRating = GetReplyOnReviewsApi()
    
    @StateObject var postReplyOnRating = PostReplyOnReviewApi()

    
    @State var showToast : Bool = false
    @State var toastMessage : String = ""


    

    
    let replyId : String

   
    var body: some View{
        
        ZStack{
            
            VStack{
                
                if(self.getReplyOnRating.isLoading){
                    
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
                
                else if(self.getReplyOnRating.isApiCallDone && (!self.getReplyOnRating.isApiCallSuccessful)){
                    
                    VStack{
                        
                        
                        Spacer()
                        
                        Text("Unable to access internet.")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                        
                        Button(action: {
                            withAnimation{
                                self.getReplyOnRating.getReviews(id: self.replyId)
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
                
                else if(self.getReplyOnRating.isApiCallDone && self.getReplyOnRating.isApiCallSuccessful){
                    
                    if(self.getReplyOnRating.dataRetrivedSuccessfully){
                        ScrollView(.vertical, showsIndicators: false){
                            
                            HStack(alignment: .top){
                                
                                KFImage(URL(string: self.getReplyOnRating.apiResponse!.docs!.reviewerId!.profileImage))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                    .blur(radius: 20)

                                
                                VStack(alignment: .leading){
                                    
                                   
                                    
                                    HStack{
                                        let halfIndex = self.getReplyOnRating.apiResponse!.docs!.reviewerId!.firstname.index(self.getReplyOnRating.apiResponse!.docs!.reviewerId!.firstname.startIndex, offsetBy: self.getReplyOnRating.apiResponse!.docs!.reviewerId!.firstname.count / 2)
                                               let firstHalf = String(self.getReplyOnRating.apiResponse!.docs!.reviewerId!.firstname[..<halfIndex])
                //                                                                   let secondHalf = String(self.getReviews.apiResponse!.docs![index].reviewFor!.firstname[halfIndex...])
                                        
                                        let halfIndexLast = self.getReplyOnRating.apiResponse!.docs!.reviewerId!.lastname.index(self.getReplyOnRating.apiResponse!.docs!.reviewerId!.lastname.startIndex, offsetBy: self.getReplyOnRating.apiResponse!.docs!.reviewerId!.lastname.count / 2)
                //                                                                   let firstHalfLast = String(self.getReviews.apiResponse!.docs![index].reviewFor!.lastname[..<halfIndex])
                                               let secondHalfLast = String(self.getReplyOnRating.apiResponse!.docs!.reviewerId!.lastname[halfIndexLast...])
                                        
                                        HStack(spacing: 0) {
                                                   Text(firstHalf)
                //                                                                       Text(secondHalf)
                //                                                                           .hidden()
                                            
                                            Text("*******")
                                            
                //                                                                Text(firstHalfLast)
                //                                                                    .hidden()
                                            Text(secondHalfLast)
                                                
                                            
                                               }
                                        
                                        
                                      
                                        
                                        Spacer()
                                        
                                        Text(self.currentDate)
                                            .foregroundColor(AppColors.textColor)
                                            .font(AppFonts.ceraPro_14)
                                            .onAppear{
                                                
                                                let arr  = self.getReplyOnRating.apiResponse!.docs!.createdAt.split(separator: "T")
                                                
                                                self.currentDate = String(arr[0])
                                                
                                            }
                                        
                                    }
                                    
                                    RatingView(rating: Double(self.getReplyOnRating.apiResponse!.docs!.ratings))
                                        .padding(.top,3)
                                    
                                    Text("\(self.getReplyOnRating.apiResponse!.docs!.message)")
                                        .foregroundColor(.black)
                                        .font(AppFonts.ceraPro_14)
                                        .fontWeight(.ultraLight)
                                        .padding(.top,3)
                                    
//                                    HStack{
////                                        Text("06 replies")
////                                            .foregroundColor(AppColors.appPrimaryColor)
////                                            .font(AppFonts.ceraPro_14)
//
//                                        Spacer()
//
//
//                                        Image(systemName: "hand.thumbsdown.fill")
//                                            .resizable()
//                                            .aspectRatio( contentMode: .fit)
//                                            .frame(width: 16, height: 16)
//                                            .foregroundColor(.red)
//
//                                        Text("6")
//                                            .foregroundColor(.red)
//                                            .font(AppFonts.ceraPro_14)
//
//                                        Spacer()
//
//                                        Image(systemName: "hand.thumbsup.fill")
//                                            .resizable()
//                                            .aspectRatio( contentMode: .fit)
//                                            .frame(width: 16, height: 16)
//                                            .foregroundColor(.blue)
//
//                                        Text("6")
//                                            .foregroundColor(.blue)
//                                            .font(AppFonts.ceraPro_14)
//
//                                        Spacer()
//
////                                        Image(systemName: "arrowshape.turn.up.left.fill")
////                                            .resizable()
////                                            .aspectRatio( contentMode: .fit)
////                                            .frame(width: 16, height: 16)
////                                            .foregroundColor(.blue)
////
////                                        Text("Reply")
////                                            .foregroundColor(.blue)
////                                            .font(AppFonts.ceraPro_14)
//
//
//                                    }
                                }
                                
                            }
                            .padding(.top,20)
                            .padding(.leading,20)
                            .padding(.trailing,20)
                            
                            Divider()
                                .padding(.top,5)
                                .padding(.bottom,10)
                            
                            HStack{
                                
                                Text("Replies")
                                    .foregroundColor(.black)
                                    .font(AppFonts.ceraPro_16)
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                
                            }
                            .padding(.leading,20)
                            .padding(.trailing,20)
                            
                            LazyVStack{
                                ForEach(self.getReplyOnRating.apiResponse!.docs!.replyHistory.indices, id: \.self){index in
                                    
                                    ReplyViewMyProfile(replyModel: self.getReplyOnRating.apiResponse!.docs!.replyHistory[index])
                                    
                                    
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
                                                    Text("Add Reply")
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
                                
                                
                                if(self.postReplyOnRating.isLoading){
                                    ProgressView()
                                        .padding(10)
                                        .onDisappear{
                                            if(self.postReplyOnRating.isApiCallDone && self.postReplyOnRating.isApiCallSuccessful){
                                                
                                                if(self.postReplyOnRating.dataRetrivedSuccessfully){

                                                    self.getReplyOnRating.getReviews(id: self.getReplyOnRating.apiResponse!.docs!._id)
                                                    self.description = ""
                                                }
                                                else {
                                                    self.toastMessage = "Unable to add reply."
                                                    self.showToast = true
                                                }
                                                
                                            }
                                            else if(self.postReplyOnRating.isApiCallDone && (!self.postReplyOnRating.isApiCallSuccessful)){
                                                self.toastMessage = "Unable to access internet. Please check you internet connection and try again."
                                                self.showToast = true
                                            }
                                            else{
                                                self.toastMessage = "oops! Unable to add reply."
                                                self.showToast = true
                                            }
                                        }
                                }
                                
                                else{
                                    Button(action: {
                                        if (self.description.isEmpty){
                                            self.toastMessage = "Please enter reply"
                                            self.showToast = true
                                        }
                                        else{
                                            self.postReplyOnRating.addReply(replyFor: self.replyId, reply: self.description)
                                            print(self.replyId)
                                        }
                                    }, label: {
                                        Image(systemName: "paperplane.fill")
                                            .resizable()
                                            .aspectRatio( contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(AppColors.appPrimaryColor)
                                            .padding(.trailing,5)
                                    })
                                }
                                
                                
                                
                            }
                            .background(RoundedRectangle(cornerRadius: 10)
                                .stroke(AppColors.textColor, lineWidth: 1))
                            .padding(.leading,20)
                            .padding(.trailing,20)
                            .padding(.top,20)
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
                                    self.getReplyOnRating.getReviews(id: self.replyId)
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
                                self.getReplyOnRating.getReviews(id: self.replyId)
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
            
            if(showToast){
                Toast(isShowing: self.$showToast, message: self.toastMessage)
            }
        }
        .onAppear{
            self.getReplyOnRating.getReviews(id: self.replyId)

        }
    }
}


struct ReplyViewMyProfile : View{
    
    let replyModel : String
    
    var body: some View{
        
//        HStack{
//            Spacer()
//            Text("abc**kj")
//                .foregroundColor(AppColors.textColor)
//        }
//        .padding(.leading,20)
//        .padding(.trailing,20)
//        .padding(.top,10)
//
        
        HStack{
            Text(replyModel)
                .font(AppFonts.ceraPro_14)
                .foregroundColor(AppColors.textColor)
                .padding(15)
        }
            .frame(width: UIScreen.screenWidth - 40)
            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(AppColors.textColor))
        
        Divider()
    }
}
