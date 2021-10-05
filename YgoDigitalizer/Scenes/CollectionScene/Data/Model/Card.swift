//
//  Card.swift
//  YgoDigitalizer
//
//  Created by Bruno Thuma on 04/10/21.
//

struct Card: Decodable {
    let id: Int
    let name: String
    let desc: String
    let card_sets: [CardSet]
    let card_images: [CardImages]
}
