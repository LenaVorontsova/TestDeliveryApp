//
//  MenuPresenter.swift
//  TestDeliveryApp
//
//  Created by Lena Vorontsova on 04.04.2023.
//

import UIKit

protocol MenuPresenting: AnyObject {
    var categories: [Category] { get set }
    func getInfoCategories()
}

final class MenuPresenter: MenuPresenting {
    var categories = [Category]()
    weak var controller: (UIViewController & IViewControllers)?
    let network: NetworkService
    
    init(network: NetworkService) {
        self.network = network
    }
    
    func getInfoCategories() {
        network.getCategories { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let categories):
                    self.updateInfo(categories: categories)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func updateInfo(categories: CategoriesData) {
        DispatchQueue.main.async {
            self.categories = categories.categories
            // self.tableView.isHidden = false
            // self.tableView.reloadData()
        }
    }
}
