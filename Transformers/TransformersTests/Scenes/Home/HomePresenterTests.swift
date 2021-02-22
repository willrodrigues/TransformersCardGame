//
//  HomePresenterTests.swift
//  Transformers
//
//  Created by Willian Rodrigues on 21/02/21.
//

@testable import Transformers
import XCTest

final class HomePresenterTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: HomePresenter?
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupHomePresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupHomePresenter() {
        sut = HomePresenter()
    }
    
    // MARK: Tests
    
    func testPresentTransformers() {
        // Given
        let spy = HomeDisplayLogicSpy()
        sut?.viewController = spy
        
        // When
        sut?.presentTransformers(transformers: [])
        
        // Then
        XCTAssertTrue(spy.displayScreenValuesCalled)
    }
    

    func testPresentNoTransformers() {
        // Given
        let spy = HomeDisplayLogicSpy()
        sut?.viewController = spy
        
        // When
        sut?.presentNoTransformers()
        
        // Then
        XCTAssertTrue(spy.displayScreenValuesCalled)
    }
    
    func testPresentTransformerDetails() {
        // Given
        let spy = HomeDisplayLogicSpy()
        sut?.viewController = spy
        
        // When
        sut?.presentTransformerDetails()
        
        // Then
        XCTAssertTrue(spy.displayTransformerDetailsCalled)
    }
    
    func testPresentResults() {
        // Given
        let spy = HomeDisplayLogicSpy()
        sut?.viewController = spy
        let gameBoard = Home.Model.GameBoard()
        
        // When
        sut?.presentResults(result: gameBoard)
        
        // Then
        XCTAssertTrue(spy.displayMessageCalled)
    }
}
