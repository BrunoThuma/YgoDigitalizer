//
//  CardRepository.swift
//  YgoDigitalizer
//
//  Created by Bruno Thuma on 04/10/21.
//

import Foundation

// Essa camada decide da onde vem os dados, e como transformálos de bytes em um modelo
final class CardRepository {
    
    let service = CardService()
    
    func fetchCards(id: String, completion: @escaping (Card) -> Void) {
        service.fetchCards(id: id) { data in
            let decoder = JSONDecoder()
            
            do {
                let response = try decoder.decode(Response.self, from: data)
                
                DispatchQueue.main.async {
                    completion(response.data[0])
                }
                
            } catch let error {
                print("CardRepository: deu ruim o decode", error)
            }
        }
    }
}
