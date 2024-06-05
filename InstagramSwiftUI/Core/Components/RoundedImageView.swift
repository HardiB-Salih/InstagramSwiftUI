//
//  RoundedImageView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/5/24.
//
// Kingfisher || https://github.com/onevcat/Kingfisher

import SwiftUI
import Kingfisher

struct RoundedImageView: View {
    //MARK: - Properties
    var profileImageUrl : String?
    var size: Size
    var shape: ImageShape
    var fallbackImage: String = "person.fill"
    
    //MARK: - Computed Properties
    var cornerRadius : CGFloat {
        switch shape {
        case .rounded(let cornerRadius):
            return cornerRadius
        case .circle:
            return size.dimension / 2
        }
    }
    
    //MARK: - INIT
    init(_ profileImageUrl: String? = nil,
         size: Size,
         shape: ImageShape) {
        self.profileImageUrl = profileImageUrl
        self.size = size
        self.shape = shape
    }
    
    //MARK: - View
    var body: some View {
        if let profileImageUrl {
            KFImage(URL(string: profileImageUrl))
                .resizable()
                .placeholder({ ProgressView() })
                .scaledToFill()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                .frame(width: size.dimension, height: size.dimension)
        } else {
            placeholderImageView()
        }
    }
    
    private func placeholderImageView() -> some View {
        ZStack {
            Color(.systemGray3)

            Image(systemName: fallbackImage)
                .resizable()
                .foregroundStyle(.white)
                .padding(8)
        }
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .frame(width: size.dimension, height: size.dimension)
        
        
    }
}
//MARK: - Preview
#Preview {
    RoundedImageView(size: .small, shape: .rounded(cornerRadius: 12))
}


//MARK: - ImageShape
enum ImageShape {
    case rounded(cornerRadius: CGFloat)
    case circle
}

//MARK: - Size
enum Size{
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge
    case xxLarge
    case custom(CGFloat)
    
    // MARK: - Computed Properties for Flexible Sizing
    var dimension: CGFloat {
        switch self {
        case .xxSmall:
            return SizeDimensions.xxSmall
        case .xSmall:
            return SizeDimensions.xSmall
        case .small:
            return SizeDimensions.small
        case .medium:
            return SizeDimensions.medium
        case .large:
            return SizeDimensions.large
        case .xLarge:
            return SizeDimensions.xLarge
        case .xxLarge:
            return SizeDimensions.xxLarge
        case .custom(let size):
            return size
        }
    }
}

//MARK: - SizeDimensions
private struct SizeDimensions {
    static let xxSmall: CGFloat = 30
    static let xSmall: CGFloat = 40
    static let small: CGFloat = 50
    static let medium: CGFloat = 60
    static let large: CGFloat = 80
    static let xLarge: CGFloat = 100
    static let xxLarge: CGFloat = 120
}
