# WelcomeWindow

[![Version](https://img.shields.io/badge/spm-v1.0.0-blue)](https://github.com/JUSTINMKAUFMAN/WelcomeWindow/releases)
[![License](https://img.shields.io/badge/license-MIT-brightgreen)](https://github.com/JUSTINMKAUFMAN/WelcomeWindow/blob/master/LICENSE)
[![Platform](https://img.shields.io/badge/platform-macOS-orange)](https://github.com/JUSTINMKAUFMAN/WelcomeWindow)

A welcome screen for a SwiftUI application modeled after the Welcome to Xcode window.

Compatible with applications targeting macOS 11+ and iOS 14+.

<p align="center">
<img src="/WelcomeWindow.png" />
</p>

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
                titleText: "Welcome to MyApp",
                actions: [
                    WelcomeAction(
                        title: "Create a new project", 
                        detail: "Create a new project",
                        systemImage: "plus.square",
                        onSelect: { /* Handle action */ }
                    ),
                    WelcomeAction(
                        title: "Create a new project", 
                        detail: "Create a new project",
                        systemImage: "plus.square",
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
                    RecentDocument(name: "MyDocB", detail: "/path/to/MyDocB")
                ],
                handleOpenDocument: { doc in /* Handle open document */ }
            )
        }
    }
}
```

## Author

Justin Kaufman, jmkauf@gmail.com

## License

WelcomeWindow is available under the MIT license. See the LICENSE file for more info.
