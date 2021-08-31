//
//  ContentView.swift
//  LearningCoreData
//
//  Created by Tyler Watt on 2021-08-29.
//


import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.itemName, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var newItemCreated: String = ""

    var body: some View {
        
        NavigationView {
            VStack {
                HStack {
                    TextField("Item goes here", text: $newItemCreated)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: addItem) {
                        Label("", systemImage: "plus")
                    }.padding()
                }.padding()
                
                
                List {
                    ForEach(items) { item in
                        NavigationLink (destination: ItemDetail(item: item)) {
                            Text(item.itemName ?? "")
                        }.toolbar {EditButton()}
                    }.onDelete(perform: deleteItems)
                }
            }.navigationTitle("Items & Objects")
        }
    }
    
    
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.itemName = newItemCreated
            PersistenceController.shared.saveContext()
        }
    }
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            PersistenceController.shared.saveContext()
        }
    }
    
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
