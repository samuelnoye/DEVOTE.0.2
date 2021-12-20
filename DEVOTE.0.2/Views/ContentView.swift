//
//  ContentView.swift
//  DEVOTE.0.2
//
//  Created by Samuel Noye on 13/12/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROPERTIES
    @State var task: String = ""
    
    // FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    
    // MARK: - FUNCTIONS
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 16){
                    TextField("New Task", text: $task)
                        .padding()
                        .background(
                            Color(UIColor.systemGray6)
                        ).cornerRadius(10)
                    Button(action:{
                        addItem()
                    },label: {
                        Spacer()
                        Text("SAVE")
                        Spacer()
                    })
                        .padding()
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .background(Color.red)
                    cornerRadius(10)
                }.padding()
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                        } label: {
                            Text(item.timestamp!, formatter: itemFormatter)
                        }
                    }
                    .onDelete(perform: deleteItems)
                 }//: LIST
               }//: VSTACK
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
            }
            
            Text("Select an item")
           
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
