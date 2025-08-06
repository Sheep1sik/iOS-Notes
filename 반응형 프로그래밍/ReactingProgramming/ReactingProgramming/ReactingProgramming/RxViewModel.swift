//
//  ViewModel.swift
//  ReactingProgramming
//
//  Created by 양원식 on 8/6/25.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - Input / Output

protocol RxViewModelInput {
    var inputText: AnyObserver<String> { get }
    var didTapButton: AnyObserver<Void> { get }
}

protocol RxViewModelOutput {
    var isInputValid: Driver<Bool> { get }
    var buttonTappedText: Driver<String> { get }
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
    let isInputValid: Driver<Bool>
    let buttonTappedText: Driver<String>
    
    // MARK: - Init
    init() {
        isInputValid = inputTextRelay
            .map { $0.count >= 3 }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
        
        buttonTappedText = didTapButtonRelay
            .map { "버튼이 눌렸어요!" }
            .asDriver(onErrorJustReturn: "")
        
    }
}
