//
//  ViewController.swift
//  ReactingProgramming
//
//  Created by 양원식 on 8/6/25.
//

import UIKit
import RxSwift

final class RxViewController: UIViewController {
    
    // MARK: - Properties
    private let rxView = RxView()
    private let viewModel: RxViewModel
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    override func loadView() {
        self.view = rxView
    }
    
    // VC일 때
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Initializer
    
    init(viewModel: RxViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    @available(*, unavailable, message: "compile error")
    required init?(coder: NSCoder) {
        fatalError()
    }

}

// MARK: - UI Methods

private extension RxViewController {
    func configure() {
        setHierarchy()
        setStyles()
        setConstraints()
        setActions()
        setBinding()
    }
    
    // MARK: - setBinding
    func setHierarchy() { }
    func setStyles() { }
    func setConstraints() { }
    func setActions() { }
    func setBinding() {
        rxView.getTextField.rx.text.orEmpty
            .bind(to: viewModel.inputText)
            .disposed(by: disposeBag)
        
        rxView.getButton.rx.tap
            .bind(to: viewModel.didTapButton)
            .disposed(by: disposeBag)
        
        viewModel.isInputValid
            .drive(rxView.getButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.buttonTappedText
            .drive(rxView.getLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
