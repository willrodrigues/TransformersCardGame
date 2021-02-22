//
//  GlobalModels.swift
//  Transformers
//
//  Created by Willian Rodrigues on 14/02/21.
//

import Foundation

enum Global {
    enum Model {
        
        enum TransformerEdited: Int, Codable {
            case updated
            case added
            case deleted
        }
        
        struct Transformer: Codable, Equatable {
            let id: String?
            var name: String
            var courage: Int
            var endurance: Int
            var firepower: Int
            var intelligence: Int
            var rank: Int
            var skill: Int
            var speed: Int
            var strength: Int
            var team: Team
            var teamIcon: String
            var edited: TransformerEdited?
            
            var overallRating: Int {
                strength + intelligence + speed + endurance + firepower
            }
        }
        
        enum Team: String, Codable {
            case autobots = "A"
            case decepticons = "D"
            case unknown
            
            init(from decoder: Decoder) throws {
                let container = try decoder.singleValueContainer()
                let type = try container.decode(String.self)
                self = Team(rawValue: type) ?? .unknown
            }
            
            var name: String {
                switch self {
                case .autobots:
                    return "teamName.autobots".localized
                case .decepticons:
                    return "teamName.decepticons".localized
                default:
                    return "teamName.unknown".localized
                }
            }
            
            var teamIconUrl: String {
                switch self {
                case .autobots:
                    return Constants.autobotsTeamIcon
                case .decepticons:
                    return Constants.decepticonsTeamIcon
                default:
                    return ""
                }
            }
        }
    }
}

extension Global.Model.Transformer {
    init() {
        id = nil
        name = ""
        courage = 1
        endurance = 1
        firepower = 1
        intelligence = 1
        rank = 1
        skill = 1
        speed = 1
        strength = 1
        team = .unknown
        teamIcon = ""
    }
}
