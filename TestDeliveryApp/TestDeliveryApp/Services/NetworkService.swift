//
//  NetworkService.swift
//  TestDeliveryApp
//
//  Created by Lena Vorontsova on 04.04.2023.
//

import UIKit

final class NetworkService {
    private let baseURL = "https://www.themealdb.com/api/json/v1/1/"
    
    func getCategories(completed: @escaping (Result<CategoriesData, Errors>) -> Void) {
        let categoriesURL = baseURL + "categories.php"
        
        guard let url = URL(string: categoriesURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                print("Something is wrong!")
                return
            }
            print("Downloaded Categories")
            
            do {
                let decoder = JSONDecoder()
                let downloadedCategories = try decoder.decode(CategoriesData.self, from: data)
                completed(.success(downloadedCategories))
            }
            catch {
                print(error.localizedDescription)
                print("Error Parsing Categories JSON")
            }
        }
        task.resume()
    }
    
    func getMeals(category: String, completed: @escaping (Result<MealData, Errors>) -> Void) {
        let mealsURL = baseURL + "filter.php?c=\(category)"
        
        guard let url = URL(string: mealsURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                print("Something is wrong!")
                return
            }
            let str = String(decoding: data, as: UTF8.self)
            print(str)
            
            do {
                let decoder = JSONDecoder()
                let downloadedMeals = try decoder.decode(MealData.self, from: data)
                completed(.success(downloadedMeals))
            }
            catch let error as NSError {
                        print("Could not fetch. \(error), \(error.userInfo)")
                    }
//            catch {
//                print("Error Parsing Meals JSON")
//            }
            
        }
        task.resume()
    }
}
