//
//  ProfileImageView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 17/05/2024.
//

import SwiftUI

struct ProfileImageView: View {
    let size: CGFloat
    let imageSize: CGFloat
    var body: some View {
        VStack {
            Circle()
                .foregroundStyle(.mint)
                .frame(width: size, height: size)
                .shadow(radius: 2)
                .overlay(Image(systemName: "person.fill").foregroundStyle(.white).font(.system(size: imageSize)))
        }
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView(size: 60, imageSize: 30)
    }
}
