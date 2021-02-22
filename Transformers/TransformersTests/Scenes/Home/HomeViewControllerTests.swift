//
//  HomeViewControllerTests.swift
//  Transformers
//
//  Created by Willian Rodrigues on 21/02/21.
//

@testable import Transformers
import XCTest

final class HomeViewControllerTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: HomeViewController?
    var window: UIWindow?
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupHomeViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupHomeViewController() {
        sut = HomeViewController()
    }
    
    func loadView() {
        guard let sut = sut else { return }
        window?.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Tests
    
    func testViewIsLoaded() {
        // Given
        let spy = HomeBusinessLogicSpy()
        sut?.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.loadTrasformersCalled)
    }
    
    func testDisplayScreenValues() {
        // Given
        let viewModel = Home.Model.ViewModel(title: "title",
                                             addButtonTitle: "addButton",
                                             warButtonTitle: "warButton",
                                             transformers: [])
        let spy = HomeBusinessLogicSpy()
        sut?.interactor = spy
        
        _ = self.expectation(for: NSPredicate(format: "text == %@ ", viewModel.title),
                             evaluatedWith: sut?.titleLabel,
                             handler: nil)
        
        // When
        loadView()
        sut?.displayScreenValues(viewModel: viewModel)
        
        // Then
        waitForExpectations(timeout: 5.0)
        XCTAssertTrue(spy.loadTrasformersCalled)
        XCTAssertEqual(sut?.titleLabel.text, viewModel.title)
        XCTAssertEqual(sut?.warButton.title(for: .normal), viewModel.warButtonTitle)
        XCTAssertEqual(sut?.createButton.title(for: .normal), viewModel.addButtonTitle)
        XCTAssertTrue(sut?.viewModel != nil)
    }
    
    func testDisplayMessage() {
        // Given
        let viewModel = Home.Model.ResultViewModel(title: "title",
                                                   message: "message",
                                                   button: "button")
        let spy = HomeBusinessLogicSpy()
        sut?.interactor = spy
        
        // When
        loadView()
        sut?.displayMessage(viewModel: viewModel)
        
        // Then
        XCTAssertTrue(spy.loadTrasformersCalled)
        XCTAssertEqual(sut?.alertController?.title, viewModel.title)
        XCTAssertEqual(sut?.alertController?.message, viewModel.message)
        XCTAssertEqual(sut?.alertController?.actions.first?.title, viewModel.button)
    }
    
    func testTapTransformer() {
        // Given
        guard let tableView = sut?.tableView else { XCTFail(); return }
        let spy = HomeBusinessLogicSpy()
        sut?.interactor = spy
        
        // When
        loadView()
        tableView.delegate?.tableView?(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertTrue(spy.didTapTransformerCalled)
    }
    
    func testPerformWar() {
        // Given
        let spy = HomeBusinessLogicSpy()
        sut?.interactor = spy
        
        // When
        loadView()
        sut?.warButton.sendActions(for: .touchUpInside)
        
        // Then
        XCTAssertTrue(spy.performWarCalled)
    }
}
