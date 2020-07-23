//
//  ContentView.swift
//  Bookworm
//
//  Created by Nate Lee on 7/23/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Unknown Student")
            }
            .navigationBarTitle("Bookworm")
            .navigationBarItems(trailing: Button(action: {
                self.showSheet = true
            }, label: {
                Image(systemName: "plus")
            }))
                .sheet(isPresented: $showSheet) {
                    AddBookView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
