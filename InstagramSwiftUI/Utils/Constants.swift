//
//  Constants.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import Foundation
import Firebase

struct FirestoreCollections {
    private static let Root = Firestore.firestore()
    static let users = Root.collection("users")
    // Add other collections if needed
}

struct MockSamples {
    static let photos = ["batman", "war-machine", "red-hood", "nightwing", "batgirl", "captain-america", "hawkeye", "black-panther", "ant-man", "spider-man", "iron-man", "wolverine", "captain-marvel", "scarlet-witch", "loki", "superman", "winter-soldier", "thor", "doctor-strange", "black-widow", "wonder-woman", "hulk", "gamora", "flash-person", "supergirl"]

}
