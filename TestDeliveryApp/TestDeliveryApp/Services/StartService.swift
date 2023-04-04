//
//  StartService.swift
//  TestDeliveryApp
//
//  Created by Lena Vorontsova on 04.04.2023.
//

import UIKit

final class StartService {
    var window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
        configureWindow()
    }
    
    func configureWindow() {
        let network = NetworkService()
        if let win = window {
        win.rootViewController = UINavigationController(
            rootViewController: TabBarViewController(network: network))
        win.makeKeyAndVisible()
    }
    }
}
