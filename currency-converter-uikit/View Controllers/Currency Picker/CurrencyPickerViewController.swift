//
//  CurrencyPickerViewController.swift
//
//  Created by Ademola Fadumo on 17/07/2023.
//

import UIKit

class CurrencyPickerViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var pickerViewContainer: UIView!
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    
    var selectedCurrencySymbol: Symbols!
    var fetchSymbolsList = [Symbols]()
    var currencyConverterRepository: CurrencyConverterRepository!
    var dismissCompletionHandler: ((Symbols) -> Void)!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let sheet = sheetPresentationController {
            sheet.detents = [
                .custom { context in
                    return self.pickerViewContainer.frame.height
                }
            ]
            sheet.preferredCornerRadius = 30
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchCurrencySymbols()
    }
    
    func fetchCurrencySymbols() {
        self.loadingActivity.startAnimating()
        self.pickerView.isHidden = true
        currencyConverterRepository.getCurrencySymbols { symbols in
            guard !symbols.isEmpty else {
                self.loadingActivity.stopAnimating()
                self.pickerView.isHidden = true
                self.view.setEmptyView(title: "No Data", message: "Could not fetch currency symbols")
                return
            }
            
            self.fetchSymbolsList = symbols
            
            self.loadingActivity.stopAnimating()
            self.pickerView.isHidden = false
            self.pickerView.reloadAllComponents()
        }
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag) {
            if let selectedCurrencySymbol = self.selectedCurrencySymbol {
                self.dismissCompletionHandler(selectedCurrencySymbol)
            } else {
                if let firstSymbol = self.fetchSymbolsList.first {
                    self.dismissCompletionHandler(firstSymbol)
                }
            }
        }
    }
}

extension CurrencyPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fetchSymbolsList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(fetchSymbolsList[row].abbreviation) - \(fetchSymbolsList[row].name)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCurrencySymbol = fetchSymbolsList[row]
    }
}
