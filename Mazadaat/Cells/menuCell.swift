//
//  menuCell.swift
//  DSSchool
//
//  Created by mac on 5/9/20.
//  Copyright © 2020 eng.EleyanSaed. All rights reserved.
//

import UIKit

class menuCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var icoImg: UIImageView!
      
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
