//
//  PlatformAdapters.swift
//  WelcomeWindow
//
//  Created by Justin Kaufman on 12/21/20.
//

import SwiftUI

#if os(macOS)
    import AppKit

    public typealias NSUIView = NSView

    @available(iOS 14.0, macOS 11.0, *)
    public typealias NSUIScrollView = NSScrollView
    public typealias NSUILabel = NSTextField
    public typealias NSUIFont = NSFont
    public typealias NSUIColor = NSColor
    public typealias NSUIWindow = NSWindow

    public protocol NSUIViewRepresentable: NSViewRepresentable {
        typealias NSUIViewType = NSViewType
        func makeView(context: Self.Context) -> Self.NSUIViewType
        func updateView(_ view: Self.NSUIViewType, context: Self.Context)
    }

    public extension NSUIViewRepresentable {
        func makeView(context: Self.Context) -> Self.NSUIViewType {
            return makeNSView(context: context)
        }
        
        func updateView(_ view: Self.NSUIViewType, context: Self.Context) {
            updateNSView(view, context: context)
        }
    }
#elseif os(iOS)
    import UIKit

    public typealias NSUIView = UIView
    public typealias NSUIScrollView = UIScrollView
    public typealias NSUILabel = UILabel
    public typealias NSUIFont = UIFont
    public typealias NSUIColor = UIColor
    public typealias NSUIWindow = UIWindow

    public protocol NSUIViewRepresentable: UIViewRepresentable {
        typealias NSUIViewType = UIViewType
        func makeView(context: Self.Context) -> Self.NSUIViewType
        func updateView(_ view: Self.NSUIViewType, context: Self.Context)
    }

    public extension NSUIViewRepresentable {
        func makeView(context: Self.Context) -> Self.NSUIViewType {
            return makeUIView(context: context)
        }
        
        func updateView(_ view: Self.NSUIViewType, context: Self.Context) {
            updateUIView(view, context: context)
        }
    }
#else
    #error("Unsupported platform")
#endif
