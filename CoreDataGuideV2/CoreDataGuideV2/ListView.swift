//
//  ListView.swift
//  CoreDataGuideV2
//
//  Created by Edward Lucas-Rowe on 10/03/2020.
//  Copyright © 2020 Edward Lucas-Rowe. All rights reserved.
//

import SwiftUI
import CoreData

struct ListView: View {
    
    @Binding var showEditor: Bool
    @Environment(\.managedObjectContext) var moc
    @FetchRequest var users: FetchedResults<User>
    @Binding var userToEdit:User?
    @State var name = ""
    
    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    Button(action: addUser) {
                        Text("Add user")
                    }
                    Button(action: deleteAll) {
                        Text("Delete all")
                    }
                }
                
                List {
                    ForEach(users, id: \.self.idUw) { user in
                        HStack(spacing: 20) {
                            Text(user.nameUw)
                            
                            Spacer()
                            Button(action: {
                                self.edit(user: user)
                            }) {
                                Text("Edit")
                            }
                            
                            Button(action: {self.deleteUser(user: user)}) {
                                Text("Delete user").foregroundColor(Color.white)
                            }.background(Color.blue)
                        }.padding(.vertical)
                            .buttonStyle(PlainButtonStyle())
                    }
                }
                
            }
        }
    }
    
    func edit(user: User) {
        self.userToEdit = user
        withAnimation(.easeInOut(duration: 0.5)) {
            print("Editor set to true in list")
            showEditor = true
        }
    }
    
    func addUser() {
        let user = User(context: moc)
        user.name = ["Bilbo", "Sam", "Frodo"].randomElement()!
        user.age = 10
        user.id = UUID()
        try? moc.save()
    }
    
    func deleteUser(user: User) {
        
        moc.delete(user)
        try? moc.save()
        
    }
    
    func deleteAll() {
        let allUsers = NSFetchRequest<User>(entityName: "User")
        let users = try? moc.fetch(allUsers)
        
        if let usersUw = users {
            for user in usersUw {
                moc.delete(user)
            }
            try? moc.save()
        }
    }
    
    
    init(predicate: String, showEditor: Binding<Bool>, userBinding: Binding<User?>) {
        
        self._showEditor = showEditor
        self._userToEdit = userBinding
        
        if predicate == "" {
            self._users = FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)], predicate: nil)
        } else {
            self._users = FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)], predicate: NSPredicate(format: "name CONTAINS[c] %@", predicate))
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(predicate: "c", showEditor: .constant(true), userBinding: .constant(User()))
    }
}
