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

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: document.systemImage)
                .resizable()
                .foregroundColor(Color.accentColor)
                .frame(width: 21.0, height: 27.0)
                .disabled(true)
            
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
            .disabled(true)
        }
        .padding(EdgeInsets(top: 2.0, leading: 16.0, bottom: 2.0, trailing: 6.0))
    }
}
