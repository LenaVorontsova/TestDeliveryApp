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
    func getInfoCategories()
    func getInfoMeals()
    func loadData()
}

final class MenuPresenter: MenuPresenting {
    private var categoriesTest: [Category] = []
    var categories = [Category]()
    var meal: [Meal] = []
    var category: String = "Beef"
    weak var controller: (UIViewController & IViewControllers)?
    let network: NetworkService
    
    init(network: NetworkService) {
        self.network = network
    }
    
    func loadData() {
        self.getInfoCategories()
        self.getInfoMeals()
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
    
    func getInfoMeals() {
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
            self.meal.append(contentsOf: meal.meals)
            self.controller?.reloadTable()
        }
    }
}
