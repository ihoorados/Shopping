//
//  ListTableViewCell.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 19/5/2022.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    var viewModel: ListTableViewModel?{

        didSet{

            self.updateUI()
        }
    }


    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var baseView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // Update UI
    fileprivate func updateUI(){

        self.titleLabel.text = viewModel?.title
    }
    
}
