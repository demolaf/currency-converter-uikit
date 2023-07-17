//
//  CurrencyPickerViewController.swift
//  cowrywise-take-home
//
//  Created by Ademola Fadumo on 17/07/2023.
//

import UIKit

class CurrencyPickerViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var pickerViewContainer: UIView!

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
}

extension CurrencyPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
}
