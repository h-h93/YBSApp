//
//  YBSTitleLabel.swift
//  YBSApp
//
//  Created by hanif hussain on 10/05/2024.
//

import UIKit

class YBSTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.preferredFont(forTextStyle: .title2)
        textColor = .label
        adjustsFontSizeToFitWidth = true
        adjustsFontForContentSizeCategory = true
        minimumScaleFactor = 0.75
        numberOfLines = 2
        lineBreakMode = .byTruncatingTail
        isUserInteractionEnabled = true
    }
}
