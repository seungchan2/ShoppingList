//
//  ShoppingTableViewCell.swift
//  ShoppingList
//
//  Created by 김승찬 on 2021/11/03.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {
    
    
    @IBOutlet var cellBackgroundView: UIView!
    @IBOutlet var checkButton: UIButton!
    
    @IBOutlet var productLabel: UILabel!
    
    @IBOutlet var starButton: UIButton!
    static let identifier = "ShoppingTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackgroundView.backgroundColor = UIColor.systemGray5
        cellBackgroundView?.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
