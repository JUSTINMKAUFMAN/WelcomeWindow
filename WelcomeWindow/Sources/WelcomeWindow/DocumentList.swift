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
    @Binding public var selectedDocument: RecentDocument?
    @Binding public var documents: [RecentDocument]
    public let didOpen: (RecentDocument) -> ()
    
    @State private var hoverDocument: RecentDocument? = nil
   
    public var body: some View {
        List(selection: $selectedDocument) {
            Section(header: Text(listTitle)) {
                ForEach(documents) { DocumentListRow(document: $0) }
            }
        }
        .listStyle(SidebarListStyle())
        .if(selectedDocument != nil) {
            $0.onChange(of: selectedDocument) { didOpen($0!) }
        }
    }
}
