//
//  UITableView.swift
//  MarvelDemoApp
//
//  Created by Mario Rosales Maillo on 18/05/2021.
//

import UIKit

extension UITableView {
    
    public func dequeue<T>(for indexPath:IndexPath)->T where T:UITableViewCell{
        return self.dequeueReusableCell(withIdentifier: T.cellIdentifier, for: indexPath) as! T
    }
}

extension UITableViewCell {
    class var cellIdentifier : String {
        return "\(self)"
    }
}
