//
//  TransformerView.swift
//  Transformers
//
//  Created by Willian Rodrigues on 16/02/21.
//

import UIKit
import APIService

protocol TransformerViewCardDelegate: class {
    func didSave(_ transformer: Global.Model.Transformer)
    func didDelete(_ id: String)
}

/**
 This view could be used by any viewController which wants to show the transformer.
 */
final class TransformerViewCard: UIView {
    
    // MARK: - Delegate
    
    weak var delegate: TransformerViewCardDelegate?
    var transformer: Global.Model.Transformer? = Global.Model.Transformer() { didSet { updateComponents() } }
    
    // MARK: - Views
    
    private lazy var borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var teamIcon: APIImageView = {
        let imagev = APIImageView()
        imagev.translatesAutoresizingMaskIntoConstraints = false
        imagev.clipsToBounds = true
        imagev.contentMode = .scaleAspectFit
        imagev.image = UIImage(named: "noTeamYet")
        imagev.addAccessibility(description: "teamName.accessibility.unknown".localized)
        return imagev
    }()
    
    private lazy var nameTextField: UITextField = {
        let textf = UITextField()
        textf.translatesAutoresizingMaskIntoConstraints = false
        textf.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        textf.isUserInteractionEnabled = false
        textf.text = ""
        textf.layer.cornerRadius = 10
        textf.textAlignment = .center
        textf.font = .boldSystemFont(ofSize: 20)
        textf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textf.addDoneButtonOnKeyboard()
        textf.autocorrectionType = .no
        return textf
    }()
    
    private lazy var overallRating: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var editOptions = TransformerEditOptions(delegate: self)
    private lazy var teamOptions = TransformerTeamOptions(delegate: self)
    private lazy var courageAttribute = TransformerAttributeView(type: .courage, delegate: self)
    private lazy var skillAttribute = TransformerAttributeView(type: .skill, delegate: self)
    private lazy var enduranceAttribute = TransformerAttributeView(type: .endurance, delegate: self)
    private lazy var firepowerAttribute = TransformerAttributeView(type: .firepower, delegate: self)
    private lazy var intelligenteAttribute = TransformerAttributeView(type: .intelligence, delegate: self)
    private lazy var speedAttribute = TransformerAttributeView(type: .speed, delegate: self)
    private lazy var strengthAttribute = TransformerAttributeView(type: .strength, delegate: self)
    private lazy var rankAttribute = TransformerAttributeView(type: .rank, delegate: self)
   
    // MARK: - Life Cycle
    
    /**
     Initializes a view which contains all views required to show the transformer object.
     Use setups functions from this view to configure It.
     
     - Parameters:
        - delegate: This delegate should communicate when a transformer attribute has been saved or if It has been deleted.
     
     - Returns: An empty card view which could be fullfilled with setups functions
     */
    
    init(delegate: TransformerViewCardDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
        self.setupViews()
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(delegate: nil)
    }
    
