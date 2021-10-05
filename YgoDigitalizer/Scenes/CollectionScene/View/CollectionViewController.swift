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
    
    var cardsCollection: [Card] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        cardsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cardsTableView)
        
        setupConstraints()
        setupAdapter()
        
        loadData(id: "89631139")
        loadData(id: "60681103")
    }
    
    func loadData(id: String) {
        fetchCardsUseCase.execute(id: id) { card in
            self.updateCollection(card: card)
        }
    }
    
    func updateCollection(card: Card) {
        cardsCollection += [card]
        updateCards(using: cardsCollection)
    }
    
    func setupAdapter() {
        cardsTableView.dataSource = adapter
    }
    
    func updateCards(using cards: [Card]) {
        adapter.cards = cards
        cardsTableView.reloadData()
    }
    
    private func setupViews() {
        title = "My Collection"
        
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor.systemGray5.cgColor, UIColor.systemGray6.cgColor]
        
        self.view.layer.insertSublayer(gradient, at: 0)
        
        cardsTableView.register(CardCell.self, forCellReuseIdentifier: "CardCell")
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
