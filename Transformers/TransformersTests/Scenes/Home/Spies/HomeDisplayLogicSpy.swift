//
//  HomeDisplayLogicSpy.swift
//  TransformersTests
//
//  Created by Willian Rodrigues on 21/02/21.
//

@testable import Transformers

final class HomeDisplayLogicSpy: HomeDisplayLogic {
    var displayScreenValuesCalled = false
    var displayTransformerDetailsCalled = false
    var displayMessageCalled = false
    
    func displayScreenValues(viewModel: Home.Model.ViewModel) {
        displayScreenValuesCalled = true
    }
    
    func displayTransformerDetails() {
        displayTransformerDetailsCalled = true
    }
    
    func displayMessage(viewModel: Home.Model.ResultViewModel) {
        displayMessageCalled = true
    }
}
