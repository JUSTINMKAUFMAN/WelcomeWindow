//
//  DocumentList.swift
//  WelcomeWindow
//
//  Created by Justin Kaufman on 12/21/20.
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, *)
public struct DocumentList: View {
    @Binding public var selectedDocument: RecentDocument?
    public let documents: [RecentDocument]
    public let didOpen: (RecentDocument) -> ()
    
    public var body: some View {
        List(selection: $selectedDocument) {
            ForEach(documents) { document in
                DocumentListRow(document: document)
                    .tag(document)
            }
        }
        .listStyle(SidebarListStyle())
        .onChange(of: selectedDocument) { document in
            if let document = document { didOpen(document) }
        }
    }
}
