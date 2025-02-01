//
//  PostsView.swift
//  RestAPI
//
//  Created by admin on 01/02/25.
//

import SwiftUI

struct PostsView: View {
    @StateObject private var apiService = APIService()
    
    var body: some View {
        NavigationView {
            List(apiService.posts) { post in
                VStack(alignment: .leading, spacing: 15) {
                    Text(post.title)
                        .font(.headline)
                        .padding(.top, 10)
                    
                    Text(post.body)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Rectangle().fill(Color.clear).frame(height: 1)
                }
            }
            .navigationTitle("API Posts")
            .onAppear {
                apiService.fethPosts()
            }
        }
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
