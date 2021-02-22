//
//  TransformerDetailsModels.swift
//  Transformers
//
//  Created by Willian Rodrigues on 16/02/21.
//

import UIKit

enum TransformerDetails {
    enum Model {
        struct ViewModel {
            let transformer: Global.Model.Transformer?
            var isNewTransformer: Bool { transformer?.id == nil }
            let showEditButton: Bool = true
        }
        
        struct InvalidMessageViewModel {
            let title: String
            let message: String
            let button: String
        }
    }
}
