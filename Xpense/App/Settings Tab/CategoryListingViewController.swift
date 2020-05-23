//
//  CategoryListingViewController.swift
//  Xpense
//
//  Created by Nestor Garcia on 22/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import UIKit

class CategoryListingViewController: UITableViewController {

    static private let categoryCellIdentifier = "categoryCell"
    var viewModel: CategoryTableViewModel
    
    init(viewModel: CategoryTableViewModel) {
        self.viewModel = viewModel
        super.init(style: .grouped)
        title = viewModel.screentTitle
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.categoryCellIdentifier)
        navigationController?.visibleViewController?.title = viewModel.screentTitle
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.categoryCellIdentifier, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = viewModel.name(for: indexPath.row)
        cell.textLabel?.textColor = viewModel.color(for: indexPath.row) ?? .black
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = Alerts.doubleTextField(
            title: viewModel.alertTitle,
            message: viewModel.alertDescription,
            placeholderOne: viewModel.alertNamePlaceholder,
            placeholderTwo: viewModel.alertHexPlaceholder,
            valueOne: viewModel.name(for: indexPath.row),
            valueTwo: viewModel.hexColor(for: indexPath.row)) { [weak self] (name, hex) in
                if self?.viewModel.didEnter(nameString: name, hexString: hex, forIndex: indexPath.row) == false {
                    self?.view.shake()
                }
        }
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.nameForSection(section)
    }
}
