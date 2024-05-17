//
//  PhotoPickerView.swift
//  Peppy
//
//  Created by Shaquille McGregor on 01/05/2024.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $viewModel.imageSelection) {
                VStack {
                    if let image = viewModel.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .cornerRadius(50)
                    } else {
                        VStack(spacing: 8) {
                            Image(systemName: "person.fill")
                                .font(.system(size: 60))
                                .foregroundStyle(.black)
                            
                            Text("Upload photo")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                        }
                    }
                }
            }
        }
    }
}

struct PhotoPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickerView()
            .environmentObject(LoginViewModel())
    }
}
