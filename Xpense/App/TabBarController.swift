//
//  TabBarController.swift
//  Xpense
//
//  Created by Nestor Garcia on 19/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupTabBar()
    }
}

private extension TabBarController {
    
    func setupViewControllers() {
        let transactionsVC = TransactionListingViewController()
        transactionsVC.title = NSLocalizedString("transaction-listing-tab-title", comment: "")

        let categoriesVC = CategoryListingViewController()
        categoriesVC.title = NSLocalizedString("category-listing-tab-title", comment: "")
        
        let settingsVC = SettingsViewController()
        settingsVC.title = NSLocalizedString("settings-tab-title", comment: "")

        viewControllers = [transactionsVC, categoriesVC, settingsVC]
    }
    
    func setupTabBar() {
        tabBar.isTranslucent = false
        tabBar.items?.forEach {
            $0.setTitleTextAttributes([.font : UIFont.boldSystemFont(ofSize: 16)], for: .normal)
            $0.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -16)
        }
    }
}
