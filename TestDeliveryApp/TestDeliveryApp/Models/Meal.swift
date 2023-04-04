//
//  Meal.swift
//  TestDeliveryApp
//
//  Created by Lena Vorontsova on 04.04.2023.
//

import Foundation

struct MealData: Codable {
    let meals: [Meal]
    
    init (meals: [Meal]) {
        self.meals = meals
    }
}

struct Meal: Codable {
    
    let strMeal: String
    let strMealThumb: String
    let idMeal: String?

    init(strMeal: String, strMealThumb: String, idMeal: String) {
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
        self.idMeal = idMeal
    }
}
