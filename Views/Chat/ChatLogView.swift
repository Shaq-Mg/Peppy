//
//  ChatLogView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 01/05/2024.
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
        .navigationBarItems(leading: imageNavBar)
        .navigationBarItems(trailing: phoneNavBuuton)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var imageNavBar: some View {
        VStack(spacing: 16) {
            Button {
                
            } label: {
                WebImage(url: URL(string: vm.chatUser?.photoImageUrl ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipped()
                    .presentationCornerRadius(36)
                    .overlay(RoundedRectangle(cornerRadius: 36).stroke(Color(.label), lineWidth: 1))
                    .shadow(radius: 5)
            }
        }
    }
    private var phoneNavBuuton: some View {
        VStack(spacing: 16) {
            Button {
                
            } label: {
                Image(systemName: "phone.fill")
                    .foregroundStyle(.mint)
                    .frame(width: 40, height: 40)
                    .background(.white)
                    .clipShape(Circle())
            }
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
                    .foregroundStyle(Color(.systemGray))
            }
            HStack {
                TextField("Desciption", text: $vm.chatText)
                    .frame(maxWidth: .infinity)
                    .padding(.leading)
                
                Button {
                    vm.handleSend()
                } label: {
                    Image(systemName: "paperplane")
                        .foregroundStyle(.mint)
                        .fontWeight(.semibold)
                }
            }
            .padding()
            .background(Color(.systemGray).opacity(0.1))
            .frame(height: 40)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .font(.system(size: 25))
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ChatLogView(chatUser: User(data: .init()))
        }
    }
}
