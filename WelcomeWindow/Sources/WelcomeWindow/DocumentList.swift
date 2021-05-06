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
    @Binding public var recentDocuments: [RecentDocument] { willSet { DispatchQueue.main.async { documents = newValue } } }
    let onOpen: (RecentDocument) -> ()
    
    @State private var documents: [RecentDocument] = []
    @State private var hoveredDocument: RecentDocument? = nil
    @State private var selectedDocument: RecentDocument? = nil
    
    public var body: some View {
        List(
            documents,
            id: \.id,
            children: \.children,
            selection: $selectedDocument,
            rowContent: { document in
                VStack {
                    if documents.firstIndex(of: document) == 0 {
                        HStack {
                            Section(header: Text(listTitle)) {}
                            Spacer()
                        }
                    }
                    
                    let isRoot = documents.contains(document)
                    
                    DocumentListRow(
                        name: document.name,
                        detail: document.detail,
                        imageSymbol: document.systemImage,
                        imageColor: document.imageColor,
                        isRoot: isRoot,
                        isSelected: isRoot ? (selectedDocument?.id == document.id) : false,
                        isHovered: hoveredDocument?.id == document.id,
                        onAction: { handleDocumentAction(document, isRoot: isRoot) }
                    )
                    .onHover { _ in hoveredDocument = document }
                    .contextMenu { document.contextMenu?() }
                }
            }
        )
        .listStyle(SidebarListStyle())
        .onAppear { setup() }
    }
    
    private func setup() {
        documents = recentDocuments
    }
    
    private func handleDocumentAction(_ document: RecentDocument, isRoot: Bool = true) {
        guard isRoot else { return }
        selectedDocument = document
        onOpen(document)
    }
}

struct DocumentList_Previews: PreviewProvider {
    static var previews: some View {
        DocumentList(
            listTitle: .constant("FILES"),
            recentDocuments: .constant([
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
            ]),
            onOpen: { _ in }
        )
    }
}
