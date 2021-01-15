//
//  WelcomeWindowDemoApp.swift
//  WelcomeWindowDemo
//
//  Created by Justin Kaufman on 12/21/20.
//

import SwiftUI
import WelcomeWindow

@main
struct MyApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            WelcomeWindow(
                logoImage: Image(systemName: "qrcode.viewfinder"),
                titleText: "Welcome to MyApp",
                actions: [
                    WelcomeAction(
                        title: "Create a new project",
                        detail: "Create a new project",
                        systemImage: "plus.square",
                        imageColor: Color.red,
                        isEnabled: false,
                        onSelect: { /* Handle action */ }
                    ),
                    WelcomeAction(
                        title: "Create a new project",
                        detail: "Create a new project",
                        systemImage: "plus.square",
                        imageColor: Color.green,
                        onSelect: { /* Handle action */ }
                    ),
                    WelcomeAction(
                        title: "Create a new project",
                        detail: "Create a new project",
                        systemImage: "plus.square",
                        onSelect: { /* Handle action */ }
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
