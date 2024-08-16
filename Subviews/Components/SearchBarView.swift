//
//  SearchBarView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 16/08/2024.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 18, weight: .semibold))
                .padding(.leading)
            
            TextField(placeholder, text: $text)
                .font(.system(size: 18))
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
        }
        .frame(width: 340)
        .background(.white)
        .cornerRadius(8)
        .shadow(radius: 5)
        .overlay(alignment: .trailing) {
            if !text.isEmpty {
                withAnimation(.spring()) {
                    Button {
                        withAnimation(.spring()) {
                            text = ""
                        }
                    } label: {
                        Image(systemName: "xmark.circle")
                            .foregroundStyle(.secondary)
                            .padding(.trailing)
                    }
                }
            }
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: .constant(""), placeholder: "Search")
    }
}
