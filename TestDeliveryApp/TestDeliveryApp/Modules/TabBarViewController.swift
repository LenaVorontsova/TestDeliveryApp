//
//  TabBarViewController.swift
//  TestDeliveryApp
//
//  Created by Lena Vorontsova on 04.04.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {
    let network: NetworkService
    
    init(network: NetworkService) {
        self.network = network
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBar()
        UITabBar.appearance().backgroundColor = .white
    }
    
    func createTabBar() {
        let menuVC = UINavigationController(rootViewController: MenuBuilder.build(network: network))
        let contactsVC = UINavigationController(rootViewController: ContactsViewController())
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        let cartVC = UINavigationController(rootViewController: CartViewController())
        
        menuVC.title = "Меню"
        contactsVC.title = "Контакты"
        profileVC.title = "Профиль"
        cartVC.title = "Корзина"
        
        self.setViewControllers([menuVC, contactsVC, profileVC, cartVC], animated: false)
        
        guard let items = self.tabBar.items else {
            return
        }
        
        let imagesNames = ["menuIcon", "contactsIcon", "profileIcon", "cartIcon"]
        
        for i in 0..<items.count {
            items[i].image = UIImage(named: imagesNames[i])
        }
    }
}
