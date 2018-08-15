//
//  ClimateTableViewCell.swift
//  KisanHubAssignment
//
//  Created by Ashwinkumar Mangrulkar on 15/08/18.
//  Copyright © 2018 Ashwinkumar Mangrulkar. All rights reserved.
//

import UIKit

class ClimateTableViewCell: UITableViewCell {

    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var jan: UILabel!
    @IBOutlet weak var feb: UILabel!
    @IBOutlet weak var mar: UILabel!
    @IBOutlet weak var apr: UILabel!
    @IBOutlet weak var may: UILabel!
    @IBOutlet weak var jun: UILabel!
    @IBOutlet weak var jul: UILabel!
    @IBOutlet weak var aug: UILabel!
    @IBOutlet weak var sep: UILabel!
    @IBOutlet weak var oct: UILabel!
    @IBOutlet weak var nov: UILabel!
    @IBOutlet weak var dec: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayData(dto: DTOClimate) {
        self.year.text = dto.year
        self.jan.text = dto.jan
        self.feb.text = dto.feb
        self.mar.text = dto.mar
        self.apr.text = dto.apr
        self.may.text = dto.may
        self.jun.text = dto.jun
        self.jul.text = dto.jul
        self.aug.text = dto.aug
        self.sep.text = dto.sep
        self.oct.text = dto.oct
        self.nov.text = dto.nov
        self.dec.text = dto.dec


    }

}
