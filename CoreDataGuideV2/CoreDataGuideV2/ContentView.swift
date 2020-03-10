//
//  ContentView.swift
//  CoreDataGuideV2
//
//  Created by Edward Lucas-Rowe on 26/02/2020.
//  Copyright © 2020 Edward Lucas-Rowe. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View { //selector to change the fetch request in the next screen. The only thing that is important in this view is the screen selection. So if there are any side panels toggled
    
    @Environment(\.managedObjectContext) var moc
    
    @State var showEditor = false
    @State var userToEdit:User?
    @State var dragOffset = CGSize.zero
    
    var body: some View {
        GeometryReader { geo in//here is going to be a number of VStacks with views that each change depending on what tab / option is selected. A Geometry reader can handle their offsets
            ListScreen(user: self.$userToEdit, showEditor: self.$showEditor).environment(\.managedObjectContext, self.moc)
            if self.showEditor {
                Color.black.opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                    withAnimation(){self.showEditor = false}
                }
            }
                
            Editor(user: self.$userToEdit, editorShowing: self.$showEditor).environment(\.managedObjectContext, self.moc)
                .frame(width: geo.size.width, height: geo.size.height / 2)
                .background(Blur())
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .offset(x: 0, y: self.showEditor ? geo.size.height / 2 : geo.size.height)
                .offset(y: self.dragOffset.height >= 0 ? self.dragOffset.height : 0)
                .gesture(DragGesture()
                    .onChanged{ value in
                        self.dragOffset = value.translation
                        
                }
                .onEnded{ _ in
                    if self.dragOffset.height > 100 {
                        withAnimation(){self.showEditor = false
                            print("Editor set to false on animation")
                        }
                    }
                    withAnimation(){self.dragOffset = CGSize.zero}
                    
                    }
            )
            
        }.edgesIgnoringSafeArea(.bottom)
    }
    
    
    
}

struct ListScreen: View { //This view allows for the changing of the predicate, it also passes the selected user back up the chain
    
    @Environment(\.managedObjectContext) var moc
    
    @State var name = ""
    @Binding var user:User?
    @Binding var showEditor:Bool
    
    var body: some View {
        VStack {
            TextField("Search name", text: $name).padding()
            ListView(predicate: name, showEditor: $showEditor, userBinding: $user).environment(\.managedObjectContext, moc)
        }
    }
    
}





struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        return ContentView().environment(\.managedObjectContext, context)
    }
}


