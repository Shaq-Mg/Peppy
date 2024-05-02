//
//  ProfileView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 02/05/2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var vm: LoginViewModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(LoginViewModel())
    }
}
