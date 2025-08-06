//
//  View.swift
//  ReactingProgramming
//
//  Created by 양원식 on 8/6/25.
//
import UIKit

final class RxView: UIView {
    // MARK: - Properties
    
    // MARK: - UI Components
    private let textField = UITextField()
    private let button = UIButton(type: .system)
    private let label = UILabel()
    
    // MARK: - Getter
    var getTextField: UITextField { textField }
    var getButton: UIButton { button }
    var getLabel: UILabel { label }
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    @available(*, unavailable, message: "storyboard is not supported.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    // MARK: - Public Methods
}

private extension RxView {
    // MARK: - configure
    func configure() {
        setHierarchy()
        setStyles()
        setConstraints()
    }
    
    // MARK: - setHierarchy
    func setHierarchy() {
        addSubview(textField)
        addSubview(button)
        addSubview(label)
    }
    
    // MARK: - setStyles
    func setStyles() {
        textField.borderStyle = .roundedRect
        button.setTitle("확인", for: .normal)
        label.textAlignment = .center
        backgroundColor = .yellow
    }
    
    // MARK: - setConstraints
    func setConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

