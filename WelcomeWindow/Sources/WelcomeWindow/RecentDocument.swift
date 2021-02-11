//
//  RecentDocument.swift
//  WelcomeWindow
//
//  Created by Justin Kaufman on 12/21/20.
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, *)
public struct RecentDocument: Identifiable, Hashable {
    public let id: UUID = UUID()
    public let name: String
    public let detail: String
    public let systemImage: String
    public let imageColor: Color
    public let contextMenu: (() -> AnyView)?
    
    public init(
        name: String,
        detail: String,
        systemImage: String = "doc.fill",
        imageColor: Color = Color.accentColor,
        contextMenu: (() -> AnyView)? = nil
    ) {
        self.name = name
        self.detail = detail
        self.systemImage = systemImage
        self.imageColor = imageColor
        self.contextMenu = contextMenu
    }
    
    public static func == (lhs: RecentDocument, rhs: RecentDocument) -> Bool {
        lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.detail == rhs.detail &&
            lhs.systemImage == rhs.systemImage &&
            lhs.imageColor == rhs.imageColor
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(detail)
        hasher.combine(systemImage)
        hasher.combine(imageColor)
    }
}
