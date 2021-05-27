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
    @State var isHoveringLogo: Bool = false
    
    private var logoView: AnyView {
        AnyView(
            Image(systemName: "qrcode.viewfinder")
                .resizable()
                .scaleEffect(isHoveringLogo ? 0.8 : 1.0)
                .rotationEffect(Angle(degrees: isHoveringLogo ? 180.0 : 0.0))
                .animation(.easeInOut, value: isHoveringLogo)
                .onHover { isHoveringLogo = $0 }
        )
    }
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            WelcomeWindow(
                logoView: logoView,
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
                documentListTitle: "Recently Opened",
                recentDocuments: [
                    RecentDocument(
                        name: "MyDocA",
                        detail: "/path/to/MyDocA",
                        contextMenu: {
                            AnyView(
                                VStack {
                                    Button(
                                        action: { print("Context Action A triggered") },
                                        label: { Text("Context Action A") }
                                    )
                                    Button(
                                        action: { print("Context Action B triggered") },
                                        label: { Text("Context Action B") }
                                    )
                                }
                            )
                        }
                    ),
                    RecentDocument(
                        name: "MyDocB",
                        detail: "/path/to/MyDocB",
                        contextMenu: {
                            AnyView(
                                VStack {
                                    Button(
                                        action: { print("Context Action A triggered") },
                                        label: { Text("Context Action A") }
                                    )
                                    Button(
                                        action: { print("Context Action B triggered") },
                                        label: { Text("Context Action B") }
                                    )
                                }
                            )
                        }
                    ),
                    RecentDocument(
                        name: "MyDocB",
                        detail: "/path/to/MyDocB",
                        systemImage: "plus.square",
                        contextMenu: {
                            AnyView(
                                VStack {
                                    Button(
                                        action: { print("Context Action A triggered") },
                                        label: { Text("Context Action A") }
                                    )
                                    Button(
                                        action: { print("Context Action B triggered") },
                                        label: { Text("Context Action B") }
                                    )
                                }
                            )
                        }
                    )
                ],
                handleOpenDocument: { doc in print("Document opened: \(doc.name)") },
                isHoveringLogo: $isHoveringLogo
            )
        }
    }
}
