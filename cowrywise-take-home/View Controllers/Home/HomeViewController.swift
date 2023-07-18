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
    @IBOutlet weak var leftCurrencyPickerView: UIStackView!
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
            guard let conversionResult = conversionResult else {
                self.convertButton.configuration?.showsActivityIndicator = false
                self.showUIAlertView(title: "Error!", message: "Could not convert value")
                return
            }
            
            self.secondCurrencyTF.text = String(conversionResult)
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
            self.setupTextFieldAppearance()
        }
        
        present(currencyPickerVC, animated: true)
    }
}

extension HomeViewController {
    private func setup() {
        setupCurrencyPickers()
        setHeaderTextAttributes()
        setupTF()
        setupTextFieldAppearance()
        setupChartView()
        setupScrollView()
        addDismissTextFieldViewTapped()
    }
    
    private func setupScrollView() {
        scrollView.contentInsetAdjustmentBehavior = .never
    }
    
    private func setupChartView() {
        chartView.layer.cornerRadius = 30
        chartView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func addDismissTextFieldViewTapped() {
        //Looks for single or multiple taps.
         let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
        
        firstCurrencyTF.attributedPlaceholder = NSAttributedString(string: "Enter an amount e.g. 1000", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        secondCurrencyTF.attributedPlaceholder = NSAttributedString(string: "Output", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    private func setupTextFieldAppearance() {
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

