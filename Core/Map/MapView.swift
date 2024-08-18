//
//  MapView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 16/08/2024.
//

import SwiftUI

struct MapView: View {
    @State private var showLocationDetailView = false
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                MapViewRepresentable()
                    .ignoresSafeArea()
                
                SearchBarView(placeholder: "Search destination..")
                    .padding(.top, 32)
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
