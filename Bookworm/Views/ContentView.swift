//
//  ContentView.swift
//  Bookworm
//
//  Created by Nate Lee on 7/23/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI


struct PushButton: View {
    let title: String
    @Binding var isOn: Bool
    
    var onColors: [Color] = [.red, .yellow]
    var offColors: [Color] = [.init(white: 0.6), .init(white: 0.4)]
    
    var body: some View {
        Button(action: {
            self.isOn.toggle()
        }) {
            Text(title)
        }
        .padding()
        .background(
            LinearGradient(
                gradient: .init(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom)
        )
            .foregroundColor(.white)
            .clipShape(Capsule())
            .shadow(radius: isOn ? 9 : 0)
        
    }
}


struct ContentView: View {
    @State private var rememberMe: Bool = false
    
    var body: some View {
        VStack {
            PushButton(title: "Title Title", isOn: $rememberMe)
            
            Text("\(rememberMe ? "On" : "Off")")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
