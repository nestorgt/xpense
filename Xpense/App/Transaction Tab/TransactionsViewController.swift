//
//  TransactionsViewController.swift
//  Xpense
//
//  Created by Nestor Garcia on 23/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import UIKit

class TransactionsViewController: UITableViewController {

    static private let transactionCellIdentifier = "transactionCell"
    var viewModel: TransactionsViewModel
    
    init(viewModel: TransactionsViewModel) {
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
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationBar()
//        refresh()
    }
    
    @objc func addTransaction() {
        let vc = AddTransactionViewController(nibName: "AddTransactionViewController", bundle: nil)
        vc.viewModel = AddTransactionViewModel()
        navigationController?.present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.transactionCellIdentifier, for: indexPath)
//        cell.textLabel?.text = viewModel.name(for: indexPath.row)
//        cell.textLabel?.textColor = viewModel.color(for: indexPath.row) ?? .black
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.nameForSection(section)
    }
}

// MARK: - Private

private extension TransactionsViewController {

    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.transactionCellIdentifier)
    }
    
    func setupNavigationBar() {
        navigationController?.visibleViewController?.title = viewModel.screentTitle
        navigationController?.visibleViewController?.navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTransaction))
    }
}
