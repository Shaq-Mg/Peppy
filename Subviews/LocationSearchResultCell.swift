//
//  LocationSearchResultCell.swift
//  Peppy
//
//  Created by Shaquille McGregor on 18/08/2024.
//

import SwiftUI

struct LocationSearchResultCell: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "mappin.circle.fill")
                    .foregroundStyle(Color("AccentColor"))
                    .font(.system(size: 30))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 4)
            Divider()
        }
    }
}

struct LocationSearchResultCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchResultCell(title: "Mcdonalds", subtitle: "44 Broad Avenue")
    }
}
