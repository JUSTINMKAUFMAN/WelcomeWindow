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
    @State private var selectedDocument: Int? = nil
    
    public var body: some View {
        VStack {
            HStack {
                Text(listTitle)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            
            List(
                documents,
                children: \.children,
                rowContent: { document in
                    DocumentListRow(
                        document: document,
                        isSelected: (selectedDocument != nil) ? (documents[selectedDocument!] == document) : false
                    )
                    .onTapGesture {
                        if let idx = documents.firstIndex(of: document), idx != selectedDocument {
                            selectedDocument = idx
                            onOpen(document)
                        }
                    }
                    .contextMenu { document.contextMenu?() }
                }
            )
            .listStyle(SidebarListStyle())
        }
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
