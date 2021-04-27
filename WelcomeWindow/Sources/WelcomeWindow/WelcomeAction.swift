//
//  WelcomeAction.swift
//  WelcomeWindow
//
//  Created by Justin Kaufman on 12/21/20.
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, *)
public struct WelcomeAction: Identifiable, Equatable {
    public let id: UUID = UUID()
    public let title: String
    public let detail: String
    public let systemImage: String
    public let imageColor: Color
    public let isEnabled: Bool
    public let onSelect: () -> ()
   
    public init(
        title: String,
        detail: String,
        systemImage: String,
        imageColor: Color = Color.blue,
        isEnabled: Bool = true,
        onSelect: (@escaping () -> ())
    ) {
        self.title = title
        self.detail = detail
        self.systemImage = systemImage
        self.imageColor = imageColor
        self.isEnabled = isEnabled
        self.onSelect = onSelect
    }
    
    public static func == (lhs: WelcomeAction, rhs: WelcomeAction) -> Bool {
        lhs.id == rhs.id &&
            lhs.title == rhs.title &&
            lhs.detail == rhs.detail &&
            lhs.systemImage == rhs.systemImage &&
            lhs.imageColor == rhs.imageColor &&
            lhs.isEnabled == rhs.isEnabled
    }
}
