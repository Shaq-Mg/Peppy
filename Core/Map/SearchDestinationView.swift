//
//  SearchDestinationView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 18/08/2024.
//

import SwiftUI

struct SearchDestinationView: View {
    @EnvironmentObject var viewModel: LocationSearchViewModel
    @Binding var showLocationDetailView: Bool
    @Binding var destinationLocationText: String
    var body: some View {
        VStack {
            searchField
            Divider()
                .padding(.vertical)
            
            ScrollView {
                ForEach(viewModel.results, id: \.self) { result in
                    LocationSearchResultCell(title: result.title, subtitle: result.subtitle)
                        .onTapGesture {
                            viewModel.selectedLocation(result.title)
                            showLocationDetailView.toggle()
                        }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct SearchDestinationView_Previews: PreviewProvider {
    static var previews: some View {
        SearchDestinationView(showLocationDetailView: .constant(false), destinationLocationText: .constant(""))
            .environmentObject(LocationSearchViewModel())
    }
}

extension SearchDestinationView {
    private var searchField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(destinationLocationText.isEmpty ? .black : .accentColor)
                .padding(.leading)
            TextField("Search destination...", text: $viewModel.queryFragment)
                .font(.system(size: 18, weight: .semibold))
                .padding(.vertical)
                .overlay(alignment: .trailing) {
                    if !destinationLocationText.isEmpty {
                        withAnimation(.spring()) {
                            Button {
                                destinationLocationText = ""
                            } label: {
                                Image(systemName: "xmark.circle")
                                    .font(.system(size: 18, weight: .semibold))
                                    .padding()
                            }
                        }
                    }
                }
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .background(Rectangle().stroke(lineWidth: 2))
        .shadow(radius: 4)
    }
}
