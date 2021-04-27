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
    public let children: [RecentDocument]?
    public let systemImage: String
    public let imageColor: Color
    
    public init(
        name: String,
        detail: String,
        children: [RecentDocument]? = nil,
        systemImage: String = "doc.fill",
        imageColor: Color = Color.accentColor
    ) {
        self.name = name
        self.detail = detail
        self.children = children
        self.systemImage = systemImage
        self.imageColor = imageColor
    }
}
