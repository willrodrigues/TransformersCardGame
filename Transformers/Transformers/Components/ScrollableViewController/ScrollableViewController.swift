//
//  ScrollableViewController.swift
//  Transformers
//
//  Created by Willian Rodrigues on 17/02/21.
//

import UIKit

class ScrollableViewController: UIViewController {
    
    // MARK: - Views
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .clear
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = .clear
        return scroll
    }()
    
    // MARK: - LifeCycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        registerNotifications()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        registerNotifications()
    }
    
    deinit {
        unregisterNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        addScrollViewConstraints()
    }
    
    // MARK: - Layout Functions
    
    private func addScrollViewConstraints() {
        scrollView.topAnchor.constraint(equalTo: safeAreaTopAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaBottomAnchor).isActive = true
    }
    
    // MARK: - Notifications
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Keyboard
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size else { return }

        let contentInsets: UIEdgeInsets = notification.name == UIResponder.keyboardWillHideNotification ? .zero : UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        
        DispatchQueue.main.async {
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = contentInsets
        }
    }
}
