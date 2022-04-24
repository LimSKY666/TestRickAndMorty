//
//  ListOfCharacters.swift
//  TestRickAndMorty
//
//  Created by Семён Соколов on 23.04.2022.
//

import Foundation

struct ListOfCharacters: Codable {
    let info: PageInfo
    let results: [Character]
}
