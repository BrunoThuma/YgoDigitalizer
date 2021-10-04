//
//  CollectionViewController.swift
//  YgoDigitalizer
//
//  Created by Bruno Thuma on 04/10/21.
//

import UIKit

class CollectionViewController: UIViewController, UITableViewDelegate {
    
    private lazy var cardsTableView: UITableView = .init()
    
    let adapter = CardListAdapter()
    let fetchCardsUseCase = FetchCardsUseCase()
    let gradient = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.addSubview(cardsTableView)
        setupConstraints()
        setupAdapter()
        loadData()
    }
    
    func loadData() {
        fetchCardsUseCase.execute(id: "89631139") { characters in
            self.updateCards(using: characters)
        }
    }
    
    func setupAdapter() {
        cardsTableView.dataSource = adapter
    }
    
    func updateCards(using cards: [Card]) {
        adapter.cards = cards
        cardsTableView.reloadData()
    }
    
    private func setupViews() {
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor.systemGray5.cgColor, UIColor.systemGray6.cgColor]
        
        self.view.layer.insertSublayer(gradient, at: 0)
        
        cardsTableView.dataSource = adapter
        cardsTableView.delegate = self
    }
    
    private func setupConstraints() {
        let cardsTableViewConstraints = [
            cardsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            cardsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cardsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(cardsTableViewConstraints)
    }
}
