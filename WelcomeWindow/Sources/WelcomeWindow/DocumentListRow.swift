//
//  DocumentListRow.swift
//  WelcomeWindow
//
//  Created by Justin Kaufman on 12/21/20.
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, *)
struct DocumentListRow: View {
    private let name: String
    private let detail: String
    private let imageSymbol: String
    private let imageColor: Color
    private let isRoot: Bool
    private let isSelected: Bool
    private let isHovered: Bool
    private let onSingleAction: () -> Void
    private let onDoubleAction: () -> Void

    init(
        name: String,
        detail: String,
        imageSymbol: String = "doc.fill",
        imageColor: Color = Color.blue,
        isRoot: Bool = true,
        isSelected: Bool = false,
        isHovered: Bool = false,
        onSingleAction: @escaping (() -> Void) = {},
        onDoubleAction: @escaping (() -> Void) = {}
    ) {
        self.name = name
        self.detail = detail
        self.imageSymbol = imageSymbol
        self.imageColor = imageColor
        self.isRoot = isRoot
        self.isSelected = isSelected
        self.isHovered = isHovered
        self.onSingleAction = onSingleAction
        self.onDoubleAction = onDoubleAction
    }
    
    var body: some View {
        HStack(alignment: .center) {
            if isRoot {
                Image(systemName: imageSymbol)
                    .font(.largeTitle)
                    .foregroundColor(imageColor)
                
                Spacer().frame(width: 13.0)
            } else {
                Image(systemName: "smallcircle.fill.circle.fill")
                    .font(.caption)
                    .foregroundColor(imageColor)
                
                Spacer().frame(width: 6.0)
            }
            
            VStack(alignment: .leading, spacing: 2.0) {
                Text(name)
                    .font(isRoot ? .body : .caption2)
                    .fontWeight(isSelected ? .bold : .regular)
                    .truncationMode(.tail)
                    .frame(minWidth: 24.0)
                
                if isRoot {
                    Text(detail)
                        .font(.system(size: 10.0))
                        .fontWeight(isSelected ? .semibold : .regular)
                        .truncationMode(.middle)
                }
            }
            
            Spacer()
            
            if isRoot {
                Image(systemName: "chevron.forward")
                    .font(.title3)
                    .foregroundColor(Color.blue)
            }
        }
        .padding(EdgeInsets(top: 2.0, leading: 16.0, bottom: 2.0, trailing: 6.0))
        .opacity(isHovered ? 0.75 : 1.0)
        .background(Color.white.opacity(0.000000000001))
        .gesture(TapGesture(count: 2).onEnded { onSingleAction() })
        .gesture(TapGesture(count: 1).onEnded { onDoubleAction() })
    }
}

struct DocumentListRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DocumentListRow(name: "Document A", detail: "1h", isRoot: true, isSelected: true)
            DocumentListRow(name: "Document B", detail: "2d", isRoot: false)
        }
    }
}
