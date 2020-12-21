//
//  WelcomeAction.swift
//  WelcomeWindow
//
//  Created by Justin Kaufman on 12/21/20.
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, *)
public struct WelcomeAction: Identifiable {
    public let id: UUID = UUID()
    public let title: String
    public let detail: String
    public let systemImage: String
    public let onSelect: () -> ()
    
    public init(
        title: String,
        detail: String,
        systemImage: String,
        onSelect: () -> ()
    ) {
        self.title = title
        self.detail = detail
        self.systemImage = systemImage
        self.onSelect = onSelect
    }
}
