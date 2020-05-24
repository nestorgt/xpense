//
//  Alerts.swift
//  Xpense
//
//  Created by Nestor Garcia on 22/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import UIKit

struct Alerts {
    
    /// Custom configurable alert with two textFields and two buttons (Cancel, Save).
    static func doubleTextField(title: String?,
                                message: String?,
                                placeholderOne: String?,
                                placeholderTwo: String?,
                                valueOne: String?,
                                valueTwo: String?,
                                actionSaveTitle: String? = NSLocalizedString("generic-save"),
                                actionCancelTitle: String? = NSLocalizedString("generic-cancel"),
                                completion: @escaping (String?,String?) -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField {
            $0.placeholder = placeholderOne
            $0.text = valueOne
        }
        alertController.addTextField {
            $0.placeholder = placeholderTwo
            $0.text = valueTwo
        }
        if let actionSaveTitle = actionSaveTitle {
            let saveAction = UIAlertAction(title: actionSaveTitle, style: .default) { _ in
                completion(alertController.textFields?.first?.text,
                           alertController.textFields?.last?.text)
            }
            alertController.addAction(saveAction)
        }
        if let actionCancelTitle = actionCancelTitle {
            let cancelAction = UIAlertAction(title: actionCancelTitle, style: .cancel) { _ in
                completion(nil,nil)
            }
            alertController.addAction(cancelAction)
        }
        return alertController
    }
    
    /// Custom alert that displays several options.
    static func actionSheet(title: String?,
                            actions: [(String,String)], // (id, name)
                            handler: @escaping (String) -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        actions.forEach { action in
            let alert = UIAlertAction(title: action.1, style: .default, handler: { alert in
                handler(action.0)
            })
            alertController.addAction(alert)
        }
        return alertController
    }
}
