//
//  DocumentListRow.swift
//  WelcomeWindow
//
//  Created by Justin Kaufman on 12/21/20.
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, *)
struct DocumentListRow: View {
    let document: RecentDocument
    @State private var isHovered: Bool = false

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: document.systemImage)
                .font(.largeTitle)
                .foregroundColor(document.imageColor)

            Spacer().frame(width: 13.0)
            
            VStack(alignment: .leading, spacing: 2.0) {
                Text(document.name)
                    .font(.body)
                    .truncationMode(.tail)
                    .frame(minWidth: 24.0)
                
                Text(document.detail)
                    .font(.system(size: 10.0))
                    .truncationMode(.middle)
            }
        }
        .padding(EdgeInsets(top: 2.0, leading: 16.0, bottom: 2.0, trailing: 6.0))
        .opacity(isHovered ? 0.7 : 1.0)
        .onHover { isHovered = $0 }
        .contextMenu { document.contextMenu?() }
    }
}
