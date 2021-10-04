//
//  CardCell.swift
//  YgoDigitalizer
//
//  Created by Bruno Thuma on 04/10/21.
//

import UIKit

final class CardCell: UITableViewCell {
    private lazy var nameLabel: UILabel = .init()
//    private lazy var descriptionLabel: UILabel = .init()
    private lazy var cardImageView: UIImageView = .init()
    private lazy var hStack: UIStackView = .init()
    
    func configure(using card: Card) {
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = card.name
        
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        cardImageView.contentMode = .scaleAspectFit
        
        hStack.axis = .horizontal
        hStack.alignment = .leading
        hStack.spacing = 10
        hStack.addArrangedSubview(cardImageView)
        hStack.addArrangedSubview(nameLabel)
        
        addSubview(hStack)
        
        setupConstraints()
        
        let url = URL(string: card.image_url)!
        
        let request = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.cardImageView.image = image
            }
        }
        
        request.resume()
    }
    
    private func setupConstraints() {
        let cardImageViewConstraints = [
            cardImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cardImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            cardImageView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40),
            cardImageView.heightAnchor.constraint(equalTo: self.widthAnchor, constant: -40)
        ]
        NSLayoutConstraint.activate(cardImageViewConstraints)
    }
}
