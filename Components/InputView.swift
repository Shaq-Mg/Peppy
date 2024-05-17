//
//  InputView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 28/04/2024.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundStyle(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            VStack {
                if isSecureField {
                    SecureField(placeholder, text: $text)
                        .font(.system(size: 16))
                    
                } else {
                    TextField(placeholder, text: $text)
                        .font(.system(size: 16))
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.none)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(10)
            .shadow(radius: 4)
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""), title: "Email", placeholder: "email")
    }
}
