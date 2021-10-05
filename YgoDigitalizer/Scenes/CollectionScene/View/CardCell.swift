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
        let url = URL(string: card.card_images[0].image_url)!
        
        let request = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil {
                print("Fodeu-lhe a imagem. Erro: ", error ?? "nil error")
            }
            
            guard let data = data else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.cardImageView.image = image
            }
        }
        
        request.resume()
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = card.name
        
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        cardImageView.contentMode = .scaleAspectFit
        cardImageView.clipsToBounds = true
        
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.axis = .horizontal
        hStack.distribution = .fill
        hStack.alignment = .leading
        hStack.spacing = 10
        hStack.addArrangedSubview(cardImageView)
        hStack.addArrangedSubview(nameLabel)
        
        addSubview(hStack)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let hStackConstraints = [
            hStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            hStack.topAnchor.constraint(equalTo: self.topAnchor),
            hStack.widthAnchor.constraint(equalTo: self.widthAnchor),
            hStack.heightAnchor.constraint(equalTo: self.widthAnchor,
                                           multiplier: 0.5)
        ]
        NSLayoutConstraint.activate(hStackConstraints)

        let cardImageViewConstraints = [
            cardImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(cardImageViewConstraints)

//        let nameLabelConstraints = [
//            nameLabel.topAnchor.constraint(equalTo: hStack.topAnchor),
//            nameLabel.bottomAnchor.constraint(equalTo: hStack.bottomAnchor),
//            nameLabel.leadingAnchor.constraint(equalTo: cardImageView.trailingAnchor),
//            nameLabel.trailingAnchor.constraint(equalTo: hStack.trailingAnchor)
//        ]
//        NSLayoutConstraint.activate(nameLabelConstraints)
    }
}
