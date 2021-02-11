//
//  Extensions.swift
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

extension Binding {
    func didSet(execute: @escaping (Value) -> Void) -> Binding {
        return Binding(
            get: { wrappedValue },
            set: {
                wrappedValue = $0
                execute($0)
            }
        )
    }
}
