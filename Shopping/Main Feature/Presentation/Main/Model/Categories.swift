//
//  Categories.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 21/5/2022.
//

import Foundation

enum Categories : String{

    case books = "Books"
    case sport = "Sport"
    case music = "Music"
    case travel = "Travel"
    case electronics = "Electronics"
    case other = "Other"
}

struct FilterModel {

    var category: Categories
    var value: Bool
}
