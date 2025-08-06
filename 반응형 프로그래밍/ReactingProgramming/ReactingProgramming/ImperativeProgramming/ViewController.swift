//
//  ViewController.swift
//  ReactingProgramming
//
//  Created by 양원식 on 8/5/25.
//

import UIKit

final class ViewController: UIViewController {
    
    private let customView = View()
    private var viewModel: ViewModel
    
    override func loadView() {
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBinding()
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setBinding() {
        // 텍스트 필드 변경 → ViewModel로 전달
        customView.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        // 버튼 탭 → ViewModel 메서드 호출
        customView.button.addTarget(self, action: #selector(didTapSomeButton(_:)), for: .touchUpInside)
        
        // ViewModel → UI 업데이트
        viewModel.onValidationChanged = { [weak self] isValid in
            self?.customView.button.isEnabled = isValid
        }
        
        viewModel.onButtonTapped = { [weak self] in
            self?.customView.label.text = "버튼이 눌렸어요!"
        }
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        viewModel.inputText = sender.text ?? ""
    }
    
    @objc func didTapSomeButton(_ sender: UIButton) {
        viewModel.didTapButton()
    }
}
