//
//  UIManager.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI
import UIKit

let UIManager = _UIManager()
class _UIManager {
    
    //MARK: - TabBar
    /// Configures the tab bar to have an opaque background.
    ///
    /// This function sets up the `UITabBarAppearance` for the tab bar and applies
    /// an opaque background to it, ensuring it appears solid and not transparent.
    func makeTabBarOpaque() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    /// Changes the background color of the UITabBar.
    /// - Parameter color: The UIColor to set as the background color of the UITabBar.
    func changeTabBarBackgroundColor(to color: UIColor) {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = color
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    //MARK: - NavigationBar
    /// Configures the navigation bar to have an opaque background.
    func makeNavigationBarOpaque() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }

    /// Changes the background color of the navigation bar.
    ///
    /// - Parameter color: The desired background color for the navigation bar.
    func setNavigationBarBackgroundColor(_ color: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = color
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
}
