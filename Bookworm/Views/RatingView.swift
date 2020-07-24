//
//  RatingView.swift
//  Bookworm
//
//  Created by Nate Lee on 7/23/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int16
    
    var label = ""
    var maximumRating = 5
    
    var starImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            // If there is a lebal, display it
            if (!label.isEmpty) {
                Text(label)
            }
            
            ForEach(1 ..< maximumRating + 1) { number in
                self.starImage
                    .foregroundColor(number > self.rating ? .gray : .yellow)
                    .onTapGesture {
                        self.rating = Int16(number)
                }
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
