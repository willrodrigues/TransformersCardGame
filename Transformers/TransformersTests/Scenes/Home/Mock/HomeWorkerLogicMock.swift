//
//  HomeWorkerLogicMock.swift
//  TransformersTests
//
//  Created by Willian Rodrigues on 21/02/21.
//

@testable import Transformers
import APIService

enum HomeWorkerSpyOptions {
    case courageAndStrength
    case skill
    case overallRating
    case failure
    case tie
    case survivors
    case autobotWinner
    case decepticonWinner
    case optimusPrime
    case predaking
}

final class HomeWorkerSpy: HomeWorkerLogic {
    
    let option: HomeWorkerSpyOptions
    let winnerTeam: Global.Model.Team
    var looserTeam: Global.Model.Team { winnerTeam == .decepticons ? .autobots : .decepticons }
    
    init(option: HomeWorkerSpyOptions, winnerTeam: Global.Model.Team = .autobots) {
        self.option = option
        self.winnerTeam = winnerTeam
    }
    
    func getTransformers(_ request: RequestProvider, completion: @escaping (Result<Home.Model.Response, APIError>) -> Void) {
        switch option {
        case .courageAndStrength:
            completion(.success(courageAndStrengthMock()))
        case .skill:
            completion(.success(skillMock()))
        case .overallRating:
            completion(.success(overallRatingMock()))
        case .failure:
            completion(.failure(.badURL))
        case .tie:
            completion(.success(tieMock()))
        case .survivors:
            completion(.success(survivorsMock()))
        case .autobotWinner:
            completion(.success(autobotWinnerMock()))
        case .decepticonWinner:
            completion(.success(decepticonWinnerMock()))
        case .optimusPrime:
            completion(.success(optimusPrimeMock()))
        case .predaking:
            completion(.success(predakingMock()))
        }
    }
    
    private func courageAndStrengthMock() -> Home.Model.Response {
        let looser = getTransformerWith(value: 1, team: looserTeam)
        let winner = getTransformerWith(value: 5, team: winnerTeam)
        return .init(transformers: [looser, winner])
    }
    
    private func skillMock() -> Home.Model.Response {
        let looser = getTransformerWith(value: 1, team: looserTeam)
        let winner = Global.Model.Transformer(id: "32456",
                                              name: "name",
                                              courage: 1,
                                              endurance: 1,
                                              firepower: 1,
                                              intelligence: 1,
                                              rank: 1,
                                              skill: 4,
                                              speed: 1,
                                              strength: 1,
                                              team: winnerTeam,
                                              teamIcon: "",
                                              edited: nil)
        return Home.Model.Response(transformers: [looser, winner])
    }
    
    private func overallRatingMock() -> Home.Model.Response {
        let looser = getTransformerWith(value: 1, team: looserTeam)
        let winner = getTransformerWith(value: 10, team: winnerTeam)
        return .init(transformers: [looser, winner])
    }
    
    private func tieMock() -> Home.Model.Response {
        let one = getTransformerWith(value: 7, team: looserTeam)
        let two = getTransformerWith(value: 7, team: winnerTeam)
        return .init(transformers: [one, two])
    }
    
    private func survivorsMock() -> Home.Model.Response {
        let looserOne = getTransformerWith(value: 1, team: looserTeam)
        let looserTwo = getTransformerWith(value: 2, team: looserTeam)
        let winner = getTransformerWith(value: 7, team: winnerTeam)
        return .init(transformers: [looserOne, looserTwo, winner])
    }
    
    private func autobotWinnerMock() -> Home.Model.Response {
        let looser = getTransformerWith(value: 1, team: .decepticons)
        let winner = getTransformerWith(value: 7, team: .autobots)
        return .init(transformers: [looser, winner])
    }
    
    private func decepticonWinnerMock() -> Home.Model.Response {
        let looser = getTransformerWith(value: 1, team: .autobots)
        let winner = getTransformerWith(value: 7, team: .decepticons)
        return .init(transformers: [looser, winner])
    }
    
    private func optimusPrimeMock() -> Home.Model.Response {
        let looser = getTransformerWith(value: 10, team: .decepticons)
        let winner = getTransformerWith(value: 1, team: .autobots, name: "Optimus Prime")
        return .init(transformers: [looser, winner])
    }
    
    private func predakingMock() -> Home.Model.Response {
        let looser = getTransformerWith(value: 10, team: .autobots)
        let winner = getTransformerWith(value: 1, team: .decepticons, name: "Predaking")
        return .init(transformers: [looser, winner])
    }
    
    private func getTransformerWith(value: Int, team: Global.Model.Team, name: String? = nil) -> Global.Model.Transformer {
        return Global.Model.Transformer(id: "32456",
                                        name: name ?? "name",
                                        courage: value,
                                        endurance: value,
                                        firepower: value,
                                        intelligence: value,
                                        rank: value,
                                        skill: value,
                                        speed: value,
                                        strength: value,
                                        team: team,
                                        teamIcon: "",
                                        edited: nil)
    }
}
