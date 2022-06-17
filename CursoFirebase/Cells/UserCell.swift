//
//  UserCell.swift
//  CursoFirebase
//
//  Created by UNAM FCA 17 on 17/06/22.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var imgProfileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgProfileImage.layer.cornerRadius = imgProfileImage.frame.size.height / 2
        imgProfileImage.layer.borderWidth = 1
        imgProfileImage.layer.borderColor = UIColor.black.cgColor
        imgProfileImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }

}
