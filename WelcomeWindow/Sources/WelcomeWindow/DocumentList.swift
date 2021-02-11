//
//  DocumentList.swift
//  WelcomeWindow
//
//  Created by Justin Kaufman on 12/21/20.
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, *)
public struct DocumentList: View {
    @Binding public var listTitle: String
    public let documents: [RecentDocument]
    @Binding var selectedDocument: Int?
   
    public var body: some View {
        List(selection: $selectedDocument) {
            Section(header: Text(listTitle)) {
                ForEach(documents.indices, id: \.self) { idx in
                    DocumentListRow(document: documents[idx])
                        .tag(idx)
                }
            }
        }
        .listStyle(SidebarListStyle())
    }
}
