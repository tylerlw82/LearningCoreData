//
//  UpdateView.swift
//  LearningCoreData
//
//  Created by Tyler Watt on 2021-08-29.
//

import SwiftUI

struct UpdateView: View {
    
    @StateObject var item: Item
    @State private var itemNameUpdate: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Update Item", text: $itemNameUpdate)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: updateItem) {
                    Label("", systemImage: "arrowshape.turn.up.left")
                }
                
            }.padding()
            Text(item.itemName ?? "")
            Spacer()
        }
    }
    
    
    
    private func updateItem() {
        withAnimation {
            item.itemName = itemNameUpdate
            PersistenceController.shared.saveContext()
        }
    }
}




struct UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let newItem = Item(context: viewContext)
        newItem.itemName = "IBM"
                
        return UpdateView(item: newItem)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)    }
}
