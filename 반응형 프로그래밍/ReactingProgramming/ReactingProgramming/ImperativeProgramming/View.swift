//
//  View.swift
//  ReactingProgramming
//
//  Created by 양원식 on 8/5/25.
//
import UIKit

final class View: UIView {
    
    let textField = UITextField()
    let button = UIButton(type: .system)
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func configure() {
        setHierarchy()
        setStyles()
        setConstraints()
    }

    private func setHierarchy() {
        addSubview(textField)
        addSubview(button)
        addSubview(label)
    }

    private func setStyles() {
        textField.borderStyle = .roundedRect
        button.setTitle("확인", for: .normal)
        label.textAlignment = .center
        backgroundColor = .yellow
    }

    private func setConstraints() {
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
