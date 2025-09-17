//
//  CachedAsyncImageView.swift
//  ecommerce_swiftui
//
//  Created by Ahmed Galal on 13/09/2025.
//

import SwiftUI
import Combine

class ImageCache {
    static let shared = NSCache<NSURL, UIImage>()
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading = false
    private var cancellable: AnyCancellable?
    
    func load(from url: URL) {
        if let cachedImage = ImageCache.shared.object(forKey: url as NSURL) {
            self.image = cachedImage
            return
        }
        
        isLoading = true
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveOutput: { [weak self] in
                if let img = $0 {
                    ImageCache.shared.setObject(img, forKey: url as NSURL)
                }
                self?.isLoading = false
            })
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}


struct CachedAsyncImageView: View {
    let url: String
    let placeholder: String = AppAssets.appLogo
    @StateObject private var loader = ImageLoader()
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else if let img = loader.image {
                Image(uiImage: img)
                    .resizable()
//                    .scaledToFit()
                    .transition(.opacity)
            } else {
                Image(placeholder)
                    .resizable()
//                    .scaledToFit()
            }
        }
//        .frame(width: 120, height: 120)
//        .background(Color.gray.opacity(0.1))
//        .clipShape(RoundedRectangle(cornerRadius: 8))
//        .shadow(radius: 3)
        .onAppear {
            if let imageURL = URL(string: url) {
                loader.load(from: imageURL)
            }
        }
        .onDisappear {
            loader.cancel()
        }
    }
}

struct AsyncImageView: View {
    let url: String
    let placeholderImage: String = AppAssets.appLogo
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                // الحالة لحد ما الصورة تحمل
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(1.5)
                
            case .success(let image):
                // الصورة اتحملت بنجاح
                image
                    .resizable()
                    .scaledToFill()
                    .transition(.opacity) // تأثير بسيط
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
            case .failure(_):
                // لو فيه Error نعرض الصورة الافتراضية
                Image(placeholderImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: 120, height: 120) // حجم ثابت
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 3)
    }
}

