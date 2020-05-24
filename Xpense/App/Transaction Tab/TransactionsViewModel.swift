//
//  TransactionsViewModel.swift
//  Xpense
//
//  Created by Nestor Garcia on 23/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import UIKit

final class TransactionsViewModel {
    
    var transactionCellModels: [TransactionCellModel] = []
    var transactionCellModelsByDay: [String: [TransactionCellModel]] = [:]
    var transactionCellModelsByDayKeysSorted: [String] {
        (transactionCellModelsByDay.keys.map { $0 }).sorted(by: { $0 > $1 })
    }
    var transactionCellModelsByMonth: [String: [TransactionCellModel]] = [:]
    var transactionCellModelsByMonthKeysSorted: [String] {
        transactionCellModelsByMonth.keys.map { $0 }.sorted(by: { $0 > $1 })
    }
    var screentTitle: String { NSLocalizedString("transaction-tab-title") }
    
    var shouldRefresh: (() -> Void)?
    var viewMode: ViewMode = .byDay {
        didSet { refresh() }
    }
    
    private let transactionService: TransactionServiceProtocol
    private var transactions: [Transaction] = []
    
    init(transactionService: TransactionServiceProtocol = DI.transactionService) {
        self.transactionService = transactionService
    }
    
    func refresh() {
        transactions = transactionService.fetchTransactions()
        transactionCellModels = transactions.map { TransactionCellModel.make(from: $0) }
        transactionCellModelsByDay = [:]
        transactionCellModelsByMonth = [:]
        transactionCellModels.forEach { model in
            var newByDay = transactionCellModelsByDay[model.byDay] ?? []
            newByDay.append(model)
            transactionCellModelsByDay[model.byDay] = newByDay
            var newByMonth = transactionCellModelsByMonth[model.byMonth] ?? []
            newByMonth.append(model)
            transactionCellModelsByMonth[model.byMonth] = newByMonth
        }
        Log.message("Transactions byDay \(transactionCellModelsByDay)", level: .debug, type: .transaction)
        Log.message("Transactions byMonth \(transactionCellModelsByMonth)", level: .debug, type: .transaction)
        shouldRefresh?()
    }
    
    // MARK: - Table
    
    var numberOfSections: Int {
        switch viewMode {
        case .byDay:
            return transactionCellModelsByDay.keys.count
        case .byMonth:
            return transactionCellModelsByMonth.keys.count
        }
    }
    
    func nameForSection(_ section: Int) -> String {
        switch viewMode {
        case .byDay:
            let keys = transactionCellModelsByDayKeysSorted
            guard keys.indices.contains(section) else { return "" }
            return keys[section]
        case .byMonth:
            let keys = transactionCellModelsByMonthKeysSorted
            guard keys.indices.contains(section) else { return "" }
            return keys.map { $0 }[section]
        }
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        switch viewMode {
        case .byDay:
            let keys = transactionCellModelsByDayKeysSorted
            guard keys.indices.contains(section) else { return 0 }
            let key = keys[section]
            return transactionCellModelsByDay[key]?.count ?? 0
        case .byMonth:
            let keys = transactionCellModelsByMonthKeysSorted
            guard keys.indices.contains(section) else { return 0 }
            let key = keys[section]
            return transactionCellModelsByMonth[key]?.count ?? 0
        }
    }
    
    func transactionCellModel(for indexPath: IndexPath) -> TransactionCellModel? {
        switch viewMode {
        case .byDay:
            let keys = transactionCellModelsByDayKeysSorted
            guard keys.indices.contains(indexPath.section) else { return nil }
            let key = keys[indexPath.section]
            let values = transactionCellModelsByDay[key]
            guard values?.indices.contains(indexPath.row) == true else { return nil }
            return values?[indexPath.row]
        case .byMonth:
            let keys = transactionCellModelsByMonthKeysSorted
            guard keys.indices.contains(indexPath.section) else { return nil }
            let key = keys[indexPath.section]
            let values = transactionCellModelsByMonth[key]
            guard values?.indices.contains(indexPath.row) == true else { return nil }
            return values?[indexPath.row]
        }
    }
}

// MARK: - Enums

extension TransactionsViewModel {
    
    /// Represents the view-mode that is present.
    enum ViewMode: Int, CaseIterable {
        case byDay
        case byMonth
        
        var title: String {
            switch self {
            case .byDay:
                return NSLocalizedString("transaction-list-by-day")
            case .byMonth:
                return NSLocalizedString("transaction-list-by-month")
            }
        }
    }
}


