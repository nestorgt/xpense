//
//  TransactionsViewController.swift
//  Xpense
//
//  Created by Nestor Garcia on 23/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import UIKit

class TransactionsViewController: UITableViewController {

    private let segmentedController = UISegmentedControl(items: TransactionsViewModel.ViewMode.allCases.map { $0.title })
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
        setupViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationBar()
        refresh()
    }
    
    // MARK: - User Input
    
    @objc func addTransaction() {
        let vc = AddTransactionViewController(nibName: "AddTransactionViewController", bundle: nil)
        let vm = AddTransactionViewModel()
        vm.didFinishSaving = { [weak self] success in
            guard success else { return }
            self?.refresh()
        }
        vc.viewModel = vm
        navigationController?.present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    @objc func didChangeViewMode(_ segementedControl: UISegmentedControl) {
        guard let viewMode = TransactionsViewModel.ViewMode(rawValue: segementedControl.selectedSegmentIndex) else { return }
        viewModel.viewMode = viewMode
        Log.message("View mode: \(viewModel.viewMode)", level: .info, type: .transaction)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: Self.transactionCellIdentifier, for: indexPath) as? TransactionCell,
            let cellModel = viewModel.transactionCellModel(for: indexPath)
            else {
                Log.message("Can't create trasaction cell", level: .error, type: .transaction)
                return UITableViewCell()
        }
        cell.setup(with: cellModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.nameForSection(section)
    }
}

// MARK: - Private

private extension TransactionsViewController {

    func setupTableView() {
        let xib = UINib(nibName: "TransactionCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: Self.transactionCellIdentifier)
        tableView.allowsSelection = false
    }
    
    func setupNavigationBar() {
        navigationController?.visibleViewController?.navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTransaction))
        segmentedController.selectedSegmentIndex = viewModel.viewMode.rawValue
        segmentedController.addTarget(self, action: #selector(didChangeViewMode(_:)), for: .valueChanged)
        navigationController?.visibleViewController?.navigationItem.titleView = segmentedController
    }
    
    func setupViewModel() {
        viewModel.shouldRefresh = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func refresh() {
        viewModel.refresh()
        tableView.reloadData()
    }
}
