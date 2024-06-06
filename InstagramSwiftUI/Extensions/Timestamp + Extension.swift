//
//  Timestamp + Extension.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/6/24.
//

import Firebase

extension Timestamp: Comparable {
    public static func < (lhs: Timestamp, rhs: Timestamp) -> Bool {
        return lhs.seconds < rhs.seconds || (lhs.seconds == rhs.seconds && lhs.nanoseconds < rhs.nanoseconds)
    }
    
    public static func == (lhs: Timestamp, rhs: Timestamp) -> Bool {
        return lhs.seconds == rhs.seconds && lhs.nanoseconds == rhs.nanoseconds
    }
}

