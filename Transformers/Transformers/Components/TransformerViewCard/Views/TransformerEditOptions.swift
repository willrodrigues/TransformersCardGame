//
//  TransformerEditOptions.swift
//  Transformers
//
//  Created by Willian Rodrigues on 17/02/21.
//

import UIKit

protocol TransformerEditOptionsDelegate: class {
    func didTapEdit()
    func didTapSave()
    func didTapDelete()
}

final class TransformerEditOptions: UIView {
    
    // MARK: Button Types
    
    enum EditOptionButtonType: Int {
        case edit
        case save
        case delete
    }
    
    // MARK: - Delegate
    
    weak var delegate: TransformerEditOptionsDelegate?
    
    // MARK: - Views
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor = .green
        button.tag = EditOptionButtonType.edit.rawValue
        button.titleLabel?.font = .systemFont(ofSize: 10)
        button.setTitle("transformerEditOptions.editButton".localized, for: .normal)
        button.addTarget(self, action: #selector(didTapOptions), for: .touchUpInside)
        button.addAccessibility()
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor = .blue
        button.tag = EditOptionButtonType.save.rawValue
        button.titleLabel?.font = .systemFont(ofSize: 10)
        button.addTarget(self, action: #selector(didTapOptions), for: .touchUpInside)
        button.setTitle("transformerEditOptions.saveButton".localized, for: .normal)
        button.addAccessibility()
        button.isHidden = true
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor = .red
        button.tag = EditOptionButtonType.delete.rawValue
        button.titleLabel?.font = .systemFont(ofSize: 10)
        button.setTitle("transformerEditOptions.deleteButton".localized, for: .normal)
        button.addTarget(self, action: #selector(didTapOptions), for: .touchUpInside)
        button.addAccessibility()
        button.isHidden = true
        return button
    }()
    
    // MARK: - Life Cycle
    
    init(delegate: TransformerEditOptionsDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
        self.isHidden = true
        self.setupViews()
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(delegate: nil)
    }
    
    // MARK: - Layout Functions
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        addComponents()
        addComponentsConstraints()
    }
    
    private func addComponents() {
        addSubview(editButton)
        addSubview(saveButton)
        addSubview(deleteButton)
    }
    
    private func addComponentsConstraints() {
        addEditButtonConstraints()
        addSaveButtonConstraints()
        addDeleteButtonConstraints()
    }
    
    private func addEditButtonConstraints() {
        editButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        editButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        editButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        editButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func addSaveButtonConstraints() {
        saveButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -15).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func addDeleteButtonConstraints() {
        deleteButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    // MARK: - Button Actions
    
    @objc private func didTapOptions(_ sender: UIButton) {
        let selectedOption = EditOptionButtonType(rawValue: sender.tag)
        switch selectedOption {
        case .edit:
            activateEditingOptions(activate: true)
            delegate?.didTapEdit()
        case .save:
            delegate?.didTapSave()
        case .delete:
            delegate?.didTapDelete()
        default:
            return
        }
    }
    
    // MARK: - Private Functions
    
    public func activateEditingOptions(activate: Bool) {
        editButton.isHidden = activate
        saveButton.isHidden = !activate
        deleteButton.isHidden = !activate
    }
}
