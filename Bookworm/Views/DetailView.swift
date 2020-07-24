//
//  DetailView.swift
//  Bookworm
//
//  Created by Nate Lee on 7/24/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI
import CoreData


struct DetailView: View {
    var book: Book
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack {
                    Image(self.book.genre ?? "Fantasy")
                        .frame(width: geo.size.width)
                    
                    Text(self.book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(9)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                    //.offset(x: -5, y: -5)
                }
                
                Text(self.book.author ?? "Unknown Author")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Text(self.book.review ?? "No Review")
                    .padding()
                
                RatingView(rating: .constant(self.book.rating))
                
            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test Author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."
        
        return VStack {
            DetailView(book: book)
        }
    }
}
