//
//  TeamLogoImageView.swift
//  ShootCounter
//
//  Created by Kristian Thun on 2024-06-11.
//

import SwiftUI

struct TeamLogoImageView: View {
    var imageData: Data?
    var maxWidth: CGFloat = .infinity
    var maxHeight: CGFloat = .infinity
    
    var body: some View {
        if let imageData = imageData,
           let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: maxWidth, maxHeight: maxHeight)
        }else{
            Image(systemName: "shield.fill")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: maxWidth, maxHeight: maxHeight)
        }
    }
}

//#Preview {
//    TeamLogoImageView()
//}
