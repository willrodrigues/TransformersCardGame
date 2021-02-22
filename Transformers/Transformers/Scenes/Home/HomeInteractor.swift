//
//  HomeInteractor.swift
//  Transformers
//
//  Created by Willian Rodrigues on 14/02/21.
//

import UIKit
import APIService

protocol HomeBusinessLogic {
    func loadTrasformers()
    func didTapTransformer(index: Int)
    func performWar()
}

protocol HomeDataStore {
    var selectedTransformer: Global.Model.Transformer? { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    
    // MARK: - Archtecture Objects
    
    var presenter: HomePresentationLogic?
    let worker: HomeWorkerLogic
    
    //MARK: - DataStore Objects
    
    var selectedTransformer: Global.Model.Transformer? { didSet { updateTransformerIfNeeded() } }
    var transformers: [Global.Model.Transformer] = [] { didSet { showTransformers() } }
    
    // MARK: - Variables
    
    var gameBoard: Home.Model.GameBoard = Home.Model.GameBoard()
    
    // MARK: - Interactor Lifecycle
    
    init(worker: HomeWorkerLogic = HomeWorker()) {
        self.worker = worker
    }
    
    // MARK: - Business Logic
    
    func loadTrasformers() {
        let request = HomeRequestProvider()
        worker.getTransformers(request, completion: handleResponse)
    }
    
    func didTapTransformer(index: Int) {
        selectedTransformer = transformers.get(index: index)
        presenter?.presentTransformerDetails()
    }
    
    func performWar() {
        gameBoard = Home.Model.GameBoard()
        addTransformersIntoTheirTeams()
        gameBoard.equilizeBoard()
        startBattle()
        presenter?.presentResults(result: gameBoard)
    }
    
    // MARK: - Private Functions
    
    private func handleResponse(_ result: (Result<Home.Model.Response, APIError>)) {
        switch result {
        case .success(let response):
            transformers = response.transformers
        case .failure( _):
            presenter?.presentNoTransformers()
        }
    }
    
    private func showTransformers() {
        transformers.isEmpty ? presenter?.presentNoTransformers() : presenter?.presentTransformers(transformers: transformers)
    }
    
    private func updateTransformerIfNeeded() {
        guard var transformer = selectedTransformer, let hasEdited = transformer.edited else { return }
        switch hasEdited {
        case .added:
            transformer.edited = nil
            transformers.append(transformer)
        case .updated:
            transformer.edited = nil
            guard let index = transformers.firstIndex(where: { $0.id == transformer.id }) else { return }
            transformers[index] = transformer
        case .deleted:
            transformers.removeAll(where: { $0.id == transformer.id })
        }
        selectedTransformer = nil
    }
    
    // MARK: - Battle Functions
    
    private func addTransformersIntoTheirTeams() {
        gameBoard.autobots = transformers.filter({ $0.team == .autobots })
        gameBoard.decepticons = transformers.filter({ $0.team == .decepticons })
    }
    
    private func startBattle() {
        while (gameBoard.totalTransformers > 0) {
            guard let autobot = gameBoard.getAutobot(), let decepticon = gameBoard.getDecepticon() else { continue }
            gameBoard.numberOfBattles += 1
            guard checkCrititalBattle(autobot: autobot, decepticon: decepticon) else { return }
            guard checkSpecialRule(autobot: autobot, decepticon: decepticon) else { continue }
            guard courageAndStrengthComparison(autobot: autobot, decepticon: decepticon) else { continue }
            guard skillComparison(autobot: autobot, decepticon: decepticon) else { continue }
            overallRatingComparison(autobot: autobot, decepticon: decepticon)
        }
        
        print(gameBoard.getWarWinner)
        print(gameBoard.numberOfBattles)
    }
    
    private func courageAndStrengthComparison(autobot: Global.Model.Transformer, decepticon: Global.Model.Transformer) -> Bool {
        if (autobot.courage - decepticon.courage) >= 4,
           (autobot.strength - decepticon.strength) >= 3 {
            gameBoard.setBattleWinner(.autobots, autobot)
            return false
        }
        if (decepticon.courage - autobot.courage) >= 4,
           (decepticon.strength - autobot.strength) >= 3 {
            gameBoard.setBattleWinner(.decepticons, decepticon)
            return false
        }
        return true
    }
    
    private func skillComparison(autobot: Global.Model.Transformer, decepticon: Global.Model.Transformer) -> Bool {
        if (autobot.skill - decepticon.skill) >= 3 {
            gameBoard.setBattleWinner(.autobots, autobot)
            return false
        }
        if (decepticon.skill - autobot.skill) >= 3 {
            gameBoard.setBattleWinner(.decepticons, decepticon)
            return false
        }
        return true
    }
    
    private func overallRatingComparison(autobot: Global.Model.Transformer, decepticon: Global.Model.Transformer) {
        if autobot.overallRating > decepticon.overallRating {
            gameBoard.setBattleWinner(.autobots, autobot)
        } else if decepticon.overallRating > autobot.overallRating {
            gameBoard.setBattleWinner(.decepticons, decepticon)
        } else {
            gameBoard.setBattleWinner(.unknown)
        }
    }
    
    private func checkCrititalBattle(autobot: Global.Model.Transformer, decepticon: Global.Model.Transformer) -> Bool {
        let isCritial = ((autobot.name == "Optimus Prime" || decepticon.name == "Optimus Prime")) &&
            ((autobot.name == "Predaking" || decepticon.name == "Predaking"))
        gameBoard.crititalBattle = isCritial
        return !isCritial
    }
    
    private func checkSpecialRule(autobot: Global.Model.Transformer, decepticon: Global.Model.Transformer) -> Bool {
        if ["Optimus Prime", "Predaking"].contains(autobot.name) {
            gameBoard.setBattleWinner(.autobots, autobot)
            return false
        }
        if ["Optimus Prime", "Predaking"].contains(decepticon.name) {
            gameBoard.setBattleWinner(.decepticons, decepticon)
            return false
        }
        return true
    }
}
