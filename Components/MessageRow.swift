//
//  MessageRow.swift
//  Peppy
//
//  Created by Shaquille McGregor on 30/04/2024.
//

import SwiftUI

struct MessageRow: View {
    @EnvironmentObject var vm: LoginViewModel
    var body: some View {
        NavigationLink {
            ChatLogView(chatUser: vm.chatUser)
        } label: {
            HStack(spacing: 18) {
                
                Image(systemName: "person")
                    .font(.system(size: 24).bold())
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Username")
                        .font(.headline)
                    
                    Text("New Message")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .bold()
                    
                }
                Spacer()
                Text("online")
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .foregroundStyle(.mint)
            }
            .padding()
        }
    }
}
struct MessageRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MessageRow()
                .environmentObject(LoginViewModel())
        }
    }
}
