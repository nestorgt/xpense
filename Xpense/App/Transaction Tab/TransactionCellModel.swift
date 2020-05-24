//
//  TransactionCellModel.swift
//  Xpense
//
//  Created by Nestor Garcia on 24/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import Foundation

final class TransactionCellModel {
    let id: String
    let title: String
    let date: Date
    let amount: String
    let currency: Currency
    var convertedAmount: String?
    var convertedCurrency: Currency?
    
    var byDay: String { date.string(format: "yyyy-MM-dd") }
    var byMonth: String { date.string(format: "yyyy-MM") }
    
    private let currencyLayerRepository: CurrencyLayerRepositoryProtocol
    private let transactionService: TransactionServiceProtocol
    
    static func make(from transaction: Transaction) -> TransactionCellModel {
        TransactionCellModel(id: transaction.id,
                             title: transaction.title,
                             date: transaction.date,
                             amount: String(format:"%f", transaction.amount),
                             currency: transaction.currency,
                             convertedAmount: transaction.convertedAmount,
                             convertedCurrency: transaction.convertedCurrency)
    }
    
    init(id: String, title: String, date: Date, amount: String, currency: Currency,
         convertedAmount: String?, convertedCurrency: Currency?,
         currencyLayerRepository: CurrencyLayerRepositoryProtocol = DI.currencyLayerRepository,
         transactionService: TransactionServiceProtocol = DI.transactionService) {
        self.id = id
        self.title = title
        self.date = date
        self.amount = amount
        self.currency = currency
        self.convertedAmount = convertedAmount
        self.convertedCurrency = convertedCurrency
        self.currencyLayerRepository = currencyLayerRepository
        self.transactionService = transactionService
    }
    
    func fetchConversionIfNeeded(completion: @escaping (String?, String?) -> Void) { // (Amount, Currency)
        let toCurrency = CurrencyLayerRepository.userCurrency
        guard convertedAmount == nil
            && convertedCurrency == nil
            && toCurrency != currency
            else {
                completion(nil,nil)
                return
        }
        currencyLayerRepository
            .getConversion(fromCurrency: currency,
                           toCurrency: toCurrency,
                           amount: Double(amount) ?? 0,
                           on: date)
            { [weak self] result in
                guard let strongSelf = self else { return }
                if case .success(let response) = result {
                    let convertedAmountString = "\(response.result ?? 0)"
                    completion(convertedAmountString, toCurrency.rawValue)
                    strongSelf.convertedAmount = convertedAmountString
                    strongSelf.convertedCurrency = toCurrency
                    strongSelf.transactionService
                        .updateConversion(amount: convertedAmountString,
                                          currency: toCurrency.rawValue,
                                          on: strongSelf.id)
                }
        }
    }
}
