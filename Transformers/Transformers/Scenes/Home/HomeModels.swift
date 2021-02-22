//
//  HomeModels.swift
//  Transformers
//
//  Created by Willian Rodrigues on 14/02/21.
//

import UIKit

enum Home {
    enum Model {
        
        struct Response: Codable {
            let transformers: [Global.Model.Transformer]
        }
        
        struct ViewModel {
            let title: String
            var shouldCenterTitle: Bool = false
            let addButtonTitle: String
            let warButtonTitle: String
            let transformers: [Global.Model.Transformer]
        }
        
        struct ResultViewModel {
            let title: String
            let message: String
            let button: String
        }
        
        struct GameBoard {
            var autobots: [Global.Model.Transformer] = [] { didSet { autobots.sort(by: { $0.rank > $1.rank }) } }
            var autobotsDefeated: Int = 0
            var decepticons: [Global.Model.Transformer] = [] { didSet { decepticons.sort(by: { $0.rank > $1.rank }) } }
            var decepticonsDefeated: Int = 0
            var numberOfTies: Int = 0
            var numberOfBattles: Int = 0
            var crititalBattle = false
            var totalTransformers: Int { autobots.count + decepticons.count }
            private var survivors: (team: Global.Model.Team, transformers: [Global.Model.Transformer]) = (team: .unknown, transformers: [])
            var championAutobots: [Global.Model.Transformer] = []
            var championDecepticon: [Global.Model.Transformer] = []
            
            var getWarWinner: Global.Model.Team {
                guard !crititalBattle else { return .unknown }
                if autobotsDefeated > decepticonsDefeated {
                    return .decepticons
                } else if decepticonsDefeated > autobotsDefeated {
                    return .autobots
                } else {
                    return .unknown
                }
            }
            
            var getLosingSurvivors: (team: Global.Model.Team, transformers: [Global.Model.Transformer])? {
                guard getWarWinner != survivors.team && !survivors.transformers.isEmpty else { return nil }
                return survivors
            }
            
            mutating func equilizeBoard() {
                if autobots.count > decepticons.count {
                    survivors = (team: .autobots, transformers: autobots.suffix(autobots.count - decepticons.count))
                    autobots = Array(autobots.prefix(decepticons.count))
                } else if decepticons.count > autobots.count {
                    survivors = (team: .decepticons, transformers: decepticons.suffix(decepticons.count - autobots.count))
                    decepticons = Array(decepticons.prefix(autobots.count))
                }
            }
            
            mutating func getAutobot() -> Global.Model.Transformer? { autobots.isEmpty ? nil : autobots.removeFirst() }
            mutating func getDecepticon() -> Global.Model.Transformer? { decepticons.isEmpty ? nil : decepticons.removeFirst() }
            
            mutating func setBattleWinner(_ winnerTeam: Global.Model.Team, _ winnerTransformer: Global.Model.Transformer? = nil) {
                switch winnerTeam {
                case .autobots:
                    decepticonsDefeated += 1
                    if let transformer = winnerTransformer { championAutobots.append(transformer) }
                case .decepticons:
                    autobotsDefeated += 1
                    if let transformer = winnerTransformer { championDecepticon.append(transformer) }
                default:
                    numberOfTies += 1
                }
            }
        }
    }
}
