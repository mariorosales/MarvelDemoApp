//
//  UIImageView.swift
//  MarvelDemoApp
//
//  Created by Mario Rosales Maillo on 18/05/2021.
//

import UIKit

extension UIImageView {
    
    @discardableResult
    public func loadImage(url:String?, animate:Bool = true, completion: SimpleCall? = nil) -> SimpleCall? {
        guard let url = url else {
            return nil
        }
        let targetAlpha = self.alpha
        let canceller = ImageManager.getImage(url: url, onSuccess: { [weak self] (image) in
                        
            if animate == false {
                self?.image = image
                completion?()
                return
            }
            
            self?.image = image
            self?.alpha = 0
            
            UIView.animate(withDuration: 0.25, animations: {
                self?.alpha = targetAlpha
            })
            
            completion?()
        })
        return canceller
    }
}
