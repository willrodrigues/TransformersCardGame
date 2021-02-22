//
//  HomePresenter.swift
//  Transformers
//
//  Created by Willian Rodrigues on 14/02/21.
//

import UIKit

protocol HomePresentationLogic {
    func presentTransformers(transformers: [Global.Model.Transformer])
    func presentNoTransformers()
    func presentTransformerDetails()
    func presentResults(result: Home.Model.GameBoard)
}

final class HomePresenter: HomePresentationLogic {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: HomeDisplayLogic?
    
    // MARK: - Presentation Logic
    
    func presentTransformers(transformers: [Global.Model.Transformer]) {
        let transformersCount = transformers.count
        let title: String  = transformersCount == 1 ? "home.titleOne".localized : "home.title".localized(with: transformersCount)
        let viewModel = Home.Model.ViewModel(title: title,
                                             addButtonTitle: "home.addButton".localized,
                                             warButtonTitle: "home.warButton".localized,
                                             transformers: transformers)
        viewController?.displayScreenValues(viewModel: viewModel)
    }
    
    func presentNoTransformers() {
        let viewModel = Home.Model.ViewModel(title: "home.notransformers.title".localized,
                                             shouldCenterTitle: true,
                                             addButtonTitle: "home.addButton".localized,
                                             warButtonTitle: "home.warButton".localized,
                                             transformers: [])
        viewController?.displayScreenValues(viewModel: viewModel)
    }
    
    func presentTransformerDetails() {
        viewController?.displayTransformerDetails()
    }
    
    func presentResults(result: Home.Model.GameBoard) {
        let message = createBattleResultMessage(result)
        let viewModel = Home.Model.ResultViewModel(title: "home.battleResult.title".localized,
                                                   message: message,
                                                   button: "home.battleResult.button".localized)
        viewController?.displayMessage(viewModel: viewModel)
    }
    
    private func createBattleResultMessage(_ board: Home.Model.GameBoard) -> String {
        guard !board.crititalBattle else { return "home.battleResult.criticalMessage".localized }
        guard !(board.getWarWinner == .unknown) else { return "home.battleResult.noWinner".localized(with: board.numberOfBattles) }
        var message = "home.battleResult.numberOfBattles".localized(with: board.numberOfBattles)
        message.append("home.battleResult.winnerTeam".localized(with: board.getWarWinner.name))
        
        let winnersName = ((board.getWarWinner == .autobots) ? board.championAutobots : board.championDecepticon).compactMap({ $0.name }).joined(separator: ", ")
        message.append("home.battleResult.championTransformers".localized(with: winnersName))
        
        if let survivors = board.getLosingSurvivors {
            let transformersName = survivors.transformers.compactMap({ $0.name }).joined(separator: ", ")
            message.append("home.battleResult.losingSurvivorsTeam".localized(with: survivors.team.name))
            message.append("home.battleResult.losingSurvivorsName".localized(with: transformersName))
        }
        return message
    }
}
