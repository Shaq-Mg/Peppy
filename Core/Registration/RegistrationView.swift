//
//  RegistrationView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 13/08/2024.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RegistrationView()
                .environmentObject(AuthenticationViewModel())
        }
    }
}
