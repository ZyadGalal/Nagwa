//
//  FileTableViewCell.swift
//  NagwaTask
//
//  Created by Zyad Galal on 27/03/2022.
//

import UIKit

class FileTableViewCell: UITableViewCell {

    
    @IBOutlet weak var audioDurationLabel: UILabel!
    @IBOutlet weak var fileNameLabel: UILabel!
    @IBOutlet weak var fileImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
