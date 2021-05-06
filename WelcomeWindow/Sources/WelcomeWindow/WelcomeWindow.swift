//
//  WelcomeWindow.swift
//  WelcomeWindow
//
//  Created by Justin Kaufman on 12/21/20.
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, *)
public struct WelcomeWindow: View {
    @Environment(\.colorScheme) var colorScheme
    
    private let logoImage: Image
    private let titleText: String
    private let actions: [WelcomeAction]
    private let handleOpenDocument: (RecentDocument) -> ()
    private let documentListTitle: String
    private let recentDocuments: [RecentDocument]
    
    @State private var selectedDocument: Int? = nil
    @State private var hoverAction: WelcomeAction? = nil
    
    public init(
        logoImage: Image = Image(systemName: "qrcode.viewfinder"),
        titleText: String = "Welcome",
        actions: [WelcomeAction] = [],
        documentListTitle: String = "Documents",
        recentDocuments: [RecentDocument] = [],
        handleOpenDocument: (@escaping (RecentDocument) -> ())
    ) {
        self.logoImage = logoImage
        self.titleText = titleText
        self.actions = actions
        self.documentListTitle = documentListTitle
        self.recentDocuments = recentDocuments
        self.handleOpenDocument = handleOpenDocument
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 0.0) {
            VStack(alignment: .center, spacing: 0.0) {
                logoImage
                    .resizable()
                    .frame(width: 100.0, height: 100.0)
                
                Spacer().frame(height: 3.0)
                
                Text(titleText)
                    .font(.system(size: 36.0))
                    
                Spacer().frame(height: 7.0)
                
                Text("Version \(getCurrentAppVersion())")
                    .font(.system(size: 13.0))
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                
                Spacer().frame(minHeight: 6.0)
                
                VStack(alignment: .leading, spacing: 16.0) {
                    ForEach(actions) { action in
                        HStack(spacing: 8.0) {
                            Image(systemName: action.systemImage)
                                .font(.system(size: 32.0))
                                .foregroundColor(action.imageColor)
                                .opacity(action == hoverAction ? 0.6 : 1.0)
                            
                            VStack(alignment: .leading, spacing: 0.0) {
                                Text(action.title)
                                    .font(.headline)
                                    .opacity(action == hoverAction ? 0.6 : 1.0)
                                
                                Text(action.detail)
                                    .font(.subheadline)
                                    .opacity(action == hoverAction ? 0.6 : 1.0)
                            }
                        }
                        .onTapGesture { if action.isEnabled { action.onSelect() } }
                        .opacity(action.isEnabled ? 1.0 : 0.5)
                        .onHover { hoverAction = $0 ? action : nil }
                    }
                }
            }
            .frame(width: 414.0)
            .padding(40.0)
            
            DocumentList(
                listTitle: documentListTitle,
                documents: recentDocuments,
                onOpen: { handleOpenDocument($0) }
            )
        }
        .padding(.top, -19.0)
        .frame(height: 450.0)
        .modifier(WelcomeWindowAppearance(colorScheme: colorScheme))
        .background(colorScheme == .light ? Color(NSUIColor.white) : Color.clear)
    }
    
    private func getCurrentAppVersion() -> String {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
        let version = (appVersion as! String)
        return version
    }
}

struct WelcomeWindowAppearance: ViewModifier {
    var colorScheme: ColorScheme
    
    func body(content: Content) -> some View {
        #if os(macOS)
            return content
                .presentedWindowStyle(HiddenTitleBarWindowStyle())
                .onView(added: { view in
                    /// Add window appearance customizations not available in SwiftUI
                    DispatchQueue.main.async {
                        guard let window = view.window else { return }
                        
                        window.isMovableByWindowBackground = true
                        window.titlebarAppearsTransparent = true
                        window.titlebarSeparatorStyle = .none
                        window.titleVisibility = .hidden
                        
                        window.toolbar = nil
                        window.styleMask.remove(.closable)
                        window.styleMask.remove(.miniaturizable)
                        window.styleMask.remove(.resizable)
                        window.setContentSize(CGSize(width: 801.0, height: 460.0))
                        window.backgroundColor = colorScheme == .light ? .white : .windowBackgroundColor
                    }
                })
        #else
            return content
        #endif
    }
}

struct WelcomeWindow_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeWindow(
            actions: [
                WelcomeAction(
                    title: "Create a new project",
                    detail: "Create a new project",
                    systemImage: "plus.square",
                    onSelect: {}
                )
            ],
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
                    children: [
                        RecentDocument(
                            name: "ChildDocA",
                            detail: "/path/to/ChildDocA"
                        )
                    ]
                ),
                RecentDocument(
                    name: "MyDocB",
                    detail: "/path/to/MyDocB",
                    systemImage: "plus.square"
                )
            ],
            handleOpenDocument: { _ in }
        )
    }
}
