//
//  TransparentGroupBox.swift
//  Filmies
//
//  Created by bryan colin on 1/21/22.
//

import SwiftUI

struct TransparentGroupBox: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white, lineWidth: 1)
            )
            .overlay(
                configuration.label.padding(.leading, 4),
                alignment: .topLeading
            )
    }
}
