# WelcomeWindow

[![Version](https://img.shields.io/badge/spm-v1.4.1-blue)](https://github.com/JUSTINMKAUFMAN/WelcomeWindow/releases)
[![License](https://img.shields.io/badge/license-MIT-brightgreen)](https://github.com/JUSTINMKAUFMAN/WelcomeWindow/blob/master/LICENSE)
[![Platform](https://img.shields.io/badge/platform-macOS-orange)](https://github.com/JUSTINMKAUFMAN/WelcomeWindow)
[![Platform](https://img.shields.io/badge/platform-iOS-green)](https://github.com/JUSTINMKAUFMAN/WelcomeWindow)

A welcome screen for a SwiftUI application modeled after the 'Welcome to Xcode' window.

<p align="center">
    <img src="/WelcomeWindowDemoMac.gif" />
    <br>
    <img src="/WelcomeWindowDemoiOS.png" />
</p>

## Compatibility

WelcomeWindow is compatible with applications targeting **macOS 11+** and **iOS 14+**.

## Installation

### Swift Package Manager

`WelcomeWindow` is available as a Swift Package. To use it in your project, add it to your project's Swift Packages:

```swift
https://github.com/JUSTINMKAUFMAN/WelcomeWindow.git
```

## Usage

Refer to the `Demo` application (included in this repository) for sample usage. 

Alternatively, `WelcomeWindow` can be used as follows:

```swift
import SwiftUI
import WelcomeWindow

@main
struct WelcomeWindowDemoApp: App {
    // Optionally track the hover state of the logo (macOS only)
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
```

## Author

Justin Kaufman, jmkauf@gmail.com

## License

WelcomeWindow is available under the MIT license. See the LICENSE file for more info.
