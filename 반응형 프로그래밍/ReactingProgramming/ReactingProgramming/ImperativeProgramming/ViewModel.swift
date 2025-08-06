//
//  ViewModel.swift
//  ReactingProgramming
//
//  Created by 양원식 on 8/5/25.
//

import Foundation

final class ViewModel {
    
    // MARK: - Input
    var inputText: String = "" {
        didSet {
            validateInput()
        }
    }
    
    // MARK: - Output (UI 갱신용 클로저)
    var onValidationChanged: ((Bool) -> Void)?
    var onButtonTapped: (() -> Void)?
    
    // MARK: - Private
    private func validateInput() {
        let isValid = inputText.count >= 3
        onValidationChanged?(isValid)
    }
    
    // MARK: - Public
    func didTapButton() {
        onButtonTapped?()
    }
}
