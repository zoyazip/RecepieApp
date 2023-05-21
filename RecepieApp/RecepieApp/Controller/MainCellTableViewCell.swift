//
//  MainCellTableViewCell.swift
//  RecepieApp
//
//  Created by d.chernov on 21/05/2023.
//

import UIKit

class MainCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var recipeName: UILabel!
    
    
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
