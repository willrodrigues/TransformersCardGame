//
//  Array+Extensions.swift
//  Transformers
//
//  Created by Willian Rodrigues on 16/02/21.
//

import Foundation

extension Array {
    func get(index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
