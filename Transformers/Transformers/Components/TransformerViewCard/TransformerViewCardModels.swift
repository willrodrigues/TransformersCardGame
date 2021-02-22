//
//  TransformerViewModels.swift
//  Transformers
//
//  Created by Willian Rodrigues on 16/02/21.
//

enum TransformerViewCardModels {
    enum PropertieType {
        case skill
        case courage
        case endurance
        case firepower
        case intelligence
        case speed
        case strength
        case rank
        
        var name: String {
            switch self {
            case .skill:
                return "transformerAttributePropertie.skill".localized
            case .courage:
                return "transformerAttributePropertie.courage".localized
            case .endurance:
                return "transformerAttributePropertie.endurance".localized
            case .firepower:
                return "transformerAttributePropertie.firepower".localized
            case .intelligence:
                return "transformerAttributePropertie.intelligente".localized
            case .speed:
                return "transformerAttributePropertie.speed".localized
            case .strength:
                return "transformerAttributePropertie.strength".localized
            case .rank:
                return "transformerAttributePropertie.rank".localized
            }
        }
        
    }
}
