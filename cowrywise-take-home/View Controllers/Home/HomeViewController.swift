//
//  HomeViewController.swift
//  cowrywise-take-home
//
//  Created by Ademola Fadumo on 16/07/2023.
//

import UIKit

enum CurrencyPickers {
    case left
    case right
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var firstCurrencyTF: UITextField!
    @IBOutlet weak var secondCurrencyTF: UITextField!
    @IBOutlet weak var leftCurrencyPickerView: UIView!
    @IBOutlet weak var rightCurrencyPickerView: UIView!
    @IBOutlet weak var leftCurrencyPickerLabel: UILabel!
    @IBOutlet weak var rightCurrencyPickerLabel: UILabel!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var convertButton: UIButton!
    
    var currencyConverterRepository: CurrencyConverterRepository!
    var selectedCurrencyLeftCurrencyPicker = Symbols(name: "", abbreviation: "EUR")
    var selectedCurrencyRightCurrencyPicker = Symbols(name: "", abbreviation: "USD")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        currencyConverterRepository = (UIApplication.shared.delegate as! AppDelegate).repositoryProvider.currencyConverterRepository
        
        setup()
    }
    
    @objc func leftCurrencyPickerTapped() {
        debugPrint("Left currency picker tapped.")
        showCurrencyPicker(currencyPicker: .left)
    }
    
    @objc func rightCurrencyPickerTapped() {
        debugPrint("Right currency picker tapped.")
        showCurrencyPicker(currencyPicker: .right)
    }
    
    @IBAction func convertPressed(_ sender: UIButton?) {
        convertButton.configuration?.showsActivityIndicator = true
        guard let amount = firstCurrencyTF.text, !(firstCurrencyTF.text?.isEmpty ?? false) else {
            self.convertButton.configuration?.showsActivityIndicator = false
            self.showUIAlertView(title: "Error!", message: "Please input a value to be converted")
            return
        }
        
        currencyConverterRepository.convertToCurrency(from: selectedCurrencyLeftCurrencyPicker.abbreviation, to: selectedCurrencyRightCurrencyPicker.abbreviation, amount: Double(amount) ?? 0) { conversionResult in
            
            self.secondCurrencyTF.text = String(conversionResult ?? 0)
            self.convertButton.configuration?.showsActivityIndicator = false
        }
    }
    
    private func showCurrencyPicker(currencyPicker: CurrencyPickers) {
        let currencyPickerVC = storyboard?.instantiateViewController(withIdentifier: "CurrencyPickerViewController") as! CurrencyPickerViewController
        
        currencyPickerVC.currencyConverterRepository = currencyConverterRepository
        currencyPickerVC.dismissCompletionHandler = { selectedSymbol in
            switch currencyPicker {
            case .left:
                self.selectedCurrencyLeftCurrencyPicker = selectedSymbol
                debugPrint("Got here \(selectedSymbol)")
            case .right:
                self.selectedCurrencyRightCurrencyPicker = selectedSymbol
                debugPrint("Got here \(selectedSymbol)")
            }
            
            self.setupCurrencyPickers()
            self.setupTFAppearance()
        }
        
        present(currencyPickerVC, animated: true)
    }
}

extension HomeViewController {
    private func setup() {
        setupCurrencyPickers()
        setHeaderTextAttributes()
        setupTF()
        setupTFAppearance()
        setupChartView()
        setupScrollView()
    }
    
    private func setupScrollView() {
        scrollView.contentInsetAdjustmentBehavior = .never
    }
    
    private func setupChartView() {
        chartView.layer.cornerRadius = 30
        chartView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setupCurrencyPickers() {
        leftCurrencyPickerLabel.text = selectedCurrencyLeftCurrencyPicker.abbreviation
        rightCurrencyPickerLabel.text = selectedCurrencyRightCurrencyPicker.abbreviation
        
        leftCurrencyPickerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(leftCurrencyPickerTapped)))
        rightCurrencyPickerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rightCurrencyPickerTapped)))
        
        leftCurrencyPickerView.layer.cornerRadius = 4
        leftCurrencyPickerView.layer.borderColor = UIColor.gray.cgColor
        leftCurrencyPickerView.layer.borderWidth = 0.5
        
        rightCurrencyPickerView.layer.cornerRadius = 4
        rightCurrencyPickerView.layer.borderColor = UIColor.gray.cgColor
        rightCurrencyPickerView.layer.borderWidth = 0.5
    }
    
    private func setupTF() {
        firstCurrencyTF.delegate = self
        secondCurrencyTF.delegate = self
        
        firstCurrencyTF.layer.borderWidth = 0
        secondCurrencyTF.layer.borderColor = UIColor.clear.cgColor
    }
    
    private func setupTFAppearance() {
        //
        let firstCurrencyTFSuffix = UILabel()
        firstCurrencyTFSuffix.text = selectedCurrencyLeftCurrencyPicker.abbreviation
        firstCurrencyTFSuffix.text?.append("    ")
        firstCurrencyTFSuffix.sizeToFit()
        firstCurrencyTFSuffix.textColor = .lightGray
        
        firstCurrencyTF.rightView = firstCurrencyTFSuffix
        firstCurrencyTF.rightViewMode = .always
        
        //
        let secondCurrencyTFSuffix = UILabel()
        secondCurrencyTFSuffix.text = selectedCurrencyRightCurrencyPicker.abbreviation
        secondCurrencyTFSuffix.text?.append("    ")
        secondCurrencyTFSuffix.sizeToFit()
        secondCurrencyTFSuffix.textColor = .lightGray
        
        secondCurrencyTF.rightView = secondCurrencyTFSuffix
        secondCurrencyTF.rightViewMode = .always
    }
    
    private func setHeaderTextAttributes() {
        let title = "Currency\nConverter."
        
        let dot = "."
        
        let titleRange = title.range(of: title)!
        
        let dotRange = title.range(of: dot)!
        
        let attributedString = NSMutableAttributedString(string: title)
        
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: Colors.primary, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 36, weight: .bold)], range: NSRange(titleRange, in: title))
        
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: Colors.secondary, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 36, weight: UIFont.Weight(600))], range: NSRange(dotRange, in: title))
        
        self.headerLabel.attributedText = attributedString
        self.headerLabel.numberOfLines = 2
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

