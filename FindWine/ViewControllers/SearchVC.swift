//
//  SearchVC.swift
//  FindWine
//
//  Created by Маргарита Ставнийчук on 26.08.2022.
//

import UIKit

class SearchVC: UIViewController {
    
    var wines: [Wine] = []
    let logoImageView = UIImageView()
    let wineNameTextField = FWTextField()
    let actionButton = FWButton(color: .systemRed, title: "Search")
    let notificationCenter = NotificationCenter.default
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let stackView = UIStackView()
    weak var scrollViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        notificationCenter.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        configureScrollView()
        configureContentView()
        configureStackView()
        configureStackViewSubviews()
        dismissKeyboardTapGesture()
        setupActionButton()
        getWineList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func keyboardWillAppear(_ notification: Notification) {
        if let userInfo = notification.userInfo,
           let keyboardRectangle = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            //            scrollViewBottomConstraint?.isActive = false
            //            scrollViewBottomConstraint = scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -keyboardRectangle.height)
            //            scrollViewBottomConstraint?.isActive = true
            scrollViewBottomConstraint?.constant = -keyboardRectangle.height
        }
    }
    
    @objc func keyboardWillDisappear() {
        //        scrollViewBottomConstraint?.isActive = false
        //        scrollViewBottomConstraint = scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        //        scrollViewBottomConstraint?.isActive = true
        scrollViewBottomConstraint?.constant = 0
    }
    
    func dismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    func setupActionButton() {
        actionButton.addTarget(self, action: #selector(pushWineListVC), for: .touchUpInside)
    }
    
    @objc func pushWineListVC() {
        let wineListVC = WineListVC()
        wineListVC.title = wineNameTextField.text
        wineListVC.wines = wines.filter { wine in
            return wine.title.lowercased().contains(wineNameTextField.text?.lowercased() ?? "")
        }
        navigationController?.pushViewController(wineListVC, animated: true)
    }
    
    func getWineList() {
        NetworkManager.shared.getWineInfo { [weak self ] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let wines):
                self.wines = wines
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        self.scrollViewBottomConstraint = bottomConstraint
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomConstraint
        ])
    }
    
    func configureContentView() {
        contentView.addSubview(stackView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ])
    }
    
    func configureStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 16
        
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(wineNameTextField)
        stackView.addArrangedSubview(actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configureStackViewSubviews() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.fwLogo
        
        wineNameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            wineNameTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            wineNameTextField.heightAnchor.constraint(equalToConstant: 44),
            actionButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushWineListVC()
        return true
    }
}
