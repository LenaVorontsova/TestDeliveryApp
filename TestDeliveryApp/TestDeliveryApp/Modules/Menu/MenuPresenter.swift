//
//  MenuPresenter.swift
//  TestDeliveryApp
//
//  Created by Lena Vorontsova on 04.04.2023.
//

import UIKit

protocol MenuPresenting: AnyObject {
    var categories: [Category] { get set }
    var meal: [Meal] { get set }
    var selectedCategory: String { get set }
    func getInfoCategories()
    func getInfoMeals(for category: String)
    func loadData()
    func updateSelectedCategory(_ category: String)
}

final class MenuPresenter: MenuPresenting {
    
    private var categoriesTest: [Category] = []
    var categories = [Category]()
    var meal: [Meal] = []
    var selectedCategory: String = ""
    // var category: String = "Beef"
    weak var controller: (UIViewController & IViewControllers)?
    let network: NetworkService
    
    init(network: NetworkService) {
        self.network = network
    }
    
    func loadData() {
        self.getInfoCategories()
        self.getInfoMeals(for: selectedCategory)
        self.controller?.reloadTable()
    }
    
    func getInfoCategories() {
        network.getCategories { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let categories):
                    self.updateInfoCategories(categories: categories)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func getInfoMeals(for category: String) {
            network.getMeals(category: category) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let meal):
                    self.updateInfoMeals(meal: meal)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func updateInfoCategories(categories: CategoriesData) {
        DispatchQueue.main.async {
            self.categoriesTest.append(contentsOf: categories.categories)
            self.categories = self.categoriesTest
            self.controller?.reloadTable()
        }
    }
    
    func updateInfoMeals(meal: MealData) {
        DispatchQueue.main.async {
            self.meal = meal.meals
            // self.meal.append(contentsOf: meal.meals)
            self.controller?.reloadTable()
        }
    }
    
    func updateSelectedCategory(_ category: String) {
        self.selectedCategory = category
        self.getInfoMeals(for: category)
    }
}
