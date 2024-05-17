//
//  MessageContactRow.swift
//  Peppy
//
//  Created by Shaquille McGregor on 17/05/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct MessageContactRow: View {
    let vm: NewMessageVM
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                WebImage(url: URL(string: vm.chatUser?.photoImageUrl ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipped()
                    .overlay(RoundedRectangle(cornerRadius: 36).stroke(Color(.label), lineWidth: 1))
                
                Text(vm.chatUser?.username ?? "Preview user")
                    .foregroundStyle(Color(.label))
                    .font(.headline)
                    .padding()
            }
            Divider()
        }
    }
}

struct MessageContactRow_Previews: PreviewProvider {
    static var previews: some View {
        MessageContactRow(vm: NewMessageVM())
    }
}
