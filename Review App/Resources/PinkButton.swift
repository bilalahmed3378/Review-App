//
//  GradientButton.swift
//  MeccaFitness
//
//  Created by CodeCue on 13/02/2022.
//
import Foundation
import SwiftUI

struct BlueButton: View {
    
    let lable : String
    
    var body: some View {
        
        HStack{
            Spacer()
            Text(lable)
                .foregroundColor(.white)
                .font(AppFonts.ceraPro_14)
            Spacer()
        }
        .padding()
        .background(AppColors.appPrimaryColor)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}


struct RedButton: View {
    
    let lable : String
    
    var body: some View {
        
        HStack{
            Spacer()
            Text(lable)
                .foregroundColor(.white)
                .font(AppFonts.ceraPro_14)
            Spacer()
        }
        .padding()
        .background(.red)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}


struct RatingView: View {
  private static let MAX_RATING: Double = 5 // Defines upper limit of the rating
  private static let COLOR = Color.yellow // The color of the stars
  let rating: Double
  private let fullCount: Int
  private let emptyCount: Int
  private let halfFullCount: Int
  init(rating: Double) {
    self.rating = rating
    fullCount = Int(rating)
    emptyCount = Int(RatingView.MAX_RATING - rating)
    halfFullCount = (Double(fullCount + emptyCount) < RatingView.MAX_RATING) ? 1 : 0
  }
  var body: some View {
    HStack {
      ForEach(0..<fullCount) { _ in
        self.fullStar
      }
      ForEach(0..<halfFullCount) { _ in
        self.halfFullStar
      }
      ForEach(0..<emptyCount) { _ in
        self.emptyStar
      }
    }
  }
  private var fullStar: some View {
    Image(systemName: "star.fill").foregroundColor(RatingView.COLOR)
  }
  private var halfFullStar: some View {
    Image(systemName: "star.lefthalf.fill").foregroundColor(RatingView.COLOR)
  }
  private var emptyStar: some View {
    Image(systemName: "star").foregroundColor(RatingView.COLOR)
  }
}











