//
//  SearchResultCell.swift
//  Cook Book
//
//  Created by Justin on 3/19/22.
//

import UIKit

class SearchResultCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
   @IBOutlet weak var recipeTimeLabel: UILabel!
   @IBOutlet weak var recipeImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let bgColor = UserDefaults.standard.bool(forKey: "themeKey")
            if(bgColor){
                backgroundColor = .white
            } else {
                backgroundColor = UIColor.appColor(.dark)
               
            }
    }

   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
 

}
