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
    
    let idMeal: String
    let strMeal: String
    let strMealThumb: String

    init(idMeal: String, strMeal: String, strMealThumb: String) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
    }
}
