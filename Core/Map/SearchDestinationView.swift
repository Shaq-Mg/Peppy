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
                .padding(.top, 36)
            Divider()
                .padding(.vertical, 10)
            
            HStack {
                Text(destinationLocationText.isEmpty ? "Recent" : "Results")
                    .foregroundStyle(.secondary)
                Spacer()
                Image(systemName: destinationLocationText.isEmpty ? "info.circle.fill" : "chevron.down")
            }
            .font(.system(size: 16))
            
            ScrollView {
                ForEach(viewModel.results, id: \.self) { result in
                    LocationSearchResultCell(title: result.title, subtitle: result.subtitle)
                        .onTapGesture {
                            viewModel.selectedLocation(result)
                            showLocationDetailView.toggle()
                        }
                }
            }
        }
        .padding(.horizontal)
        .background(.white)
        .cornerRadius(20)
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
        HStack(spacing: 14) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(destinationLocationText.isEmpty ? .black : .accentColor)
                    .padding(.leading)
                TextField("Search destination...", text: $viewModel.queryFragment)
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.vertical, 8)
                    .overlay(alignment: .trailing) {
                        if !destinationLocationText.isEmpty {
                            withAnimation(.spring()) {
                                Button {
                                    destinationLocationText = ""
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.system(size: 16, weight: .semibold))
                                        .padding(.trailing, 6)
                                }
                            }
                        }
                    }
            }
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 2))
            .foregroundStyle(.secondary)
            .background(.white)
            Button("Cancel") {
                
            }
            .font(.system(size: 18, weight: .semibold))
            .foregroundStyle(Color("AccentColor"))
        }
    }
}
