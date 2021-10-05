//
//  CardListAdapter.swift
//  YgoDigitalizer
//
//  Created by Bruno Thuma on 04/10/21.
//

import UIKit

final class CardListAdapter: NSObject, UITableViewDataSource {
    
    var cards: [Card] = []
    
    // Quantas linhas vai ter?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    // Qual a celula para essa linha?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let card = cards[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell",
                                                 for: indexPath) as! CardCell
        cell.configure(using: card)
        
        return cell
    }
}
