//
//  ButtonViewModifier.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI

struct ButtonViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(Color(.systemBlue))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}


extension View {
    func instaButtonViewModifier() -> some View {
        self.modifier(ButtonViewModifier())
    }
}
