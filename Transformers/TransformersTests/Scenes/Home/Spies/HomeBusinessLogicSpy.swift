//
//  HomeBusinessLogicSpy.swift
//  TransformersTests
//
//  Created by Willian Rodrigues on 21/02/21.
//

@testable import Transformers

final class HomeBusinessLogicSpy: HomeBusinessLogic {
    
    var loadTrasformersCalled = false
    var didTapTransformerCalled = false
    var performWarCalled = false
    
    func loadTrasformers() {
        loadTrasformersCalled = true
    }
    
    func didTapTransformer(index: Int) {
        didTapTransformerCalled = true
    }
    
    func performWar() {
        performWarCalled = true
    }
}
