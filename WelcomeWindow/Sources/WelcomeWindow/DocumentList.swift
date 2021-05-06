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
    @Binding public var recentDocuments: [RecentDocument] {
        didSet { DispatchQueue.main.async { onUpdate() } }
    }
    
    let onOpen: (RecentDocument) -> ()
    
    @State private var documents: [RecentDocument] = []
    @State private var hoveredDocument: RecentDocument? = nil
    @State private var selectedDocument: RecentDocument? = nil
    
    private static let titleIdentifier: String = "TITLE"
    private var titleItem: RecentDocument {
        RecentDocument(id: DocumentList.titleIdentifier,  name: listTitle)
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            List(
                documents,
                id: \.id,
                children: \.children,
                selection: $selectedDocument,
                rowContent: { document in
                    if document.id == DocumentList.titleIdentifier {
                        HStack {
                            Section(header: Text(listTitle).foregroundColor(Color.secondary)) {}
                            Spacer()
                        }
                        .disabled(true)
                    } else {
                        DocumentListRow(
                            name: document.name,
                            detail: document.detail,
                            imageSymbol: document.systemImage,
                            imageColor: document.imageColor,
                            isRoot: documents.contains(document),
                            isSelected: selectedDocument == document,
                            isHovered: hoveredDocument == document,
                            onSingleAction: { onSelect(document) },
                            onDoubleAction: { onOpen(document) }
                        )
                        .onHover { hoveredDocument = $0 ? document : nil }
                        .contextMenu { document.contextMenu?() }
                    }
                }
            )
            .listStyle(SidebarListStyle())
        }
        .background(Color.white.opacity(0.0000000000001))
        .onTapGesture { onSelect(nil) }
        .onAppear { onUpdate() }
    }

    private func onDoubleAction(_ document: RecentDocument) {
        onOpen(document)
    }
    
    private func onSelect(_ document: RecentDocument?) {
        selectedDocument = document
    }
    
    private func onOpen(_ document: RecentDocument) {
        guard documents.contains(document) else { onSelect(document); return }
        onOpen(document)
        DispatchQueue.main.async { onSelect(nil) }
    }

    private func onUpdate() {
        documents = [titleItem] + recentDocuments
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
