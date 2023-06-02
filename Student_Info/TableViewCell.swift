//
//  TableViewCell.swift
//  Student_Info
//
//  Created by ヴィヤヴャハレ・アディティア on 01/06/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var studentContactLabel: UILabel!
    @IBOutlet weak var parentContactLabel: UILabel!
    @IBOutlet weak var urnLabel: UILabel!
    @IBOutlet weak var class_divisionLabel: UILabel!
    @IBOutlet weak var residentialAddressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
