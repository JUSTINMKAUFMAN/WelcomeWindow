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
    
    public init(
        name: String,
        detail: String,
        systemImage: String = "doc.fill"
    ) {
        self.name = name
        self.detail = detail
        self.systemImage = systemImage
    }
}
