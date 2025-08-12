//
//  ViewController.swift
//  UILabel
//
//  Created by 양원식 on 8/12/25.
//

import UIKit

final class UILabelViewController: UIViewController {
    
    // MARK: - Properties
    private let uiLabelView = UILabelView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = uiLabelView
    }
    
    // VC일 때
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Initializer
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    @available(*, unavailable, message: "compile error")
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

// MARK: - UI Methods

private extension UILabelViewController {
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
    func setBinding() { }
    
}
