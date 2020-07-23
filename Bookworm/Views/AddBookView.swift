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
    
    @State private var a = ""
    
    var body: some View {
        Form {
            Section {
                TextField("ass", text: $a)
            }
        }
        .navigationBarTitle("Add book", displayMode: .inline)
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
