//
//  TransformerViewAttributedButtons.swift
//  Transformers
//
//  Created by Willian Rodrigues on 17/02/21.
//

import UIKit

protocol TransformerViewAttributedButtonsDelegate: class {
    func didTapIncrease()
    func didTapDescrease()
}

class TransformerViewAttributedButtons: UIView {
    
    // MARK: - Delegate
    
    weak var delegate: TransformerViewAttributedButtonsDelegate?
    
    // MARK: - Views
    
    private lazy var increaseButton = createButtonWith(image: UIImage(named: "arrowUp"), selector: #selector(didTapIncrease))
    private lazy var decreaseButton = createButtonWith(image: UIImage(named: "arrowDown"), selector: #selector(didTapDecrease))
    
    // MARK: - Life Cycle
    
    init(delegate: TransformerViewAttributedButtonsDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
        self.setupViews()
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(delegate: nil)
    }
    
    // MARK: - Layout Functions
    
    func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        isHidden = true
        addComponents()
        addComponentsConstraints()
    }
    
    private func addComponents() {
        addSubview(increaseButton)
        increaseButton.addAccessibility()
        addSubview(decreaseButton)
        decreaseButton.addAccessibility()
    }
    
    private func addComponentsConstraints() {
        addIncreaseButtonConstraints()
        addDecreaseButtonConstraints()
    }
    
    private func addIncreaseButtonConstraints() {
        increaseButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        increaseButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        increaseButton.trailingAnchor.constraint(equalTo: decreaseButton.leadingAnchor, constant: -15).isActive = true
        increaseButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func addDecreaseButtonConstraints() {
        decreaseButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        decreaseButton.leadingAnchor.constraint(equalTo: increaseButton.trailingAnchor, constant: 15).isActive = true
        decreaseButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        decreaseButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func createButtonWith(image: UIImage?, selector: Selector) -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAccessibility()
        button.setImage(image, for: .normal)
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
    
    // MARK: - Button Actions
    
    @objc private func didTapIncrease() {
        delegate?.didTapIncrease()
    }
    
    @objc private func didTapDecrease() {
        delegate?.didTapDescrease()
    }
    
}
