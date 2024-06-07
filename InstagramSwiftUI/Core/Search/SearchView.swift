//
//  SearchView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @State private var srachText = ""
    
    var body: some View {
        NavigationStack {
            UserListView(config: .explore)
        }
    }
}

#Preview {
    SearchView()
}


