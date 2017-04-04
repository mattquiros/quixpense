//
//  _EFEParameterCell.swift
//  Spare
//
//  Created by Matt Quiros on 28/03/2017.
//  Copyright © 2017 Matt Quiros. All rights reserved.
//

import UIKit

class _EFEParameterCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var disclosureIndicatorImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.nameLabel.font = Global.theme.font(for: .regularText)
        self.nameLabel.textColor = Global.theme.color(for: .cellMainText)
        
        self.valueLabel.font = Global.theme.font(for: .cellSecondaryText)
        self.valueLabel.textColor = Global.theme.color(for: .cellSecondaryText)
        
        self.disclosureIndicatorImageView.image = UIImage.templateNamed("cellAccessoryDisclosureIndicator")
        self.disclosureIndicatorImageView.tintColor = Global.theme.color(for: .cellAccessoryDisclosureIndicator)
    }
    
}
