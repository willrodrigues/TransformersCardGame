//
//  ViewController+Extensions.swift
//  Transformers
//
//  Created by Willian Rodrigues on 14/02/21.
//

import UIKit

extension UIViewController {
    var safeAreaTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return view.safeAreaLayoutGuide.topAnchor
        } else {
            return view.topAnchor
        }
    }
    
    var safeAreaBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return view.safeAreaLayoutGuide.bottomAnchor
        } else {
            return view.bottomAnchor
        }
    }
}
