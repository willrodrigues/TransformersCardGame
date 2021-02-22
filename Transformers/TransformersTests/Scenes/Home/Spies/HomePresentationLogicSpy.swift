//
//  HomeDisplayLogicSpy.swift
//  TransformersTests
//
//  Created by Willian Rodrigues on 21/02/21.
//

@testable import Transformers

final class HomePresentationLogicSpy: HomePresentationLogic {
    var presentTransformersCalled = false
    var presentNoTransformersCalled = false
    var presentTransformerDetailsCalled = false
    var presentResultsCalled = false
    var gameBoard = Home.Model.GameBoard()
    var transformers: [Global.Model.Transformer] = []
    
    func presentTransformers(transformers: [Global.Model.Transformer]) {
        presentTransformersCalled = true
        self.transformers = transformers
    }
    
    func presentNoTransformers() {
        presentNoTransformersCalled = true
    }
    
    func presentTransformerDetails() {
        presentTransformerDetailsCalled = true
    }
    
    func presentResults(result: Home.Model.GameBoard) {
        presentResultsCalled = true
        gameBoard = result
    }
    
    
}
