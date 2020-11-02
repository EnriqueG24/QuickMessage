//
//  MessageCell.swift
//  QuickMessage
//
//  Created by Enrique Gongora on 10/31/20.
//

import UIKit

class MessageCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // By tapping into the UIView frame.size.height so the corner radius adapts to the height as the view gets taller. 
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
