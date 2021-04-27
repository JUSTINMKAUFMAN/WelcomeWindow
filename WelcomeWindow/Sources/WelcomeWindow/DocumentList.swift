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
    let onOpen: (RecentDocument) -> ()
    
    @State private var selectedDocument: UUID? = nil
    @State private var hoveredDocument: UUID? = nil
    
    public var body: some View {
        List(
            documents,
            children: \.children,
            rowContent: { document in
                let isRoot = documents.contains(document)
                
                VStack {
                    if documents[0] == document {
                        HStack {
                            Section(header: Text(listTitle)) {}
                            Spacer()
                        }
                    }
                    
                    DocumentListRow(
                        document: document,
                        isRoot: isRoot,
                        isSelected: isRoot ? (selectedDocument == document.id) : false,
                        isHovered: hoveredDocument == document.id,
                        onAction: { if isRoot { selectedDocument = $0.id; onOpen($0) } }
                    )
                    .onHover { _ in hoveredDocument = document.id }
                    .contextMenu { document.contextMenu?() }
                }
            }
        )
        .listStyle(SidebarListStyle())
    }
}

struct DocumentList_Previews: PreviewProvider {
    static var previews: some View {
        DocumentList(
            listTitle: .constant("FILES"),
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
            onOpen: { _ in }
        )
    }
}
