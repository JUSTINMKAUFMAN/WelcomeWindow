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
    
    @State private var selectedDocument: RecentDocument? = nil
    @State private var hoverAction: WelcomeAction? = nil
    
    public let logoImage: Image
    public let titleText: String
    public let actions: [WelcomeAction]
    public let recentDocuments: [RecentDocument]
    public let handleOpenDocument: (RecentDocument) -> ()
    @Binding private var documentListTitle: String
    
    public init(
        logoImage: Image,
        titleText: String,
        actions: [WelcomeAction],
        recentDocuments: [RecentDocument],
        handleOpenDocument: (@escaping (RecentDocument) -> ()),
        documentListTitle: Binding<String> = .constant("Documents")
    ) {
        self.logoImage = logoImage
        self.titleText = titleText
        self.actions = actions
        self.recentDocuments = recentDocuments
        self.handleOpenDocument = handleOpenDocument
        self._documentListTitle = documentListTitle
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
                        HStack {
                            Spacer()
                        
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
                            
                            Spacer()
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
                listTitle: $documentListTitle,
                selectedDocument: $selectedDocument,
                documents: recentDocuments,
                didOpen: { document in handleOpenDocument(document) }
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
