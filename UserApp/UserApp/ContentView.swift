//
//  ContentView.swift
//  UserApp
//
//  Created by admin on 28/01/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LoginView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
