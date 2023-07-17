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
    
    var currencyConverterRepository: CurrencyConverterRepository!
    var selectedCurrencyLeftCurrencyPicker: Symbols!
    var selectedCurrencyRightCurrencyPicker: Symbols!
    
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
        guard let amount = firstCurrencyTF.text else {
            return
        }
        currencyConverterRepository.convertToCurrency(from: selectedCurrencyLeftCurrencyPicker.abbreviation, to: selectedCurrencyRightCurrencyPicker.abbreviation, amount: Double(amount) ?? 0) { conversionResult in
            
            let prefix = UILabel()
            prefix.text = String(conversionResult!)
            prefix.sizeToFit()
            prefix.textColor = .black
            
            self.secondCurrencyTF.leftView = prefix
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
        if let selectedCurrencyLeftCurrencyPicker = selectedCurrencyLeftCurrencyPicker {
            leftCurrencyPickerLabel.text = selectedCurrencyLeftCurrencyPicker.abbreviation
        } else {
            leftCurrencyPickerLabel.text = "EUR"
        }
        
        if let selectedCurrencyRightCurrencyPicker = selectedCurrencyRightCurrencyPicker {
            rightCurrencyPickerLabel.text = selectedCurrencyRightCurrencyPicker.abbreviation
        } else {
            rightCurrencyPickerLabel.text = "USD"
        }
        
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
        
        setupTFAppearance()
    }
    
    private func setupTFAppearance() {
        //
        let firstCurrencyTFSuffix = UILabel()
        firstCurrencyTFSuffix.text = selectedCurrencyLeftCurrencyPicker?.abbreviation ?? "EUR"
        firstCurrencyTFSuffix.text?.append("    ")
        firstCurrencyTFSuffix.sizeToFit()
        firstCurrencyTFSuffix.textColor = .lightGray
        
        firstCurrencyTF.rightView = firstCurrencyTFSuffix
        firstCurrencyTF.rightViewMode = .always
        
        //
        let secondCurrencyTFSuffix = UILabel()
        secondCurrencyTFSuffix.text = selectedCurrencyRightCurrencyPicker?.abbreviation ?? "USD"
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

