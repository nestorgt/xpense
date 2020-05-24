//
//  TransactionsViewModel.swift
//  Xpense
//
//  Created by Nestor Garcia on 23/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

final class TransactionsViewModel {
    
    var screentTitle: String { NSLocalizedString("transaction-tab-title") }
    
    // MARK: - Table
       
       var numberOfSections: Int {
           0
       }
       
       func nameForSection(_ section: Int) -> String {
           "test"
       }
       
       func numberOfRowsInSection(_ section: Int) -> Int {
           0
       }
}


