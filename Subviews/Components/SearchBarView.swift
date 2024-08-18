//
//  SearchBarView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 16/08/2024.
//

import SwiftUI

struct SearchBarView: View {
    let placeholder: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 18, weight: .semibold))
                .padding(.leading)
            
            Text(placeholder)
                .font(.system(size: 18))
                .foregroundStyle(.secondary)
                .padding(.vertical)
                .frame(height: 40)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(width: 340)
        .background(.white)
        .cornerRadius(8)
        .shadow(radius: 5)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(placeholder: "Search")
    }
}
