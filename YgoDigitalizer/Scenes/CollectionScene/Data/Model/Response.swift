//
//  Response.swift
//  YgoDigitalizer
//
//  Created by Bruno Thuma on 04/10/21.
//

struct Response: Decodable {
    let info: Info
    let results: [Card]
}
