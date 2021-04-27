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
    let isRoot: Bool
    let isSelected: Bool
    let isHovered: Bool
    let onAction: (RecentDocument) -> ()

    var body: some View {
        HStack(alignment: .center) {
            if isRoot {
                Image(systemName: document.systemImage)
                    .font(.largeTitle)
                    .foregroundColor(document.imageColor)
                
                Spacer().frame(width: 13.0)
            } else {
                Image(systemName: "smallcircle.fill.circle.fill")
                    .font(.caption)
                    .foregroundColor(document.imageColor)
                
                Spacer().frame(width: 6.0)
            }
            
            VStack(alignment: .leading, spacing: 2.0) {
                Text(document.name)
                    .font(isRoot ? .body : .caption2)
                    .fontWeight(isSelected ? .bold : .regular)
                    .truncationMode(.tail)
                    .frame(minWidth: 24.0)
                
                if isRoot {
                    Text(document.detail)
                        .font(.system(size: 10.0))
                        .fontWeight(isSelected ? .semibold : .regular)
                        .truncationMode(.middle)
                }
            }
            
            Spacer()
            
            if isRoot {
                Button(
                    action: { onAction(document) },
                    label: {
                        Image(systemName: "chevron.forward.circle")
                            .font(.title)
                            .foregroundColor(Color.blue)
                    }
                )
                .buttonStyle(BorderlessButtonStyle())
            }
        }
        .padding(EdgeInsets(top: 2.0, leading: 16.0, bottom: 2.0, trailing: 6.0))
        .opacity(isHovered ? 0.7 : 1.0)
        
    }
}

struct DocumentListRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DocumentListRow(
                document: RecentDocument(
                    name: "Document A",
                    detail: "1h"
                ),
                isRoot: true,
                isSelected: true,
                isHovered: false,
                onAction: { _ in }
            )
            
            DocumentListRow(
                document: RecentDocument(
                    name: "Document B",
                    detail: "2d"
                ),
                isRoot: false,
                isSelected: false,
                isHovered: false,
                onAction: { _ in }
            )
        }
    }
}
