//
//  NotesTableViewCell.swift
//  NotesApp
//
//  Created by Thomas.Tay.sg on 15/2/16.
//  Copyright © 2016 Thomas.Tay.sg. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var cellNotesTitle: UILabel!

    
    // MARK: Default Template
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
