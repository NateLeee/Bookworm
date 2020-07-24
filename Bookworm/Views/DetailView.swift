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
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "Fantasy")
                        .frame(width: geo.size.width)
                    
                    Text(self.book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(9)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -9, y: -9)
                }
                ScrollView(.vertical) {
                    Text(self.book.author ?? "Unknown Author")
                        .font(.title)
                        .foregroundColor(.secondary)
                    
                    Text(self.book.review ?? "No Review")
                        .padding()
                    
                    RatingView(rating: .constant(self.book.rating))
                        .font(.largeTitle)
                    
                    Spacer()
                }
            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            // Bring the alert
            self.showingAlert.toggle()
        }, label: {
            Image(systemName: "trash")
        }))
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Are you sure?"), message: Text("This cannot be un-done. Think twice."), primaryButton: .destructive(Text("Delete"), action: {
                // Make deleting happen!
                self.moc.delete(self.book)
                try? self.moc.save()
                
                // Go back to main view.
                self.presentationMode.wrappedValue.dismiss()
                
            }), secondaryButton: .cancel())
        }
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
