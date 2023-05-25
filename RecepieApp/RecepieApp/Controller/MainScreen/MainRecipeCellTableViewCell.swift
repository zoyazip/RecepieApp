//
//  MainRecipeCellTableViewCell.swift
//  RecepieApp
//
//  Created by d.chernov on 24/05/2023.
//

import UIKit

class MainRecipeCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeCaution: UILabel!
    
    @IBOutlet weak var recipeTime: UILabel!
    
    @IBOutlet weak var recipeRating: UILabel!
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var recipeName: UILabel!
    
    @IBOutlet weak var country: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
