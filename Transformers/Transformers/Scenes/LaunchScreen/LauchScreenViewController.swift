//
//  LauchScreenViewController.swift
//  Transformers
//
//  Created by Willian Rodrigues on 14/02/21.
//

import UIKit

///This is viewController created to execute an fade in animation before the homeViewController be shown.
final class LauchScreenViewController: UIViewController {
    
    // MARK: - Archtecture Objects
    
    var router: (NSObjectProtocol & LauchScreenRoutingLogic)?
    
    // MARK: - Views
    
    lazy var transformerImage: UIImageView = {
        let image = UIImage(named: "launchCards")
        let imageV = UIImageView(image: image)
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.contentMode = .scaleAspectFill
        return imageV
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
        view.backgroundColor = .black
        addComponents()
        addComponentsConstraints()
        animateAndRouteToHome()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let router = LauchScreenRouter()

        viewController.router = router
        router.viewController = viewController
    }
    
    // MARK: - Layout Functions
    
    private func addComponents() {
        view.addSubview(transformerImage)
    }
    
    private func addComponentsConstraints() {
        addTransformerImageConstraints()
    }
    
    private func addTransformerImageConstraints() {
        transformerImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        transformerImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        transformerImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        transformerImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func animateAndRouteToHome() {
        
        UIView.animate(withDuration: 2, animations: {
            self.transformerImage.alpha = 0
        }, completion: goToHome)
    }
    
    private func goToHome(_ animationCompleted: Bool) {
        router?.routeToHome()
    }

}
