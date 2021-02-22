//
//  TransformerTeamOptions.swift
//  Transformers
//
//  Created by Willian Rodrigues on 17/02/21.
//

import UIKit

protocol TransformerTeamOptionsDelegate: class {
    func didSelected(team: Global.Model.Team)
}

final class TransformerTeamOptions: UIView {
    
    // MARK: - Delegate
    
    weak var delegate: TransformerTeamOptionsDelegate?
    
    // MARK: - Views
    
    private lazy var autobotsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor = .red
        button.tag = 1
        button.titleLabel?.font = .systemFont(ofSize: 10)
        button.setTitle(Global.Model.Team.autobots.name, for: .normal)
        button.addAccessibility()
        button.addTarget(self, action: #selector(didTapTeamButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var decepticonButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor = .purple
        button.tag = 2
        button.titleLabel?.font = .systemFont(ofSize: 10)
        button.setTitle(Global.Model.Team.decepticons.name, for: .normal)
        button.addAccessibility()
        button.addTarget(self, action: #selector(didTapTeamButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var teamButtonSeparator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    // MARK: - Life Cycle
    
    init(delegate: TransformerTeamOptionsDelegate?) {
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
        addSubview(teamButtonSeparator)
        addSubview(autobotsButton)
        addSubview(decepticonButton)
    }
    
    private func addComponentsConstraints() {
        addTeamButtonSeparatorConstraints()
        addAutobotsButtonConstraints()
        addDecepticonButtonConstraints()
    }
    
    private func addTeamButtonSeparatorConstraints() {
        teamButtonSeparator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        teamButtonSeparator.topAnchor.constraint(equalTo: topAnchor).isActive = true
        teamButtonSeparator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        teamButtonSeparator.widthAnchor.constraint(equalToConstant: 3).isActive = true
    }
    
    private func addAutobotsButtonConstraints() {
        autobotsButton.centerYAnchor.constraint(equalTo: teamButtonSeparator.centerYAnchor).isActive = true
        autobotsButton.trailingAnchor.constraint(equalTo: teamButtonSeparator.leadingAnchor, constant: -10).isActive = true
        autobotsButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }
    
    private func addDecepticonButtonConstraints() {
        decepticonButton.centerYAnchor.constraint(equalTo: teamButtonSeparator.centerYAnchor).isActive = true
        decepticonButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        decepticonButton.leadingAnchor.constraint(equalTo: teamButtonSeparator.trailingAnchor, constant: 10).isActive = true
    }
    
    // MARK: - Button Actions
    
    @objc private func didTapTeamButton(_ sender: UIButton) {
        let team: Global.Model.Team = sender.tag == 1 ? .autobots : .decepticons
        delegate?.didSelected(team: team)
    }
}
