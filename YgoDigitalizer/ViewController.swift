//
//  ViewController.swift
//  YuGiOhVirtualizer
//
//  Created by Bruno Thuma on 27/09/21.
//

import UIKit


class ViewController: UIViewController {

    private lazy var scanButton: UIButton = .init()
    private lazy var viewCollectionButton: UIButton = .init()
    
    let gradient = CAGradientLayer()

    override func viewDidLoad() {
        title = "Main Menu"
        
        setupViews()
        setupHierarchy()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func setupViews() {
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor.systemGray5.cgColor, UIColor.systemGray6.cgColor]
        
        self.view.layer.insertSublayer(gradient, at: 0)
        
        viewCollectionButton.translatesAutoresizingMaskIntoConstraints = false
        viewCollectionButton.setTitle("View my collection", for: .normal)
        viewCollectionButton.backgroundColor = .systemBlue
        viewCollectionButton.setTitleColor(.white, for: .normal)
        viewCollectionButton.layer.cornerRadius = 12
        viewCollectionButton.addTarget(self,
                                       action: #selector(viewCollectionTapped),
                                       for: .touchUpInside)
        
        scanButton.translatesAutoresizingMaskIntoConstraints = false
        scanButton.setTitle("Scan Card", for: .normal)
        scanButton.backgroundColor = .systemBlue
        scanButton.setTitleColor(.white, for: .normal)
        scanButton.layer.cornerRadius = 12
        scanButton.addTarget(self,
                             action: #selector(scanTapped),
                             for: .touchUpInside)
    }

    func setupHierarchy() {
        view.addSubview(viewCollectionButton)
        view.addSubview(scanButton)
    }

    func setupConstraints() {
        let viewCollectionButtonConstraints = [
            viewCollectionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewCollectionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            viewCollectionButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            viewCollectionButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(viewCollectionButtonConstraints)
        
        let scanButtonConstraints = [
            scanButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scanButton.topAnchor.constraint(equalTo: viewCollectionButton.bottomAnchor, constant: 40),
            scanButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            scanButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(scanButtonConstraints)
    }

    @objc private func scanTapped() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        let scanVC = ScanViewController()
        navigationController?.pushViewController(scanVC, animated: true)
    }
    
    @objc private func viewCollectionTapped() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        let collectionVC = CollectionViewController()
        navigationController?.pushViewController(collectionVC, animated: true)
    }
}


