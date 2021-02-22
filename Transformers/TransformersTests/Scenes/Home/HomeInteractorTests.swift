//
//  HomeInteractorTests.swift
//  Transformers
//
//  Created by Willian Rodrigues on 21/02/21.
//

@testable import Transformers
import XCTest

final class HomeInteractorTests: XCTestCase {
    
    // MARK: Subject under test
    
    var sut: HomeInteractor?
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        sut = HomeInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    // MARK: Tests
    
    func testLoadTrasformers() {
        // Given
        let worker = HomeWorkerSpy(option: .autobotWinner)
        sut = HomeInteractor(worker: worker)
        let spy = HomePresentationLogicSpy()
        sut?.presenter = spy
        
        // When
        sut?.loadTrasformers()
        
        // Then
        XCTAssertTrue(spy.presentTransformersCalled)
    }
    
    func testLoadTrasformersFailure() {
        // Given
        let worker = HomeWorkerSpy(option: .failure)
        sut = HomeInteractor(worker: worker)
        let spy = HomePresentationLogicSpy()
        sut?.presenter = spy
        
        // When
        sut?.loadTrasformers()
        
        // Then
        XCTAssertTrue(spy.presentNoTransformersCalled)
    }
    
    func testDidTapTransformer() {
        // Given
        let worker = HomeWorkerSpy(option: .autobotWinner)
        sut = HomeInteractor(worker: worker)
        let spy = HomePresentationLogicSpy()
        sut?.presenter = spy
        
        // When
        sut?.didTapTransformer(index: 0)
        
        // Then
        XCTAssertTrue(spy.presentTransformerDetailsCalled)
    }
    
    func testPerformWarAutobotWins() {
        // Given
        let worker = HomeWorkerSpy(option: .autobotWinner)
        sut = HomeInteractor(worker: worker)
        let spy = HomePresentationLogicSpy()
        sut?.presenter = spy
        
        // When
        sut?.loadTrasformers()
        sut?.performWar()
        
        // Then
        XCTAssertTrue(spy.presentResultsCalled)
        XCTAssertTrue(spy.gameBoard.getWarWinner == .autobots)
    }
    
    func testPerformWarDecepticonWins() {
        // Given
        let worker = HomeWorkerSpy(option: .decepticonWinner)
        sut = HomeInteractor(worker: worker)
        let spy = HomePresentationLogicSpy()
        sut?.presenter = spy
        
        // When
        sut?.loadTrasformers()
        sut?.performWar()
        
        // Then
        XCTAssertTrue(spy.presentResultsCalled)
        XCTAssertTrue(spy.gameBoard.getWarWinner == .decepticons)
    }
    
    func testPerformWarCourageAndStrenght() {
        // Given
        let worker = HomeWorkerSpy(option: .courageAndStrength)
        sut = HomeInteractor(worker: worker)
        let spy = HomePresentationLogicSpy()
        sut?.presenter = spy
        
        // When
        sut?.loadTrasformers()
        sut?.performWar()
        
        // Then
        XCTAssertTrue(spy.presentResultsCalled)
        XCTAssertTrue(spy.gameBoard.getWarWinner == .autobots)
    }
    
    func testPerformWarSkill() {
        // Given
        let worker = HomeWorkerSpy(option: .skill)
        sut = HomeInteractor(worker: worker)
        let spy = HomePresentationLogicSpy()
        sut?.presenter = spy
        
        // When
        sut?.loadTrasformers()
        sut?.performWar()
        
        // Then
        XCTAssertTrue(spy.presentResultsCalled)
        XCTAssertTrue(spy.gameBoard.getWarWinner == .autobots)
    }
    
    func testPerformWarOverallRatingAutobots() {
        // Given
        let worker = HomeWorkerSpy(option: .overallRating)
        sut = HomeInteractor(worker: worker)
        let spy = HomePresentationLogicSpy()
        sut?.presenter = spy
        
        // When
        sut?.loadTrasformers()
        sut?.performWar()
        
        // Then
        XCTAssertTrue(spy.presentResultsCalled)
        XCTAssertTrue(spy.gameBoard.getWarWinner == .autobots)
    }
    
    func testPerformWarOverallRatingDecepticons() {
        // Given
        let worker = HomeWorkerSpy(option: .overallRating, winnerTeam: .decepticons)
        sut = HomeInteractor(worker: worker)
        let spy = HomePresentationLogicSpy()
        sut?.presenter = spy
        
        // When
        sut?.loadTrasformers()
        sut?.performWar()
        
        // Then
        XCTAssertTrue(spy.presentResultsCalled)
        XCTAssertTrue(spy.gameBoard.getWarWinner == .decepticons)
    }
    
    func testPerformWarSurvivors() {
        // Given
        let worker = HomeWorkerSpy(option: .survivors)
        sut = HomeInteractor(worker: worker)
        let spy = HomePresentationLogicSpy()
        sut?.presenter = spy
        
        // When
        sut?.loadTrasformers()
        sut?.performWar()
        
        // Then
        XCTAssertTrue(spy.presentResultsCalled)
        XCTAssertTrue(spy.gameBoard.getWarWinner == .autobots)
        XCTAssertTrue(spy.gameBoard.getLosingSurvivors?.team == .decepticons)
        XCTAssertFalse(spy.gameBoard.getLosingSurvivors?.transformers.isEmpty ?? true)
    }
    
    func testPerformWarTie() {
        // Given
        let worker = HomeWorkerSpy(option: .tie)
        sut = HomeInteractor(worker: worker)
        let spy = HomePresentationLogicSpy()
        sut?.presenter = spy
        
        // When
        sut?.loadTrasformers()
        sut?.performWar()
        
        // Then
        XCTAssertTrue(spy.presentResultsCalled)
        XCTAssertTrue(spy.gameBoard.getWarWinner == .unknown)
    }
    
    func testPerformWarOptimusPrime() {
        // Given
        let worker = HomeWorkerSpy(option: .optimusPrime)
        sut = HomeInteractor(worker: worker)
        let spy = HomePresentationLogicSpy()
        sut?.presenter = spy
        
        // When
        sut?.loadTrasformers()
        sut?.performWar()
        
        // Then
        XCTAssertTrue(spy.presentResultsCalled)
        XCTAssertTrue(spy.gameBoard.getWarWinner == .autobots)
    }
    
    func testPerformWarPredaking() {
        // Given
        let worker = HomeWorkerSpy(option: .predaking)
        sut = HomeInteractor(worker: worker)
        let spy = HomePresentationLogicSpy()
        sut?.presenter = spy
        
        // When
        sut?.loadTrasformers()
        sut?.performWar()
        
        // Then
        XCTAssertTrue(spy.presentResultsCalled)
        XCTAssertTrue(spy.gameBoard.getWarWinner == .decepticons)
    }
}
