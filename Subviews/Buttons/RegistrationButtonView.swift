//
//  RegistrationButtonView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 25/10/2024.
//

import SwiftUI

struct RegistrationButtonView: View {
    let title: String
    let isPressed: () -> ()
    
    var body: some View {
        Button(title) {
            isPressed()
        }
        .font(.system(size: 18, weight: .bold))
        .foregroundStyle(.white)
        .frame(width: UIScreen.main.bounds.width - 32, height: 44)
        .background(Color("AccentColor"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    RegistrationButtonView(title: "Sign In") { }
}
