//
//  Character.swift
//  TestRickAndMorty
//
//  Created by Семён Соколов on 23.04.2022.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let species: String
    let status: String
    let gender: String
    let image: String?
    let location: Location
    let episode: [String]  
}

