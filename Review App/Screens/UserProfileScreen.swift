//
//  UserProfileScreen.swift
//  Review App
//
//  Created by Bilal Ahmed on 21/02/2023.
//

import SwiftUI
import Kingfisher

struct UserProfileScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var getUserProfileApi = GetUserProfileDetailsApi()
    @StateObject var getReviews = GetReviewsApi()
    @StateObject var getReplyOnRating = GetReplyOnReviewsApi()
    @StateObject var writeReviewApi = WriteReviewApi()

    
    @State var reviewsList: [GetReviewsdocsModel] = []

    
    @State var reviewRating = 0



    @State var showToast : Bool = false
    @State var toastMessage : String = ""




    
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
                
                if(self.getUserProfileApi.isLoading){
                    VStack{

                        Spacer()

                        HStack{

                            Spacer()

                            ProgressView()
                                .padding()
                                .onDisappear{
                                    if !(self.getUserProfileApi.apiResponse!.docs!._id.isEmpty){
                                        self.getReviews.getReviews(id: self.getUserProfileApi.apiResponse!.docs!._id, reviewList: self.$reviewsList)
                                    }
                                }
                               


                            Spacer()

                        }


                        Spacer()

                    }
                }
                
                else if(self.getUserProfileApi.isApiCallDone && (!self.getUserProfileApi.isApiCallSuccessful)){
                    
                    VStack{
                        
                        
                        Spacer()
                        
                        Text("Unable to access internet.")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                        
                        Button(action: {
                            withAnimation{
                                self.getUserProfileApi.getUserProfile(id: self.user_id)
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
                
                else if(self.getUserProfileApi.isApiCallDone && self.getUserProfileApi.isApiCallSuccessful){
                    
                    if(self.getUserProfileApi.dataRetrivedSuccessfully){
                        
                        ScrollView(.vertical, showsIndicators: false){
                            VStack{
                                ZStack(alignment: .top){
                                    KFImage(URL(string: self.getUserProfileApi.apiResponse!.docs!.coverImage))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: UIScreen.screenWidth - 40, height: 200)
                                        .cornerRadius(10)
                                        .padding(.top,20)
                                    
                                    VStack{
                                        Spacer()
                                        KFImage(URL(string: self.getUserProfileApi.apiResponse!.docs!.profileImage))
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 75, height: 75)
                                            .clipShape(Circle())
                                    }
                                    
                                }
                                .frame(height: 250)
                                
                                Text("\(self.getUserProfileApi.apiResponse!.docs!.firstname) \(self.getUserProfileApi.apiResponse!.docs!.lastname)")
                                    .foregroundColor(.black)
                                    .font(AppFonts.ceraPro_20)
                                    .fontWeight(.bold)
                                    .padding(.top,5)
                                    
                                
                                Text("\(self.getUserProfileApi.apiResponse!.docs!.tagline)")
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
                                    Text("\(self.getUserProfileApi.apiResponse!.docs!.description)")
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
                                                if !(self.getUserProfileApi.apiResponse!.docs!._id.isEmpty){
                                                    self.getReviews.getReviews(id: self.getUserProfileApi.apiResponse!.docs!._id, reviewList: self.$reviewsList)
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
                                            ForEach(self.reviewsList.indices, id: \.self){index in
                                                ReviewCards(ReviewList: self.reviewsList[index], reviewsList: self.$reviewsList)
                                            }
                                        }
                                        
                                        Button(action: {
                                            self.showSheet = true
                                            self.reviewSheet = true
                                        }, label: {
                                            BlueButton(lable: "Write a review")
                                                .padding(.top,30)
                                        })
                                        .sheet(isPresented: self.$showSheet){
                                            if(self.reviewSheet){
                                                ScrollView(.vertical, showsIndicators: false){
                                                    VStack{

                                                        HStack{
                                                            KFImage(URL(string: self.reviewsList[0].reviewFor!.profileImage))
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fill)
                                                                .frame(width: 70, height: 70)
                                                                .clipShape(Circle())

                                                            VStack(alignment: .leading){
                                                                HStack{
                                                                    Text("\(self.reviewsList[0].reviewFor!.firstname)")
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

                                                                Text("\(self.reviewsList[0].reviewFor!.description)")
                                                                    .foregroundColor(AppColors.textColor)
                                                                    .font(AppFonts.ceraPro_14)
                                                                    .padding(.top,2)

                                                                HStack{
                                                                    Spacer()

                                                                    RatingView(rating: Double(self.reviewsList[0].ratings))
                                                                        .padding(.top,3)

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

                                                            productRatingView(rating:$reviewRating)
                                                                .padding(.top,20)

                                                        }
                                                        .padding(.top,20)

//                                                        Text("Excellent!")
//                                                            .foregroundColor(.black)
//                                                            .font(AppFonts.ceraPro_14)
//                                                            .padding(.top,20)

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
                                                                        if(self.writeReview.isEmpty){
                                                                            Text("Add Review")
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
                                                        
                                                        if(self.writeReviewApi.isLoading){
                                                            ProgressView()
                                                                .padding(20)
                                                                .onDisappear{
                                                                    
                                                                    if(self.writeReviewApi.isApiCallDone && (!self.writeReviewApi.isApiCallSuccessful)){
                                                                        self.showSheet = false
                                                                        self.toastMessage = "Unable to access internet. Please check your internet connection and try again."
                                                                        self.showToast = true
                                                                    }
                                                                   
                                                                    else if(self.writeReviewApi.isApiCallDone && self.writeReviewApi.isApiCallSuccessful){
                                                                        if(self.writeReviewApi.dataRetrivedSuccessfully){
                                                                            self.showSheet = false
                                                                            self.toastMessage = "Review added successfully"
                                                                            self.showToast = true
                                                                            self.reviewsList.removeAll()
                                                                            self.getReviews.getReviews(id: self.getUserProfileApi.apiResponse!.docs!._id, reviewList: self.$reviewsList)
                                                                            
                                                                            
                                                                        }
                                                                        else if(self.writeReviewApi.isGiven){
                                                                            self.showSheet = false

                                                                            self.toastMessage = "Review already given"
                                                                            self.showToast = true
                                                                        }
                                                                        else{
                                                                            self.showSheet = false
                                                                            self.toastMessage = "Unable to add review try again."
                                                                            self.showToast = true
                                                                        }
                                                                      
                                 
                                                                    }
                                                                    else{
                                                                        self.toastMessage = "Unable to add review try again. Plese Try again later"
                                                                        self.showToast = true
                                                                    }
                                                                    
                                                                }
                                                            
                                                        }


                                                        else{
                                                            Button(action: {
                                                                if !(self.writeReview.isEmpty){
                                                                    self.writeReviewApi.addReply(replyFor: self.reviewsList[0].reviewFor!._id, ratings: self.reviewRating, message: self.writeReview)
                                                                }
                                                                self.writeReview = ""
                                                                self.reviewRating = 0
                                                            }, label: {
                                                                BlueButton(lable: "SUBMIT")
                                                                    .padding(.top,20)
                                                                    .padding(.leading,20)
                                                                    .padding(.trailing,20)
                                                            })
                                                        }
                                                        
                                                      

                                                        Spacer()

                                                    }
                                                }
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
                                                if !(self.getUserProfileApi.apiResponse!.docs!._id.isEmpty){
                                                    self.getReviews.getReviews(id: self.getUserProfileApi.apiResponse!.docs!._id, reviewList: self.$reviewsList)
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
                            .padding(.bottom,20)
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
                                    self.getUserProfileApi.getUserProfile(id: self.user_id)

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
                                self.getUserProfileApi.getUserProfile(id: self.user_id)
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
        .navigationBarHidden(true)
        .onAppear{
            self.getUserProfileApi.getUserProfile(id: self.user_id)
            

        }
    }
}


struct ReviewCards : View{
    
    @StateObject var deleteReview = DeleteReviewApi()

    
    let ReviewList : GetReviewsdocsModel
    


    @Binding var reviewsList: [GetReviewsdocsModel]

    
    @State var currentDate = ""
    
    @State var showSheet = false
    
    @State var reviewSheet = false
    
    @State var showToast : Bool = false
    @State var toastMessage : String = ""
   

    
    var body: some View{
        
        if(showToast == false){
            HStack(alignment: .top){
                KFImage(URL(string: self.ReviewList.reviewerId!.profileImage))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                VStack(alignment: .leading){
                    
                    HStack{
                        Text("\(self.ReviewList.reviewerId!.firstname) \(self.ReviewList.reviewerId!.lastname)")
                            .foregroundColor(.black)
                            .font(AppFonts.ceraPro_16)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Text(self.currentDate)
                            .foregroundColor(AppColors.textColor)
                            .font(AppFonts.ceraPro_14)
                            .onAppear{
                                
                                let arr  = self.ReviewList.createdAt.split(separator: "T")
                                
                                self.currentDate = String(arr[0])
                                
                            }
                        
                    }
                    
                    RatingView(rating: Double(self.ReviewList.ratings))
                        .padding(.top,3)
                    
                    Text("\(self.ReviewList.message)")
                        .foregroundColor(.black)
                        .font(AppFonts.ceraPro_14)
                        .fontWeight(.ultraLight)
                        .padding(.top,3)
                    
                    
                    HStack{
                        
                        if(self.deleteReview.isLoading){
                            ProgressView()
                                .padding(.trailing,5)
                                .onDisappear{
                                    
                                    if(self.deleteReview.isApiCallDone && (!self.deleteReview.isApiCallSuccessful)){
                                        self.toastMessage = "Unable to access internet. Please check your internet connection and try again."
                                        self.showToast = true
                                    }
                                   
                                    else if(self.deleteReview.isApiCallDone && self.deleteReview.isApiCallSuccessful){
                                        if(self.deleteReview.dataRetrivedSuccessfully){
                                            self.toastMessage = "Review Deleted successfully"
                                            self.showToast = true
                                            
                                            self.reviewsList.removeAll{$0._id == self.ReviewList._id}
                                        }
                                        else{
                                            self.toastMessage = "Unable to delete review try again."
                                            self.showToast = true
                                        }
                                      
 
                                    }
                                    else{
                                        self.toastMessage = "Unable to delete review try again. Plese Try again later"
                                        self.showToast = true
                                    }
                                    
                                }
                        }
                        else{
                            if(self.ReviewList.reviewerId!._id == AppData().getUserId()){
                                Button(action: {
                                    self.deleteReview.deleteReviews(id: ReviewList._id)
                                }, label: {
                                    Text("Delete")
                                        .foregroundColor(AppColors.appPrimaryColor)
                                        .font(AppFonts.ceraPro_14)
                                        .padding(.trailing,5)
                                })
                            }
                        }
                        
                        if(self.ReviewList.reviewerId!._id == AppData().getUserId()){
                            Button(action: {
                                
                            }, label: {
                                Text("Update")
                                    .foregroundColor(AppColors.appPrimaryColor)
                                    .font(AppFonts.ceraPro_14)
                            })
                        }
                        
                        
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
                        .sheet(isPresented: self.$showSheet){
                            
                            if(self.reviewSheet == false){
                                ReplySheet(replyId: ReviewList._id)
                            }
                            
                        }
                        
                        
                        
                        
                    }
                }
                .padding(.leading,3)
                
            }
            .padding(.top,20)
        }
        
        if(showToast){
            Toast(isShowing: self.$showToast, message: self.toastMessage)
        }

    }
}


struct ReplySheet : View{
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
                                
                                VStack(alignment: .leading){
                                    
                                    HStack{
                                        Text("\(self.getReplyOnRating.apiResponse!.docs!.reviewerId!.firstname) \(self.getReplyOnRating.apiResponse!.docs!.reviewerId!.lastname)")
                                            .foregroundColor(.black)
                                            .font(AppFonts.ceraPro_16)
                                            .fontWeight(.bold)
                                        
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
                                
                                Text("Review (1045)")
                                    .foregroundColor(.black)
                                    .font(AppFonts.ceraPro_16)
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                
                            }
                            .padding(.leading,20)
                            .padding(.trailing,20)
                            
                            LazyVStack{
                                ForEach(self.getReplyOnRating.apiResponse!.docs!.replyHistory.indices, id: \.self){index in
                                    
                                    ReplyView(replyModel: self.getReplyOnRating.apiResponse!.docs!.replyHistory[index])
                                    
                                    
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


struct ReplyView : View{
    
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


struct productRatingView: View {

    @Binding var rating: Int

    var label = ""

    var maximumRating = 5

    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow


    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }


    var body: some View {

        HStack {
            if label.isEmpty == false {
                Text(label)
            }

            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
            }
        }


    }


}
