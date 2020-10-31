//
//  Constants.swift
//  QuickMessage
//
//  Created by Enrique Gongora on 10/30/20.
//

import Foundation

struct Constants {
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    static let cellIdentifier = "ChatCell"
    static let cellNibName = "MessageCell"
    static let appName = "⚡️QuickMessage"
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
