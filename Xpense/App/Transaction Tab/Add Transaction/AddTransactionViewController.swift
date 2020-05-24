//
//  AddTransactionViewController.swift
//  Xpense
//
//  Created by Nestor Garcia on 23/05/2020.
//  Copyright © 2020 nestor. All rights reserved.
//

import UIKit

final class AddTransactionViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var currencyButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var viewModel: AddTransactionViewModel?
    
    private lazy var saveButton = {
        UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didPressSaveButton))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupInputs()
        setupViewModel()
        setupDismissKeyboard()
    }
    
    // MARK: - User Input
    
    @objc func didPressCurrencyButton() {
        dismissKeyboard()
        guard let viewModel = viewModel else { return }
        let alert = Alerts.actionSheet(title: viewModel.currencyPlaceholder,
                                       actions: viewModel.currenciesData) { [weak self] rawValue in
                                        self?.viewModel?.didSelectCurrency(rawValue)
        }
        present(alert, animated: true, completion: nil)
    }
    
    @objc func didPressCategoryButton() {
        dismissKeyboard()
        guard let viewModel = viewModel else { return }
        let alert = Alerts.actionSheet(title: viewModel.categoryPlaceholder,
                                       actions: viewModel.categoriesData) { [weak self] id in
                                        self?.viewModel?.didSelectCategory(id)
        }
        present(alert, animated: true, completion: nil)
    }
    
    @objc func didPressSaveButton() {
        dismissKeyboard()
        viewModel?.save()
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Delegates

extension AddTransactionViewController {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == titleTextField {
            viewModel?.selectedTitle = textField.text
        } else if textField == amountTextField {
            viewModel?.selectedAmount = Double(textField.text ?? "")
        }
    }
    
    @objc func datePickerdDidChange(_ datePicker: UIDatePicker) {
        viewModel?.selectedDate = datePicker.date
    }
}

// MARK: - Private

private extension AddTransactionViewController {
    
    func setupNavigationBar() {
        guard let viewModel = viewModel else { return }
        title = viewModel.screentTitle
        navigationItem.rightBarButtonItem = saveButton
    }
    
    func setupInputs() {
        titleTextField.keyboardType = .default
        titleTextField.autocapitalizationType = .none
        titleTextField.autocorrectionType = .no
        titleTextField.placeholder = viewModel?.titlePlaceholder
        titleTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        amountTextField.keyboardType = .decimalPad
        amountTextField.placeholder = viewModel?.amountPlaceholder
        amountTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        datePicker.datePickerMode = .date
        datePicker.date = Date()
        datePicker.addTarget(self, action: #selector(datePickerdDidChange(_:)), for: .valueChanged)
        datePicker.addTarget(self, action: #selector(dismissKeyboard), for: .allEvents)
        updateValues()
        currencyButton.addTarget(self, action: #selector(didPressCurrencyButton), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(didPressCategoryButton), for: .touchUpInside)
    }
    
    func updateValues() {
        guard let viewModel = viewModel else { return }
        currencyButton.setTitle(viewModel.currencyPlaceholder, for: .normal)
        categoryButton.setTitle(viewModel.categoryPlaceholder, for: .normal)
        saveButton.isEnabled = viewModel.canSave
    }
    
    func setupViewModel() {
        viewModel?.shouldRefresh = { [weak self] in
            self?.updateValues()
        }
    }
    
    func setupDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
