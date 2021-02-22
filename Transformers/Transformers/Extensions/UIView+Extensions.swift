//
//  UIView+Extensions.swift
//  Transformers
//
//  Created by Willian Rodrigues on 17/02/21.
//

import UIKit

extension UIView {
    
    func addAccessibility(description: String? = nil) {
        self.isAccessibilityElement = true
        self.accessibilityTraits = getAccessibilityTraits
        self.accessibilityLabel = description ?? getComponentDescription
    }
    
    var getAccessibilityTraits: UIAccessibilityTraits {
        switch self {
        case is UIImageView:
            return .image
        case is UILabel:
            return .staticText
        case is UIButton:
            return .button
        case is UITextField:
            return .staticText
        case is UIActivityIndicatorView:
            return .staticText
        case is UITableView:
            return .staticText
        default:
            return .none
        }
    }
    
    var getComponentDescription: String {
        switch self {
        case is UIImageView:
            return "accessibility.noImageDescription".localized
        case is UILabel:
            return (self as? UILabel)?.text ?? ""
        case is UIButton:
            return (self as? UIButton)?.titleLabel?.text ?? ""
        case is UITextField:
            return (self as? UITextField)?.text ?? ""
        case is UIActivityIndicatorView:
            return "accessibility.activityIndicator".localized
        default:
            return "accessibility.noDescription".localized
        }
    }
}
