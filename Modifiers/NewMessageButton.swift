//
//  NewMessageButton.swift
//  Peppy
//
//  Created by Shaquille McGregor on 29/04/2024.
//

import SwiftUI

struct NewMessageButton: View {
    @ObservedObject var vm: MainMessageVM
    
    var body: some View {
        Button {
            vm.showNewMessageScreen.toggle()
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 12))
                .fontWeight(.bold)
                .foregroundStyle(.mint)
                .padding(4)
                .background(Circle().stroke(lineWidth: 2))
                .foregroundStyle(.mint)
        }
    }
}

struct NewMessageButton_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageButton(vm: MainMessageVM())
    }
}
