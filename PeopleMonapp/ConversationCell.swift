//
//  ConversationCell.swift
//  PeopleMonapp
//
//  Created by Rigel Preston on 12/20/16.
//  Copyright © 2016 Rigel Preston. All rights reserved.
//

import UIKit

class ConversationCell: UITableViewCell {
    @IBOutlet weak var avatar: CircleImage!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var conversation: Conversation!
    
    func setupCell(conversation: Conversation) {
        self.conversation = conversation
        
        dateLabel.text = Utils.outputDate(dateString: conversation.lastMessage)
        if conversation.senderId == UserStore.shared.user?.id {
            nameLabel.text = conversation.recipientName ?? ""
            
            if let image = Utils.imageFromString(imageString: conversation.recipientAvatar) {
                avatar.image = image
            } else {
                avatar.image = Images.Avatar.image()
            }
            avatar.setupView(size: 60)
        } else {
            nameLabel.text = conversation.senderName ?? ""
            
            if let image = Utils.imageFromString(imageString: conversation.senderAvatar) {
                avatar.image = image
            } else {
                avatar.image = Images.Avatar.image()
            }
            avatar.setupView(size: 60)
        }
    }
}
