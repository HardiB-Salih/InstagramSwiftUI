//
//  CommentView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/6/24.
//

import SwiftUI

struct CommentView: View {
    
    @State private var text = ""
    private var user: User {
        return User.MOCK_USERS[0]
    }
    
    let colors = [Color.red, Color.blue, Color.pink, Color.yellow, Color.red]
    
    var body: some View {
        VStack {
            Text("Comments")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(8)
            
            Divider()
            
            ScrollView {
                LazyVStack (spacing: 12){
                    ForEach(0 ..< 12) { comment in
                        CommentCell()
                            .padding(.horizontal)
                    }
                }
                
            }
            .scrollIndicators(.hidden)
            
            
            HStack (alignment: .bottom) {
                RoundedImageView(user.profileImageUrl, size: .xSmall, shape: .rounded(cornerRadius: 16))
                    .padding(2)
                    .overlay{
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(RadialGradient(gradient: Gradient(colors: colors), center: .center, startRadius: 5, endRadius: 500) , lineWidth: 1.0)
                    }
                
                HStack (alignment: .bottom){
                    TextField("Add a comment", text: $text, axis: .vertical)
                        .font(.footnote)
                    
                    Button(action: {}, label: {
                        Text("Post")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(.systemBlue))
                    })
                }
                .padding(12)
                .overlay{
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(RadialGradient(gradient: Gradient(colors: colors), center: .topLeading, startRadius: 5, endRadius: 500) , lineWidth: 1.0)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    CommentView()
}
