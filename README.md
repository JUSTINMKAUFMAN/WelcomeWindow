# WelcomeWindow

[![Version](https://img.shields.io/badge/spm-v1.2.4-blue)](https://github.com/JUSTINMKAUFMAN/WelcomeWindow/releases)
[![License](https://img.shields.io/badge/license-MIT-brightgreen)](https://github.com/JUSTINMKAUFMAN/WelcomeWindow/blob/master/LICENSE)
[![Platform](https://img.shields.io/badge/platform-macOS-orange)](https://github.com/JUSTINMKAUFMAN/WelcomeWindow)

A welcome screen for a SwiftUI application modeled after the Welcome to Xcode window.

<p align="center">
    <img src="/WelcomeWindowDemoMac.png" />
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
struct MyApp: App {
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
                recentDocuments: .constant([
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
                ]),
                handleOpenDocument: { doc in print("Document opened: \(doc.name)") }
            )
        }
    }
}
```

## Author

Justin Kaufman, jmkauf@gmail.com

## License

WelcomeWindow is available under the MIT license. See the LICENSE file for more info.
