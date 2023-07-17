//
//  HomeViewController.swift
//  cowrywise-take-home
//
//  Created by Ademola Fadumo on 16/07/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var firstCurrencyTF: UITextField!
    @IBOutlet weak var secondCurrencyTF: UITextField!
    @IBOutlet weak var leftCurrencyPicker: CurrencyPickerView!
    @IBOutlet weak var rightCurrencyPicker: CurrencyPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setup()
    }
    
    @objc func leftCurrencyPickerTapped() {
        debugPrint("Left currency picker tapped.")
        let currencyPickerVC = storyboard?.instantiateViewController(withIdentifier: "CurrencyPickerViewController") as! CurrencyPickerViewController
        present(currencyPickerVC, animated: true)
    }
    
    @objc func rightCurrencyPickerTapped() {
        debugPrint("Right currency picker tapped.")
        let currencyPickerVC = storyboard?.instantiateViewController(withIdentifier: "CurrencyPickerViewController") as! CurrencyPickerViewController
        present(currencyPickerVC, animated: true)
    }
}

extension HomeViewController {
    private func setup() {
        setupCurrencyPickers()
        setHeaderTextAttributes()
        setupTF()
    }
    
    private func setupCurrencyPickers() {
        leftCurrencyPicker.imageView.image = .add
        leftCurrencyPicker.labelView.text = "EUR"
        
        rightCurrencyPicker.imageView.image = .add
        rightCurrencyPicker.labelView.text = "PLN"
        
        leftCurrencyPicker.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(leftCurrencyPickerTapped)))
        rightCurrencyPicker.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rightCurrencyPickerTapped)))
    }
    
    private func setupTF() {
        firstCurrencyTF.delegate = self
        secondCurrencyTF.delegate = self
        
        firstCurrencyTF.layer.borderWidth = 0
        secondCurrencyTF.layer.borderColor = UIColor.clear.cgColor
        
        //
        let firstCurrencyTFSuffix = UILabel()
        firstCurrencyTFSuffix.text = "EUR"
        firstCurrencyTFSuffix.sizeToFit()
        firstCurrencyTFSuffix.textColor = .lightGray
        firstCurrencyTFSuffix.translatesAutoresizingMaskIntoConstraints = false
        
        firstCurrencyTF.rightView = firstCurrencyTFSuffix
        firstCurrencyTF.rightViewMode = .always
        
        //
        let secondCurrencyTFSuffix = UILabel()
        secondCurrencyTFSuffix.text = "PLN"
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
    
}

