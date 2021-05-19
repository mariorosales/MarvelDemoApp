//
//  ImageManager.swift
//  MarvelDemoApp
//
//  Created by Mario Rosales Maillo on 18/05/2021.
//
import UIKit
import SDWebImage

public typealias SimpleCall = ()->(Void)

struct ImageManager  {
    
    static public func getImage(url:String, onSuccess: @escaping ((UIImage)->Void))->SimpleCall? {
        return getImage(url: url, always: { (image) in
            if image != nil {
                onSuccess(image!)
            }
        })
    }
    
    static public func getImage(url:String, always: @escaping ((UIImage?)->Void))->SimpleCall? {
        
        guard let theUrl = URL(string: url) else { return nil }
        
        let operation = SDWebImageManager.shared.loadImage(with: theUrl, options: .highPriority, progress: nil, completed: { (image, data, nsError, cacheType, finished, imageURL) in
            always(image)
        })
        
        return {
            operation?.cancel()
        }
    }
}
