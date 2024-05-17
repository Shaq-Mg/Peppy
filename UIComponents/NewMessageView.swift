//
//  NewMessageView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 29/04/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewMessageView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var vm = NewMessageVM()
    
    let selectedUser: (User) -> ()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(vm.users) { user in
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        selectedUser(user)
                    } label: {
                        HStack {
                            WebImage(url: URL(string: vm.chatUser?.photoImageUrl ?? ""))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 36, height: 36)
                                .clipped()
                                .overlay(RoundedRectangle(cornerRadius: 36).stroke(Color(.label), lineWidth: 1))
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(user.email)
                                    .foregroundStyle(Color(.label))
                                    .font(.headline)
                                Spacer()
                            }.padding()
                            Divider()
                        }
                    }
                }
            }
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
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
        }
    }
}
struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NewMessageView(selectedUser: { user in })
        }
    }
}
