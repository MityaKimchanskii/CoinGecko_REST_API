//
//  UILabelExtension.swift
//  CoinGecko_REST_API
//
//  Created by Mitya Kim on 8/1/22.
//

import UIKit

extension UILabel {
    convenience init(textColor: UIColor, fontSize: CGFloat, fontWeight: UIFont.Weight, textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
