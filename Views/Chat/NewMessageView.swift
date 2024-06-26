//
//  NewMessageView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 02/05/2024.
//

import SwiftUI

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
                            Image(systemName: "person")
                                .font(.system(size: 24).bold())
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(user.phone)
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

