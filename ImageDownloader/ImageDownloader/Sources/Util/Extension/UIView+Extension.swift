//
//  UIView+Extension.swift
//  ImageDownloader
//
//  Created by Rimp on 2023/02/19.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
}
