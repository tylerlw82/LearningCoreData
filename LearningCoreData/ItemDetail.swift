//
//  ItemDetail.swift
//  LearningCoreData
//
//  Created by Tyler Watt on 2021-08-29.
//

import SwiftUI

struct ItemDetail: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var item: Item
    @State private var objectName: String = ""
    
    
    var body: some View {
        
        //Navigation
        VStack {
            HStack {
                TextField("Object word goes here", text: $objectName)
                
                Button(action: addObjects) {
                    Label("", systemImage: "plus")
                }
            }.padding()
            
            
            
            //List
            List {
                ForEach(item.objectsArray) { item in
                    Text(item.unwrappedName)
                }.onDelete(perform: deleteObject)
            }
        }.navigationTitle("Objects < Items")
    }
    
    
    //Adding Objects
    private func addObjects() {
        withAnimation {
            let newObject = Object(context: viewContext)
            newObject.objectName = objectName
            
            item.addToObjects(newObject)
            PersistenceController.shared.saveContext()
        }
    }
    
    
    //Deleting Objects
     func deleteObject(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let object = item.objectsArray[index]
                
                viewContext.delete(object)
                PersistenceController.shared.saveContext()
            }
        }
    }
}






//MARK: For Previewing Core Data Implementation
struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let newItem = Item(context: viewContext)
        newItem.itemName = "Thing One"

        return ItemDetail(item: newItem)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
