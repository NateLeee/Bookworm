//
//  ContentView.swift
//  Bookworm
//
//  Created by Nate Lee on 7/23/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        if (horizontalSizeClass == .compact) {
            return AnyView(Text("horizontalSizeClass == .compact"))
        } else {
            return AnyView(VStack {
                Text("horizontalSizeClass == .regular")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
