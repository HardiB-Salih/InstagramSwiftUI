//
//  TextFieldViewModifier.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI

struct TextFieldViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}


extension View {
    func instaTextFieldViewModifier() -> some View {
        self.modifier(TextFieldViewModifier())
    }
}
