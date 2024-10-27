//
//  SettingsCellView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 25/10/2024.
//

import SwiftUI

struct SettingsCellView: View {
    let imageName: String
    let title: String
    let tintColor: Color = .accentColor
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundStyle(tintColor)
            
            Text(title)
                .font(.headline)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    SettingsCellView(imageName: "gear", title: "Settings")
}
