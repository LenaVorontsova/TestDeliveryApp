//
//  MenuBuilder.swift
//  TestDeliveryApp
//
//  Created by Lena Vorontsova on 04.04.2023.
//

import UIKit

enum MenuBuilder {
    static func build(network: NetworkService) -> (UIViewController & IViewControllers) {
        let presenter = MenuPresenter(network: network)
        let vc = MenuViewController(presenter)
        presenter.controller = vc
        return vc
    }
}
