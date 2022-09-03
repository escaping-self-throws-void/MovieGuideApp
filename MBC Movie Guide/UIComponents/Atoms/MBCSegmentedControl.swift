//
//  File.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 23/07/2022.
//

import UIKit

final class MBCSegmentedControl: UISegmentedControl {
    
    var cornerRadius: CGFloat?

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius ?? 0
    }
    
    func ensureiOS12Style() {
        if #available(iOS 13, *) {
            let tintColorImage = UIImage(color: tintColor)
            setBackgroundImage(UIImage(color: backgroundColor ?? .clear), for: .normal, barMetrics: .default)
            setBackgroundImage(tintColorImage, for: .selected, barMetrics: .default)
            setBackgroundImage(UIImage(color: tintColor.withAlphaComponent(0.2)), for: .highlighted, barMetrics: .default)
            setBackgroundImage(tintColorImage, for: [.highlighted, .selected], barMetrics: .default)
            setDividerImage(tintColorImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        }
    }
}
