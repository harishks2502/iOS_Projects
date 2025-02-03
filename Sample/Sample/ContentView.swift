//
//  ContentView.swift
//  Sample
//
//  Created by admin on 03/02/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Data.entity(),
        sortDescriptors: []
    ) private var datas: FetchedResults<Data>
    
    @State private var showAddView = false
    @State private var editView: Data?
    
    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(datas) { data in
                        NavigationLink(destination: EditView(data: data)) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(data.title ?? "No Title")
                                    .font(.headline)
                                    .padding(.vertical, 5)
                                
                                Text(data.desc ?? "No Description")
                                    .padding(.vertical, 5)
                                
                                Text("\(data.date ?? Date(), formatter: dateFormatter)")
                                    .foregroundColor(.secondary)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .swipeActions {
                            Button(role: .destructive) {
                                delete(data)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Display Data")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddView = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddView) {
                AddView()
            }
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.timeZone = TimeZone(identifier: "Asia/Kolkata")
        return formatter
    } ()
    
    private func delete(_ data: Data) {
        viewContext.delete(data)
        do {
            try viewContext.save()
        } catch {
            print("Error deleting data: \(error.localizedDescription)")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
