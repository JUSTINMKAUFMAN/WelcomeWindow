//
//  WelcomeWindowDemoMacApp.swift
//  WelcomeWindowDemo
//
//  Created by Justin Kaufman on 12/21/20.
//

import SwiftUI
import WelcomeWindow

@main
struct WelcomeWindowDemoApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            WelcomeWindow(
                logoImage: Image(systemName: "qrcode.viewfinder"),
                titleText: "Welcome to App",
                actions: [
                    WelcomeAction(
                        title: "Create a new project",
                        detail: "Create a new project",
                        systemImage: "plus.square",
                        imageColor: Color.red,
                        isEnabled: false,
                        onSelect: { print("Action triggered") }
                    ),
                    WelcomeAction(
                        title: "Create a new project",
                        detail: "Create a new project",
                        systemImage: "plus.square",
                        imageColor: Color.green,
                        onSelect: { print("Action triggered") }
                    ),
                    WelcomeAction(
                        title: "Create a new project",
                        detail: "Create a new project",
                        systemImage: "plus.square",
                        onSelect: { print("Action triggered") }
                    )
                ],
                recentDocuments: [
                    RecentDocument(name: "MyDocA", detail: "/path/to/MyDocA"),
                    RecentDocument(name: "MyDocB", detail: "/path/to/MyDocB"),
                    RecentDocument(name: "MyDocB", detail: "/path/to/MyDocB", systemImage: "plus.square")
                ],
                handleOpenDocument: { doc in print("Document opened: \(doc.name)") }
            )
        }
    }
}
