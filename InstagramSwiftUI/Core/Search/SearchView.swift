//
//  SearchView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI

struct SearchView: View {
    @State private var srachText = ""
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack (spacing: 8){
                    ForEach(User.MOCK_USERS) { user in
                        NavigationLink(value: user) {
                            SearchCell(user: user)
                        }
                    }
                }
                .navigationDestination(for: User.self, destination: { user in
                    ProfileView(user: user)
                })
                .searchable(text: $srachText)
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SearchView()
}


