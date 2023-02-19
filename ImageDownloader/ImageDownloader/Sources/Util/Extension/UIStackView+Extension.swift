//
//  UIStackView+Extension.swift
//  ImageDownloader
//

import UIKit

extension UIStackView {

    convenience init(
        axis: NSLayoutConstraint.Axis,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill,
        spacing: CGFloat = .zero,
        padding: NSDirectionalEdgeInsets = .zero,
        subviews: [UIView]
    ) {
        self.init(arrangedSubviews: subviews)
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
        self.directionalLayoutMargins = padding
        self.insetsLayoutMarginsFromSafeArea = true
    }
}
