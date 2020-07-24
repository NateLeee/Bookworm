//
//  ContentView.swift
//  Bookworm
//
//  Created by Nate Lee on 7/23/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        // NSSortDescriptor(key: "rating", ascending: false),
        // NSSortDescriptor(key: "title", ascending: true),
        // NSSortDescriptor(key: "author", ascending: true)
        NSSortDescriptor(keyPath: \Book.rating, ascending: false),
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ]) var books: FetchedResults<Book>
    
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.id) { book in
                    NavigationLink(destination: DetailView(book: book).environment(\.managedObjectContext, self.moc)) {
                        EmojiRatingView(rating: book.rating)
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                    // Challenge 2: - Modify ContentView so that books rated as 1 star have their name shown in red.
                                    .foregroundColor(book.rating == 1 ? .red : nil)
                                
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                        }
                        .frame(minWidth: 162)
                        
                        Spacer()
                        
                        Text(self.genDateString(book.date))
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .layoutPriority(1)
                    }
                }
                .onDelete { (indexSet) in
                    for index in indexSet {
                        let bookToDelete = self.books[index]
                        self.moc.delete(bookToDelete)
                    }
                    
                    try? self.moc.save()
                }
            }
            .navigationBarTitle("Bookworm")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showSheet = true
            }, label: {
                Image(systemName: "plus")
            }))
                .sheet(isPresented: $showSheet) {
                    AddBookView().environment(\.managedObjectContext, self.moc)
                    // AddBookView() // This ain't working!
            }
        }
    }
    
    private func genDateString(_ date: Date?) -> String {
        guard let date = date else {
            return "Unknown Date"
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        
        return formatter.string(from: date)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