    // MARK: - Layout Functions
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        let backImage = UIImage(named: "cardBackground") ?? UIImage()
        backgroundColor = UIColor(patternImage: backImage)
        layer.cornerRadius = 10
        addComponents()
        addComponentsConstraints()
    }
    
    private func addComponents() {
        addSubview(borderView)
        addSubview(editOptions)
        addSubview(teamIcon)
        addSubview(nameTextField)
        addSubview(overallRating)
        addSubview(teamOptions)
        addSubview(courageAttribute)
        addSubview(skillAttribute)
        addSubview(enduranceAttribute)
        addSubview(firepowerAttribute)
        addSubview(intelligenteAttribute)
        addSubview(speedAttribute)
        addSubview(strengthAttribute)
        addSubview(rankAttribute)
    }
    
    private func addComponentsConstraints() {
        addBorderViewConstraints()
        addEditOptionsConstraints()
        addTeamIconConstraints()
        addNameLabelConstraints()
        addOverallRatingConstraints()
        addTeamOptionsConstraints()
        addCourageAttributeConstraints()
        addSkillAttributeConstraints()
        addEnduranceAttributeConstraints()
        addFirepowerAttributeConstraints()
        addIntelligenteAttributeConstraints()
        addSpeedAttributeConstraints()
        addStrengthAttributeConstraints()
        addRankAttributeConstraints()
    }
    
    private func addBorderViewConstraints() {
        borderView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        borderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        borderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        borderView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }
    
    private func addEditOptionsConstraints() {
        editOptions.topAnchor.constraint(equalTo: borderView.topAnchor, constant: 10).isActive = true
        editOptions.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 10).isActive = true
        editOptions.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -10).isActive = true
        editOptions.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    private func addTeamIconConstraints() {
        teamIcon.widthAnchor.constraint(equalToConstant: 80).isActive = true
        teamIcon.heightAnchor.constraint(equalToConstant: 80).isActive = true
        teamIcon.topAnchor.constraint(equalTo: editOptions.bottomAnchor, constant: 5).isActive = true
        teamIcon.centerXAnchor.constraint(equalTo: borderView.centerXAnchor).isActive = true
    }
    
    private func addNameLabelConstraints() {
        nameTextField.topAnchor.constraint(equalTo: teamIcon.bottomAnchor, constant: 10).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 15).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -15).isActive = true
    }
    
    private func addOverallRatingConstraints() {
        overallRating.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true
        overallRating.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        overallRating.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    private func addTeamOptionsConstraints() {
        let halfScreen = UIScreen.main.bounds.width / 2
        teamOptions.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true
        teamOptions.widthAnchor.constraint(equalToConstant: halfScreen).isActive = true
        teamOptions.centerXAnchor.constraint(equalTo: borderView.centerXAnchor).isActive = true
        teamOptions.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func addCourageAttributeConstraints() {
        courageAttribute.topAnchor.constraint(equalTo: teamOptions.bottomAnchor, constant: 15).isActive = true
        courageAttribute.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 15).isActive = true
        courageAttribute.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -15).isActive = true
    }
    
    private func addSkillAttributeConstraints() {
        skillAttribute.topAnchor.constraint(equalTo: courageAttribute.bottomAnchor, constant: 10).isActive = true
        skillAttribute.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 15).isActive = true
        skillAttribute.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -15).isActive = true
    }
    
    private func addEnduranceAttributeConstraints() {
        enduranceAttribute.topAnchor.constraint(equalTo: skillAttribute.bottomAnchor, constant: 10).isActive = true
        enduranceAttribute.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 15).isActive = true
        enduranceAttribute.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -15).isActive = true
    }
    
    private func addFirepowerAttributeConstraints() {
        firepowerAttribute.topAnchor.constraint(equalTo: enduranceAttribute.bottomAnchor, constant: 10).isActive = true
        firepowerAttribute.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 15).isActive = true
        firepowerAttribute.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -15).isActive = true
    }
    
    private func addIntelligenteAttributeConstraints() {
        intelligenteAttribute.topAnchor.constraint(equalTo: firepowerAttribute.bottomAnchor, constant: 10).isActive = true
        intelligenteAttribute.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 15).isActive = true
        intelligenteAttribute.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -15).isActive = true
    }
    
    private func addSpeedAttributeConstraints() {
        speedAttribute.topAnchor.constraint(equalTo: intelligenteAttribute.bottomAnchor, constant: 10).isActive = true
        speedAttribute.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 15).isActive = true
        speedAttribute.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -15).isActive = true
    }
    
    private func addStrengthAttributeConstraints() {
        strengthAttribute.topAnchor.constraint(equalTo: speedAttribute.bottomAnchor, constant: 10).isActive = true
        strengthAttribute.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 15).isActive = true
        strengthAttribute.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -15).isActive = true
    }
    
    private func addRankAttributeConstraints() {
        rankAttribute.topAnchor.constraint(equalTo: strengthAttribute.bottomAnchor, constant: 10).isActive = true
        rankAttribute.leadingAnchor.constraint(equalTo: borderView.leadingAnchor, constant: 15).isActive = true
        rankAttribute.trailingAnchor.constraint(equalTo: borderView.trailingAnchor, constant: -15).isActive = true
        rankAttribute.bottomAnchor.constraint(equalTo: borderView.bottomAnchor, constant: -15).isActive = true
    }
    
    private func updateComponents() {
        guard let transformer = self.transformer else { return }
        updateComponents(with: transformer)
        setThemeColorFor(team: transformer.team)
    }
    
    private func updateComponents(with model: Global.Model.Transformer) {
        nameTextField.text = model.name
        nameTextField.addAccessibility()
        courageAttribute.setup(value: model.courage)
        overallRating.text = "transformerDetails.overallRating".localized(with: model.overallRating)
        overallRating.addAccessibility()
        skillAttribute.setup(value: model.skill)
        enduranceAttribute.setup(value: model.endurance)
        firepowerAttribute.setup(value: model.firepower)
        intelligenteAttribute.setup(value: model.intelligence)
        speedAttribute.setup(value: model.speed)
        strengthAttribute.setup(value: model.strength)
        rankAttribute.setup(value: model.rank)
        guard !model.teamIcon.isEmpty else { teamIcon.image = UIImage(named: "noTeamYet"); return }
        teamIcon.downloadFrom(stringURL: model.teamIcon)
        switch model.team {
        case .autobots:
            teamIcon.addAccessibility(description: "teamName.accessibility.autobots".localized)
        case .decepticons:
            teamIcon.addAccessibility(description: "teamName.accessibility.decepticons".localized)
        default:
            teamIcon.addAccessibility(description: "teamName.accessibility.unknown".localized)
        }
    }
    
    private func setThemeColorFor(team: Global.Model.Team) {
        let color: UIColor = team == .autobots ? .red : ( team == .decepticons ? .purple : .black )
        updateComponents(with: color)
    }
    
    private func updateComponents(with color: UIColor) {
        nameTextField.textColor = color
        overallRating.textColor = color
        courageAttribute.setup(color: color)
        skillAttribute.setup(color: color)
        enduranceAttribute.setup(color: color)
        firepowerAttribute.setup(color: color)
        intelligenteAttribute.setup(color: color)
        speedAttribute.setup(color: color)
        strengthAttribute.setup(color: color)
        rankAttribute.setup(color: color)
    }
    
    private func setEditingMode(_ isEditing: Bool) {
        courageAttribute.setEditingMode(isEditing)
        skillAttribute.setEditingMode(isEditing)
        enduranceAttribute.setEditingMode(isEditing)
        firepowerAttribute.setEditingMode(isEditing)
        intelligenteAttribute.setEditingMode(isEditing)
        speedAttribute.setEditingMode(isEditing)
        strengthAttribute.setEditingMode(isEditing)
        rankAttribute.setEditingMode(isEditing)
        teamOptions.isHidden = !isEditing
        nameTextField.isUserInteractionEnabled = isEditing
        editOptions.activateEditingOptions(activate: isEditing)
        overallRating.isHidden = isEditing
    }
    
    // MARK: - TextView Functions
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        transformer?.name = (textField.text?.capitalized) ?? ""
    }
    
    // MARK: - Public Functions
    
    public func setup(transformer: Global.Model.Transformer?, isEditing: Bool, showEditButton: Bool = false) {
        self.transformer = transformer != nil ? transformer : Global.Model.Transformer()
        setEditingMode(isEditing)
        editOptions.isHidden = !showEditButton
    }
}

