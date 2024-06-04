//
//  Int + Extension.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import Foundation

extension Int {
    var formattedInstaLike: String {
        switch self {
        case 1_000_000...:
            return String(format: "%.1fm", Double(self) / 1_000_000).replacingOccurrences(of: ".0", with: "")
        case 1_000...:
            return String(format: "%.1fk", Double(self) / 1_000).replacingOccurrences(of: ".0", with: "")
        default:
            return String(self)
        }
    }
}
