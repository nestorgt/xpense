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
        transactionsVC.title = NSLocalizedString("transaction-tab-title")

        let categoriesVC = CategoryViewController(viewModel:
            CategoryViewModel(categoryService: DI.categoryService)
        )

        viewControllers = [transactionsVC, categoriesVC]
    }
    
    func setupTabBar() {
        tabBar.isTranslucent = false
        tabBar.items?.forEach {
            $0.setTitleTextAttributes([.font : UIFont.boldSystemFont(ofSize: 16)], for: .normal)
            $0.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -16)
        }
    }
}
