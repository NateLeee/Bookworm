//
//  AddBookView.swift
//  Bookworm
//
//  Created by Nate Lee on 7/23/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating: Int16 = 3
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Book title", text: $title)
                    
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(self.genres, id: \.self) { genre in
                            Text(genre)
                        }
                    }
                }
                
                Section {
                    Picker("Rating", selection: $rating) {
                        ForEach(0 ..< 6) {
                            Text("\($0)").tag(Int16($0))
                        }
                    }
                    
                    TextField("Write some review", text: $review)
                }
                
                Section {
                    Button(action: {
                        // TODO: - Save this book!
                        self.addBook()
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                    }
                }
                
            }
            .navigationBarTitle("Add book", displayMode: .inline)
        }
    }
    
    func addBook() {
        let newBook = Book(context: moc)
        
        newBook.id = UUID()
        newBook.title = self.title
        newBook.authur = self.author
        newBook.genre = self.genre
        newBook.rating = self.rating
        newBook.review = self.review
        
        // Actually save this book!
        try? self.moc.save()
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
