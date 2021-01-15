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
        #if os(macOS)
            return ViewAccessor(onViewAdded: added) { self }
        #else
            return self
        #endif
    }
}

@available(macOS 11.0, *)
struct ViewAccessor<Content>: NSViewRepresentable where Content: View {
    var onView: (NSView) -> Void
    var viewBuilder: () -> Content

    typealias NSViewType = ViewAccessorHosting<Content>

    init(onViewAdded: @escaping (NSView) -> Void, @ViewBuilder viewBuilder: @escaping () -> Content) {
        self.onView = onViewAdded
        self.viewBuilder = viewBuilder
    }

    func makeNSView(context: Context) -> NSViewType {
        return ViewAccessorHosting(onView: onView, rootView: self.viewBuilder())
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
        nsView.rootView = self.viewBuilder()
    }
}

@available(macOS 11.0, *)
class ViewAccessorHosting<Content>: NSHostingView<Content> where Content: View {
    var onView: ((NSView) -> Void)
    
    init(onView: @escaping (NSView) -> Void, rootView: Content) {
        self.onView = onView
        super.init(rootView: rootView)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(rootView: Content) {
        fatalError("init(rootView:) has not been implemented")
    }
    
    override func didAddSubview(_ subview: NSView) {
        super.didAddSubview(subview)
        onView(subview)
    }
}
#endif
