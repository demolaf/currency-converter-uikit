//
//  CurrencyPickerView.swift
//
//  Created by Ademola Fadumo on 16/07/2023.
//

import UIKit

class CurrencyPickerView: UIView {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var dropdown: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubViews()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        self.initSubViews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 4
        
        self.labelView.textColor = .gray
    }
    
    private func initSubViews() {
        let nib = UINib(nibName: "CurrencyPickerView", bundle: Bundle.main)
        nib.instantiate(withOwner: self)
        addSubview(self.view)
    }

}
