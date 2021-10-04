//
//  FetchCardsUseCase.swift
//  YgoDigitalizer
//
//  Created by Bruno Thuma on 04/10/21.
//

final class FetchCardsUseCase {
    
    let repository = CardRepository()
    
    func execute(id: String, completion: @escaping ([Card]) -> Void) {
        repository.fetchCards(id: id, completion: completion)
    }
}
