//
//  TransformerAttributeView.swift
//  Transformers
//
//  Created by Willian Rodrigues on 16/02/21.
//

import UIKit

protocol TransformerAttributeViewDelegate: class {
    func didUpdate(type: TransformerViewCardModels.PropertieType, value: Int)
}

final class TransformerAttributeView: UIView {
    
    // MARK: - Delegate
    
    weak var delegate: TransformerAttributeViewDelegate?
    
    // MARK: - Variables
    
    var type: TransformerViewCardModels.PropertieType
    
    // MARK: - Views
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.text = "\(type.name):"
        label.addAccessibility()
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textf = UITextField()
        textf.translatesAutoresizingMaskIntoConstraints = false
        textf.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        textf.layer.cornerRadius = 13
        textf.isUserInteractionEnabled = false
        textf.keyboardType = .numberPad
        textf.text = "0"
        textf.textAlignment = .center
        textf.font = .boldSystemFont(ofSize: 14)
        textf.addAccessibility()
        return textf
    }()
    
    private lazy var controlOptions = TransformerViewAttributedButtons(delegate: self)
    
    // MARK: - Life Cycle
   
    init(type: TransformerViewCardModels.PropertieType, delegate: TransformerAttributeViewDelegate?) {
        self.type = type
        self.delegate = delegate
        super.init(frame: .zero)
        self.setupViews()
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(type: .courage, delegate: nil)
    }
    
    // MARK: - Layout Functions
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .lightGray
        layer.cornerRadius = 10
        addComponents()
        addComponentsConstraints()
    }
    
    private func addComponents() {
        addSubview(nameLabel)
        addSubview(textField)
        addSubview(controlOptions)
    }
    
    private func addComponentsConstraints() {
        addNameLabelConstraints()
        addTextFieldConstraints()
        addControlOptionsConstraints()
    }
    
    private func addNameLabelConstraints() {
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
    }
    
    private func addTextFieldConstraints() {
        textField.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        textField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 26).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 26).isActive = true
    }
    
    private func addControlOptionsConstraints() {
        controlOptions.topAnchor.constraint(equalTo: topAnchor).isActive = true
        controlOptions.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        controlOptions.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        controlOptions.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    // MARK: - Public Functions
    
    public func setup(value: Int) {
        textField.text = String(value)
        textField.addAccessibility()
    }
    
    public func setup(color: UIColor) {
        nameLabel.textColor = color
    }
    
    public func setEditingMode(_ isEditing: Bool) {
        controlOptions.isHidden = !isEditing
    }
}

extension TransformerAttributeView: TransformerViewAttributedButtonsDelegate {
    func didTapIncrease() {
        let currentValue = Int(textField.text ?? "0") ?? 1
        let nextValue = currentValue + 1
        delegate?.didUpdate(type: type, value: nextValue)
    }
    
    func didTapDescrease() {
        let currentValue = Int(textField.text ?? "0") ?? 1
        let nextValue = currentValue - 1
        delegate?.didUpdate(type: type, value: nextValue)
    }
}
