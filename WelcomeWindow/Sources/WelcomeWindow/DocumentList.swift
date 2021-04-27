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
        List(
            documents,
            children: \.children,
            rowContent: { document in
                DocumentListRow(
                    document: document,
                    isSelected: selectedDocument == document
                )
                .tag(document)
                .onTapGesture {
                    if selectedDocument != document {
                        selectedDocument = document
                    }
                }
            }
        )
        .listStyle(SidebarListStyle())
        .onChange(of: selectedDocument) { document in
            if let document = document { didOpen(document) }
        }
    }
}

struct DocumentList_Previews: PreviewProvider {
    static var previews: some View {
        DocumentList(
            selectedDocument: .constant(nil),
            documents: [
                RecentDocument(name: "Document A", detail: "1d"),
                RecentDocument(
                    name: "Document B",
                    detail: "2h",
                    children: [
                        RecentDocument(name: "Child 1", detail: "1h"),
                        RecentDocument(name: "Child 2", detail: "4h")
                    ]
                ),
                RecentDocument(name: "Document C", detail: "6m")
            ],
            didOpen: { _ in }
        )
    }
}
