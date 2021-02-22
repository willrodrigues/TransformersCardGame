//
//  CustomImageView.swift
//  APIService
//
//  Created by Willian Rodrigues on 16/02/21.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

final public class APIImageView: UIImageView {

    private var imageURLString: String?
    private let session: URLSession
    
    public init(session: URLSession = URLSession.shared) {
        self.session = session
        super.init(image: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init()
    }
    
    public func downloadFrom(stringURL: String) {
        self.imageURLString = stringURL
        self.image = nil
        guard !stringURL.isEmpty,
              let url = URL(string: stringURL) else { showNoImage(); return }
        
        if let cachedImage = imageCache.object(forKey: stringURL as NSString) as? UIImage,
           imageURLString == stringURL {
            DispatchQueue.main.async { self.image = cachedImage }
        } else {
            fetchImage(url)
        }
    }
    
    private func fetchImage(_ url: URL) {
        session.dataTask(with: url) { data, response, error in
            if let resp = response as? HTTPURLResponse,
               resp.statusCode == 200,
               resp.mimeType?.hasPrefix("image") ?? false,
               let imageData = data,
               let image = UIImage(data: imageData) {
                imageCache.setObject(image, forKey: url.absoluteString as NSString)
                self.showImage(image)
            } else {
                self.showNoImage()
                return
            }
        }.resume()
    }
    
    private func showNoImage() {
        DispatchQueue.main.async { self.image = UIImage(named: "noImage") }
    }
    
    private func showImage(_ image: UIImage) {
        DispatchQueue.main.async { self.image = image }
    }
}
