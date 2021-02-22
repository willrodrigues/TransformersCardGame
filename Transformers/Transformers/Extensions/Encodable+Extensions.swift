//
//  Encodable+Extensions.swift
//  Transformers
//
//  Created by Willian Rodrigues on 17/02/21.
//

import Foundation

extension Encodable {
    func toJSON() -> [String: Any]? {
        guard let jsonData = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as? [String: Any] else { return nil }
        return dictionary
    }
}
