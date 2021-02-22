//
//  TransformerCell.swift
//  Transformers
//
//  Created by Willian Rodrigues on 14/02/21.
//

import UIKit
import APIService

final class TransformerCell: UITableViewCell {
    static let indetifier = String(describing: TransformerCell.self)
    
    // MARK: - Views
    
    private lazy var transformerCard = TransformerViewCard(delegate: nil)
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    // MARK: - Layout Functions
    
    private func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        selectionStyle = .none
        backgroundColor = .clear
        addComponents()
        addComponentsConstraints()
    }
    
    private func addComponents() {
        contentView.addSubview(transformerCard)
    }
    
    private func addComponentsConstraints() {
        addTransformerCardConstraints()
    }
    
    private func addTransformerCardConstraints() {
        transformerCard.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        transformerCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50).isActive = true
        transformerCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50).isActive = true
        transformerCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    // MARK: - Setup Cell
    
    public func setup(with transformer: Global.Model.Transformer) {
        transformerCard.setup(transformer: transformer, isEditing: false)
    }
}
