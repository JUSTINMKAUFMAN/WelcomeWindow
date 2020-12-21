//
//  ViewAccessor.swift
//  WelcomeWindow
//
//  Created by Justin Kaufman on 12/21/20.
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, *)
extension View {
    func onView(added: @escaping (NSUIView) -> Void) -> some View {
        ViewAccessor(onViewAdded: added) { self }
    }
}

@available(iOS 14.0, macOS 11.0, *)
struct ViewAccessor<Content>: NSUIViewRepresentable where Content: View {
    var onView: (NSUIView) -> Void
    var viewBuilder: () -> Content
    typealias NSUIViewType = ViewAccessorHosting<Content>
    
    init(onViewAdded: @escaping (NSUIView) -> Void, @ViewBuilder viewBuilder: @escaping () -> Content) {
        self.onView = onViewAdded
        self.viewBuilder = viewBuilder
    }
    
    #if os(macOS)
        func makeNSView(context: Context) -> ViewAccessorHosting<Content> {
            return ViewAccessorHosting(onView: onView, rootView: self.viewBuilder())
        }
        
        func updateNSView(_ nsView: ViewAccessorHosting<Content>, context: Context) {
            nsView.rootView = self.viewBuilder()
        }
    #elseif os(iOS)
        func makeUIView(context: Context) -> ViewAccessorHosting<Content> {
            return ViewAccessorHosting(onView: onView, rootView: self.viewBuilder())
        }
        
        func updateUIView(_ uiView: ViewAccessorHosting<Content>, context: Context) {
            uiView.rootView = self.viewBuilder()
        }
    #else
        #error("Unsupported platform")
    #endif
}

@available(iOS 14.0, macOS 11.0, *)
class ViewAccessorHosting<Content>: NSUIHostingView<Content> where Content: View {
    var onView: ((NSUIView) -> Void)
    
    init(onView: @escaping (NSUIView) -> Void, rootView: Content) {
        self.onView = onView
        super.init(rootView: rootView)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(rootView: Content) {
        fatalError("init(rootView:) has not been implemented")
    }
    
    override func didAddSubview(_ subview: NSUIView) {
        super.didAddSubview(subview)
        onView(subview)
    }
}
