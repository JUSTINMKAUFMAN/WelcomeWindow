# WelcomeWindow

[![Version](https://img.shields.io/badge/spm-v1.0.0-blue)](https://github.com/JUSTINMKAUFMAN/WelcomeWindow/releases)
[![License](https://img.shields.io/badge/license-MIT-brightgreen)](https://github.com/JUSTINMKAUFMAN/WelcomeWindow/blob/master/LICENSE)
[![Platform](https://img.shields.io/badge/platform-macOS-orange)](https://github.com/JUSTINMKAUFMAN/WelcomeWindow)

A welcome screen for a macOS application modeled after the Welcome to Xcode window.

<p align="center">
<img src="/WelcomeWindow.png" />
</p>

## Installation

### Swift Package Manager

WelcomeWindow is available as a Swift Package. To use it in your project, add it to your project's Swift Packages:

```swift
https://github.com/JUSTINMKAUFMAN/WelcomeWindow.git
```

## Usage

The top drawer can be added to any `UIViewController` simply by initializing an instance of `TopDrawer` and adding it as a subview. For example:

```swift
class ViewController: UIViewController {
let topDrawer = TopDrawer()

init() {
super.init(nibName: nil, bundle: nil)
view.addSubview(topDrawer)
}

required init?(coder aDecoder: NSCoder) {
fatalError("init(coder:) has not been implemented")
}
}
```

Note that you should _not_ add your own auto-layout constraints to `TopDrawer` (layout is handled internally by adjusting the frame position/visibility).

See the sample project for a basic implementation. 

## Author

Justin Kaufman, jmkauf@gmail.com

## License

TopDrawer is available under the MIT license. See the LICENSE file for more info.
