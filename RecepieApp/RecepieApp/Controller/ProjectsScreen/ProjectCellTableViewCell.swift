//
//  ProjectCellTableViewCell.swift
//  RecepieApp
//
//  Created by d.chernov on 25/05/2023.
//

import UIKit

class ProjectCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var projectName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
