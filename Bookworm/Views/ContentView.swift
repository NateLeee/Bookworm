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
    
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
    
    var body: some View {
        NavigationView {
            VStack {
                List(students, id: \.id) { student in
                    Text(student.name ?? "Unknown Student")
                }
                
                Button(action: {
                    // add a student
                    let firstNames = ["a", "b", "c", "d"]
                    let lastNames = ["e", "f", "g", "h"]
                    
                    let name = firstNames.randomElement()! + " " + lastNames.randomElement()!
                    let newStudent = Student(context: self.moc)
                    newStudent.id = UUID()
                    newStudent.name = name
                    
                    try? self.moc.save()
                    
                }) {
                    Image(systemName: "plus")
                }
                .padding(.top, 27)
                .padding(.bottom, 45)
            }
            .navigationBarTitle("Bookworm")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
