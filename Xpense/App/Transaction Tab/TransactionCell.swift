//
//  TransactionCell.swift
//  Xpense
//
//  Created by Nestor Garcia on 24/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import UIKit

/// Respresents a view in the transaction table
final class TransactionCell: UITableViewCell {
    
    @IBOutlet weak var topLeftLabel: UILabel!
    @IBOutlet weak var bottomLeftLabel: UILabel!
    @IBOutlet weak var topRightLabel: UILabel!
    @IBOutlet weak var bottomRightLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        resetValues()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetValues()
    }
    
    func setup(with model: TransactionCellModel) {
        topLeftLabel.text = model.title
        bottomLeftLabel.text = model.date.string()
        topRightLabel.text = "\(model.currency.rawValue) \(model.amount)"
        if model.convertedCurrency != model.currency {
            if let convertedCurrency = model.convertedCurrency,
                let convertedAmount = model.convertedAmount {
                    bottomRightLabel.text = "\(convertedCurrency.rawValue) \(convertedAmount)"
            } else {
                model.fetchConversionIfNeeded { [weak self] (amount, currency) in
                    DispatchQueue.main.async {
                        self?.bottomRightLabel.text = "\(currency ?? "") \(amount ?? "")"
                    }
                }
            }
        }
        topLeftLabel.textColor = model.categoryColor
    }
}

// MARK: - Private

extension TransactionCell {
    
    func resetValues() {
        topLeftLabel.text = nil
        bottomLeftLabel.text = nil
        topRightLabel.text = nil
        bottomRightLabel.text = nil
    }
}