extension TransformerViewCard: TransformerTeamOptionsDelegate {
    func didSelected(team: Global.Model.Team) {
        transformer?.teamIcon = team.teamIconUrl
        transformer?.team = team
    }
}

extension TransformerViewCard: TransformerEditOptionsDelegate {
    func didTapEdit() {
        setEditingMode(true)
    }
    
    func didTapSave() {
        guard let transformer = self.transformer else { return }
        delegate?.didSave(transformer)
    }
    
    func didTapDelete() {
        delegate?.didDelete(transformer?.id ?? "")
    }
}

extension TransformerViewCard: TransformerAttributeViewDelegate {
    func didUpdate(type: TransformerViewCardModels.PropertieType, value: Int) {
        guard value <= 10 && value >= 1 else { return }
        switch type {
        case .courage:
            transformer?.courage = value
            courageAttribute.setup(value: value)
        case .skill:
            transformer?.skill = value
            skillAttribute.setup(value: value)
        case .endurance:
            transformer?.endurance = value
            enduranceAttribute.setup(value: value)
        case .firepower:
            transformer?.firepower = value
            firepowerAttribute.setup(value: value)
        case .intelligence:
            transformer?.intelligence = value
            intelligenteAttribute.setup(value: value)
        case .speed:
            transformer?.speed = value
            speedAttribute.setup(value: value)
        case .strength:
            transformer?.strength = value
            strengthAttribute.setup(value: value)
        case .rank:
            transformer?.rank = value
            rankAttribute.setup(value: value)
        }
    }
}
