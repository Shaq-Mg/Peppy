//
//  LocationTextView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 22/08/2024.
//

import SwiftUI

struct LocationTextView: View {
    let text: String
    let fontSize: CGFloat
    let color: Color
    var body: some View {
        Text(text)
            .font(.system(size: fontSize, weight: .semibold))
            .foregroundStyle(color)
    }
}

#Preview {
    LocationTextView(text: "Current location", fontSize: 16, color: .secondary)
}
