//
//  ProfileHeaderView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @State private var showEditView = false
    let colors = [Color.red, Color.blue, Color.pink, Color.yellow, Color.red]
    private var user: User {
        return viewModel.user
    }
    
    private var isFollowed: Bool {
        return user.isFollowed ?? false
    }
    
    private var buttonTitle: String {
        if user.isCurrentUser {
            return "Edit Profile"
        } else {
            return isFollowed ? "Following" : "Follow"
        }
    }
    
    private var buttonForegroundColor: Color {
        if user.isCurrentUser || isFollowed {
            return Color(.label)
        } else {
            return Color(.systemBackground)
        }
    }
    
    private var buttonBackgroundColor: Color {
        if user.isCurrentUser || isFollowed {
            return Color(.systemBackground)
        } else {
            return Color(.systemBlue)
        }
    }
    
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
    }

    
    var body: some View {
        VStack (spacing: 10) {
            HStack {
                RoundedImageView(user.profileImageUrl, size: .xLarge, shape: .circle)
                    .padding(3)
                    .overlay{
                        Circle()
                            .stroke(LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing) , lineWidth: 1.0)
                    }
                
                HStack(spacing: 8) {
                    UserStatView(value: 3, title: "Posts")
                    UserStatView(value: 6, title: "Followers")
                    UserStatView(value: 11, title: "Followring")
                }
                Spacer()
            }
            .padding(.horizontal)
            
            
            VStack (alignment: .leading, spacing: 4){
                Text(user.username)
                    .fontWeight(.semibold)
                if let fullname = user.fullname {
                    Text(fullname)
                }
            }
            .padding(.horizontal)
            .font(.footnote)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            Button(action: {
                if user.isCurrentUser {
                    showEditView.toggle()
                } else {
                 handleFollowTapped()
                }
            }, label: {
                Text(buttonTitle)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 6)
                    .foregroundStyle(buttonForegroundColor)
                    .background(buttonBackgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    }
                    .padding(.horizontal)
            })
            
            Divider()
        }
        .fullScreenCover(isPresented: $showEditView) {
            NavigationStack { EditProfileView(user: user) }
        }
        .onAppear {
            print("🚀  I am onAppear")
        }
    }
    
    
    func handleFollowTapped () {
        if isFollowed {
            viewModel.unFollow()
        } else {
            viewModel.follow()
        }
    }
    
    
    
}

//#Preview {
//    ProfileHeaderView(user: User.MOCK_USERS.first!)
//}
