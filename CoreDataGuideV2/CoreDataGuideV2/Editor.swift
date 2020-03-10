//
//  Editor.swift
//  CoreDataGuideV2
//
//  Created by Edward Lucas-Rowe on 10/03/2020.
//  Copyright © 2020 Edward Lucas-Rowe. All rights reserved.
//

import SwiftUI

struct Editor: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @Binding var user:User?
    @Binding var editorShowing: Bool
    @State var newName = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Editor")
                Spacer()
                Button(action: {
                    withAnimation(){self.editorShowing = false}
                }) {
                    Image(systemName: "xmark.circle.fill").font(.largeTitle)
                }
            }
            Text("Editing: \(user?.nameUw ?? "No user selected")")
            TextField("Enter an updated name", text: $newName)
            Button("Update name") {
                self.updateName()
            }
            Spacer()
        }.padding()
        
    }
    
    func updateName() {
        moc.perform {//names are updated but can't delete the updated ones for some reason
            self.user?.name = self.newName
            
        }
        try? self.moc.save()
        
    }
    
}

struct Editor_Previews: PreviewProvider {
    static var previews: some View {
        Editor(user: .constant(User()), editorShowing: .constant(true))
    }
}
