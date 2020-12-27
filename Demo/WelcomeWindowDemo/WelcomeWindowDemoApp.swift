//
//  WelcomeWindowDemoApp.swift
//  WelcomeWindowDemo
//
//  Created by Justin Kaufman on 12/21/20.
//

import SwiftUI
import WelcomeWindow

@main
struct WelcomeWindowDemoApp: App {
    var body: some Scene {
        WindowGroup {
            WelcomeWindow(
                logoImage: Image(systemName: "qrcode.viewfinder"),
                titleText: "Welcome to MyApp",
                actions: [
                    WelcomeAction(
                        title: "Create a new project",
                        detail: "Create a new project",
                        systemImage: "plus.square",
                        onSelect: { print("Triggered Action 1") }
                    ),
                    WelcomeAction(
                        title: "Create another new project",
                        detail: "Create another new project",
                        systemImage: "plus.square",
                        onSelect: { print("Triggered Action 2") }
                    ),
                    WelcomeAction(
                        title: "Create yet another new project",
                        detail: "Create yet another new project",
                        systemImage: "plus.square",
                        onSelect: { print("Triggered Action 3") }
                    )
                ],
                recentDocuments: [
                    RecentDocument(name: "MyDocA", detail: "~/path/to/MyDocA"),
                    RecentDocument(name: "MyDocB", detail: "~/path/to/MyDocB")
                ],
                handleOpenDocument: { doc in print("Opened Document: \(doc.name)") }
            )
        }
    }
}
