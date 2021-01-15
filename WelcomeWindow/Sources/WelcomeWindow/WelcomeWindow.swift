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
    
    public let logoImage: Image
    public let titleText: String
    public let actions: [WelcomeAction]
    public let recentDocuments: [RecentDocument]
    public let handleOpenDocument: (RecentDocument) -> ()
    
    public init(
        logoImage: Image,
        titleText: String,
        actions: [WelcomeAction],
        recentDocuments: [RecentDocument],
        handleOpenDocument: (@escaping (RecentDocument) -> ())
    ) {
        self.logoImage = logoImage
        self.titleText = titleText
        self.actions = actions
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
                        HStack {
                            Image(systemName: action.systemImage)
                                .resizable()
                                .foregroundColor(.blue)
                                .frame(width: 30.0, height: 30.0)
                            
                            Spacer().frame(width: 12.0)
                            
                            VStack(alignment: .leading, spacing: 0.0) {
                                Text(action.title).font(.headline)
                                Text(action.detail).font(.subheadline)
                            }
                        }
                        .onTapGesture { action.onSelect() }
                    }
                }
            }
            .frame(width: 414.0)
            .padding(40.0)
            
            DocumentList(
                selectedDocument: $selectedDocument,
                documents: recentDocuments,
                didOpen: { document in handleOpenDocument(document) }
            )
        }
        .padding(.top, -19.0)
        .frame(height: 450.0)
        .presentedWindowStyle(HiddenTitleBarWindowStyle())
        .onView(added: { view in
            #if os(macOS)
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
            #endif
        })
        .background(colorScheme == .light ? Color(NSUIColor.white) : Color.clear)
    }
    
    private func getCurrentAppVersion() -> String {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
        let version = (appVersion as! String)
        return version
    }
}
