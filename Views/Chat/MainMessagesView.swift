//
//  MainMessageView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 29/04/2024.
//

import SwiftUI

import SwiftUI
import SDWebImageSwiftUI

struct MainMessagesView: View {
    @ObservedObject var vm = MainMessageVM()
    @State private var searchText = ""
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(vm.recentMessages) { recentMessage in
                    RecentMessageRow(rm: recentMessage)
                }
            }
            .searchable(text: $searchText)
            .onAppear(perform: vm.fetchCurrentUser)
            .navigationTitle("Chats")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: NewMessageButton(vm: vm))
        }
        .alert(vm.showAlert?.title ?? "Error", isPresented: Binding(value: $vm.showAlert), actions: {
            Button("OK") {
                vm.showAlert = nil
            }
        }, message: {
            if let message = vm.showAlert?.message {
                Text(message)
            }
        })
        .fullScreenCover(isPresented: $vm.showNewMessageScreen) {
            NewMessageView(selectedUser: { user in
                vm.showNewMessageScreen.toggle()
                vm.chatUser = user
            })
        }
    }
    
    private var customNavBar: some View {
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
}
struct MainMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainMessagesView()
        }
    }
}

struct RecentMessageRow: View {
    let rm: RecentMessage
    var body: some View {
        VStack {
            NavigationLink {
                
            } label: {
                HStack(spacing: 18) {
                    
                    Image(systemName: "person")
                        .font(.system(size: 24).bold())
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(rm.username)
                            .font(.system(size: 16).bold())
                        
                        Text(rm.text)
                            .font(.system(size: 14))
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.leading)
                            .bold()
                        
                    }
                    Spacer()
                    Text(rm.timestamp.description)
                        .font(.system(size: 14, weight: .semibold))
                }
                .padding()
            }
            Divider()
            .padding(.vertical, 8)
        }
    }
}
