//
//  DashboardView.swift
//  UserApp
//
//  Created by admin on 28/01/25.
//

import SwiftUI

struct DashboardView: View {
    @AppStorage("isAuthenticated") private var isAuthenticated = false
    
    var body: some View {
        VStack {
            Text("Welcome to the Dashboard!")
                .font(.largeTitle)
                .padding()

            Button("Logout") {
                logout()
            }
            .buttonStyle(.bordered)
            .padding()
        }
    }

    private func logout() {
        isAuthenticated = false
    }
}
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
