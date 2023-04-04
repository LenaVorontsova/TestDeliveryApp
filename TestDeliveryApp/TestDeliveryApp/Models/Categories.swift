//
//  Categories.swift
//  TestDeliveryApp
//
//  Created by Lena Vorontsova on 04.04.2023.
//

import Foundation

struct CategoriesData: Codable {
    let categories: [Category]
    
    init(categories: [Category]) {
        self.categories = categories
    }
}

struct Category: Codable {
    let idCategory, strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
    
    init(idCategory: String, strCategory: String, strCategoryThumb: String, strCategoryDescription: String) {
        self.idCategory = idCategory
        self.strCategory = strCategory
        self.strCategoryThumb = strCategoryThumb
        self.strCategoryDescription = strCategoryDescription
    }
}
