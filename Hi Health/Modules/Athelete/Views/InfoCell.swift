//
//  InfoCell.swift
//  Hi Health
//
//  Created by k2 tam on 14/07/2023.
//

import UIKit

protocol InfoCellDelegate {
    func signOutButtonTapped()
}

class InfoCell: UITableViewCell {

    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
//    var delegate: InfoCellDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImgView.layer.cornerRadius = avatarImgView.frame.size.height / 2
        avatarImgView.clipsToBounds = true
        
    }

//    @IBAction func signOutPressed(_ sender: UIButton) {
//        delegate?.signOutButtonTapped()
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
    
}
