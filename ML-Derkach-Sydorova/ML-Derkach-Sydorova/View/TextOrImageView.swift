//
//  TextOrImageView.swift
//  ML-Derkach-Sydorova
//
//  Created by Kyrylo Derkach on 26.06.2023.
//

import SwiftUI

class ImageProvider: ObservableObject {
    @Published var image: UIImage?
}

struct TextOrImageView: View {
    @ObservedObject var imageProvider: ImageProvider

    var body: some View {
        VStack {
            if let image = imageProvider.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Text("No Image")
                    .font(.title)
            }
        }
    }
}
