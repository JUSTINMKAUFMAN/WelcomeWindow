//
//  ViewExtensions.swift
//  WelcomeWindow
//
//  Created by Justin Kaufman on 2/11/21.
//

import SwiftUI

extension View {
    @ViewBuilder func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition { transform(self) } else { self }
    }
}
