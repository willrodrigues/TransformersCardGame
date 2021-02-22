//
//  String+Extensions.swift
//  Transformers
//
//  Created by Willian Rodrigues on 14/02/21.
//

import Foundation

extension String {
    public var localized: String {
        return NSLocalizedString(self, comment:"")
    }
    
    public func localized(with arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
    
    var onlyNumbers: String {
        let okayChars = Set("1234567890")
        return self.filter { okayChars.contains($0) }
    }
}
