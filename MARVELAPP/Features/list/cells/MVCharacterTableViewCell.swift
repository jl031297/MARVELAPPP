//
//  MVCharacterTableViewCell.swift
//  MARVELAPP
//
//  Created by jorge lengua on 29/7/22.
//

import Foundation
import UIKit

class MVCharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    public  var id = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
