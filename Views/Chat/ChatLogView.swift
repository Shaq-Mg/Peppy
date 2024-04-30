//
//  ChatLogView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 30/04/2024.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct ChatLogView: View {
    let chatUser: User?
    
    init(chatUser: User?) {
        self.chatUser = chatUser
        self.vm = .init(chatUser: chatUser)
    }
    
    @ObservedObject var vm: ChatLogViewModel
    
    var body: some View {
        VStack {
            chatView
            
            chatDisplayBar
        }
        .navigationTitle(vm.chatUser?.username ?? "username")
        .navigationBarItems(trailing: chatNavBar)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var chatNavBar: some View {
        HStack(spacing: 16) {
            WebImage(url: URL(string: vm.chatUser?.photoImageUrl ?? ""))
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36)
                .clipped()
                .presentationCornerRadius(36)
                .overlay(RoundedRectangle(cornerRadius: 36).stroke(Color(.label), lineWidth: 1))
                .shadow(radius: 5)
            
            Text(vm.chatUser?.username ?? "user")
                .font(.system(size: 24, weight: .bold))
        }
    }
    private var chatView: some View {
        ScrollView {
            ScrollViewReader { scrollViewProxy in
                VStack {
                    ForEach(vm.chatMessages) { message in
                        MessageView(message: message)
                    }
                    HStack { Spacer() }
                        .id(vm.emptyScrollToId)
                }
                .onReceive(vm.$messageCount) { _ in
                    withAnimation(.easeIn(duration: 0.5)) {
                        scrollViewProxy.scrollTo(vm.emptyScrollToId, anchor: .bottom)
                    }
                }
            }
        }
        .background(Color(.init(white: 0.96, alpha: 1)))
        .safeAreaInset(edge: .bottom) {
            
        }
    }
    private var chatDisplayBar: some View {
        HStack(spacing: 16) {
            Button {
                
            } label: {
                Image(systemName: "photo")
                    .font(.system(size: 24))
                    .foregroundStyle(Color(.systemGray))
            }
            
            TextEditor(text: $vm.chatText)
                .padding(.leading)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).opacity(0.4))

            Button {
                vm.handleSend()
            } label: {
                Text("Send")
                    .foregroundStyle(.mint)
                    .fontWeight(.semibold)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ChatLogView(chatUser: ChatUser(data: .init()))
        }
    }
}

