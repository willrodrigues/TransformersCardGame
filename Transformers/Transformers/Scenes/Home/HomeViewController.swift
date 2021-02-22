//
//  HomeViewController.swift
//  Transformers
//
//  Created by Willian Rodrigues on 14/02/21.
//

import UIKit

protocol HomeDisplayLogic: class {
    func displayScreenValues(viewModel: Home.Model.ViewModel)
    func displayTransformerDetails()
    func displayMessage(viewModel: Home.Model.ResultViewModel)
}

///This is the first main viewController to be presented, It contains a tableView to list all transformers
final class HomeViewController: UIViewController, HomeDisplayLogic {
    
    // MARK: - Archtecture Objects
    
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    // MARK: - ViewModel
    
    var viewModel: Home.Model.ViewModel?
    
    // MARK: - Views
    
    var alertController: UIAlertController?
    
    private lazy var spinning: UIActivityIndicatorView = {
        let spinning = UIActivityIndicatorView()
        spinning.translatesAutoresizingMaskIntoConstraints = false
        spinning.hidesWhenStopped = true
        if #available(iOS 13.0, *) {
            spinning.style = .large
        } else {
            spinning.style = .whiteLarge
        }
        spinning.tintColor = .white
        spinning.addAccessibility()
        return spinning
    }()
    
    private(set) lazy var createButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor = .green
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var warButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.backgroundColor = .red
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapWarButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var optionsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.addArrangedSubview(warButton)
        stack.addArrangedSubview(createButton)
        stack.spacing = 8
        return stack
    }()
    
    private lazy var titleLabelTop: NSLayoutConstraint = { titleLabel.topAnchor.constraint(equalTo: safeAreaTopAnchor, constant: 10) }()
    private lazy var titleLabelCenterY: NSLayoutConstraint = { titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor) }()
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .blue
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(TransformerCell.self, forCellReuseIdentifier: TransformerCell.indetifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addAccessibility(description: "accessibility.homeTableView".localized)
        return tableView
    }()
    
    // MARK: - ViewController Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinning.startAnimating()
        view.backgroundColor = .black
        addComponents()
        addComponentsConstraints()
        loadScreenValues()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle { .lightContent }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - Private Functions
    
    private func loadScreenValues() {
        interactor?.loadTrasformers()
    }
    
    // MARK: - Layout Functions
    
    private func addComponents() {
        view.addSubview(titleLabel)
        view.addSubview(optionsStack)
        view.addSubview(tableView)
        view.addSubview(spinning)
    }
    
    private func addComponentsConstraints() {
        addTitleLabelConstraints()
        addOptionsStackConstraints()
        addTableviewConstraints()
        addSpinningConstraints()
        addSpinningConstraints()
    }
    
    private func addTitleLabelConstraints() {
        shouldCenterTitleLabel(false)
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    
    private func addOptionsStackConstraints() {
        optionsStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        optionsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        optionsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        optionsStack.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func shouldCenterTitleLabel(_ center: Bool) {
        titleLabelTop.isActive = !center
        titleLabelCenterY.isActive = center
        warButton.isHidden = center
    }
    
    private func addTableviewConstraints() {
        tableView.topAnchor.constraint(equalTo: optionsStack.bottomAnchor, constant: 8).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func addSpinningConstraints() {
        spinning.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spinning.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    // MARK: - Display Logic
    
    func displayScreenValues(viewModel: Home.Model.ViewModel) {
        DispatchQueue.main.async {
            self.viewModel = viewModel
            self.shouldCenterTitleLabel(viewModel.shouldCenterTitle)
            self.spinning.stopAnimating()
            self.titleLabel.text = viewModel.title
            self.titleLabel.addAccessibility()
            self.createButton.setTitle(viewModel.addButtonTitle, for: .normal)
            self.createButton.addAccessibility()
            self.warButton.setTitle(viewModel.warButtonTitle, for: .normal)
            self.warButton.addAccessibility()
            self.tableView.reloadData()
        }
    }
    
    func displayTransformerDetails() {
        router?.routeToTransformerDetails()
    }
    
    func displayMessage(viewModel: Home.Model.ResultViewModel) {
        alertController = UIAlertController(title: viewModel.title,
                                            message: viewModel.message,
                                            preferredStyle: .alert)
        let alertAction = UIAlertAction(title: viewModel.button,
                                        style: .default,
                                        handler: nil)
        alertController?.addAction(alertAction)
        router?.routeToMessage()
    }
    
    // MARK: - Button Actions
    
    @objc private func didTapCreateButton() {
        router?.routeToCreateTransformer()
    }
    
    @objc private func didTapWarButton() {
        interactor?.performWar()
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.transformers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransformerCell.indetifier) as? TransformerCell,
              let transformer = viewModel?.transformers[indexPath.row] else { return UITableViewCell() }
        cell.setup(with: transformer)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.didTapTransformer(index: indexPath.row)
    }
}
