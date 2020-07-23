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
    
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
    
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            List(books, id: \.id) { book in
                Text("\(book.title ?? "Unknown Title")")
                Text("\(book.rating)")
            }
            .navigationBarTitle("Bookworm")
            .navigationBarItems(trailing: Button(action: {
                self.showSheet = true
            }, label: {
                Image(systemName: "plus")
            }))
                .sheet(isPresented: $showSheet) {
                    AddBookView().environment(\.managedObjectContext, self.moc)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
