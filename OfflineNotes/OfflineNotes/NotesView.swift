//
//  NotesView.swift
//  OfflineNotes
//
//  Created by admin on 31/01/25.
//

import SwiftUI

struct NotesView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Notes.entity(),
        sortDescriptors: []
    ) private var notes: FetchedResults<Notes>
    
    @State private var showAddNoteView = false
    @State private var editNote : Notes?
    
    var body: some View {
        NavigationView{
            VStack{
                List {
                    ForEach(notes) { note in
                        NavigationLink(destination: EditNoteView(note: note)) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(note.title ?? "No Title")
                                    .padding(.top, 15)
                                    .padding(.bottom, 5)
                                    .font(.system(size: 20, weight: .semibold))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("Date: \(note.dateCreated.map { NotesView.dateFormatter.string(from: $0) } ?? "No Date")")
                                    .padding(.vertical, 5)
                                    .font(.system(size: 18))
                                    .foregroundColor(.secondary)
                                
                                Text(note.content ?? "No Content Available")
                                    .padding(.bottom, 2)
                                    .font(.system(size: 17))
                                    .lineLimit(8)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteNote(note)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Notes", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Notes")
                        .font(.title.bold())
                        .padding(.vertical, 5)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddNoteView = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddNoteView) {
                AddNoteView()
            }
        }
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.timeZone = TimeZone(identifier:  "Asia/Kolkata")
        return formatter
    } ()
        
    private func deleteNote(_ note: Notes) {
        viewContext.delete(note)
        do {
            try viewContext.save()
        } catch {
            print("Error deleting transaction: \(error)")
        }
    }
        
}


struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
