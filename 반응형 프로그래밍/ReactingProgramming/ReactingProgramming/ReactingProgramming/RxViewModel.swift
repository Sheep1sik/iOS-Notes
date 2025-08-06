//
//  ViewModel.swift
//  ReactingProgramming
//
//  Created by 양원식 on 8/6/25.
//

import Foundation
import RxSwift
import RxRelay

// MARK: - Input / Output

protocol RxViewModelInput {
    var inputText: AnyObserver<String> { get }
    var didTapButton: AnyObserver<Void> { get }
}

protocol RxViewModelOutput {
    var isInputValid: Observable<Bool> { get }
    var buttonTappedText: Observable<String> { get }
}

// MARK: - ViewModel

final class RxViewModel: RxViewModelInput, RxViewModelOutput {

    // MARK: - Private Relays
    private let inputTextRelay = BehaviorRelay<String>(value: "")
    private let didTapButtonRelay = PublishRelay<Void>()

    // MARK: - Input (Binder 래핑)
    var inputText: AnyObserver<String> {
        Binder(self) { vm, text in
            vm.inputTextRelay.accept(text)
        }.asObserver()
    }
    
    var didTapButton: AnyObserver<Void> {
        Binder(self) { vm, _ in
            vm.didTapButtonRelay.accept(())
        }.asObserver()
    }
    
    // MARK: - Output
    let isInputValid: Observable<Bool>
    let buttonTappedText: Observable<String>
    
    // MARK: - Init
    init() {
        isInputValid = inputTextRelay
            .map { $0.count >= 3 }
            .distinctUntilChanged()
        
        buttonTappedText = didTapButtonRelay
            .map { "버튼이 눌렸어요!" }
    }
}
