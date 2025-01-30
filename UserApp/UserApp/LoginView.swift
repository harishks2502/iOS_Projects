//
//  LoginView.swift
//  UserApp
//
//  Created by admin on 28/01/25.
//



import SwiftUI

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: User.entity(), sortDescriptors: []) private var users: FetchedResults<User>
    
    @State private var username = ""
    @State private var password = ""
    @AppStorage("isAuthenticated") private var isAuthenticated = false
    @State private var showError = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .padding()

                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if showError {
                    Text("Invalid username or password!")
                        .foregroundColor(.red)
                }

                Button("Login") {
                    authenticateUser()
                }
                .buttonStyle(.borderedProminent)
                .padding()

                NavigationLink("Register", destination: RegisterView())
                    .padding()
            }
            .fullScreenCover(isPresented: $isAuthenticated) {
                DashboardView()
            }
        }
    }

    private func authenticateUser() {
        if users.contains(where: { $0.username == username && $0.password == password }) {
            isAuthenticated = true
        } else {
            showError = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
