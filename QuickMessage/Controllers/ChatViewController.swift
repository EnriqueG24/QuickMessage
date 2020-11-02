//
//  ChatViewController.swift
//  QuickMessage
//
//  Created by Enrique Gongora on 10/29/20.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    // MARK: - Properties
    var messages: [Message] = []
    let db = Firestore.firestore()
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    // MARK: - IBActions
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(Constants.FStore.collectionName).addDocument(data: [Constants.FStore.senderField : messageSender, Constants.FStore.bodyField : messageBody, Constants.FStore.dateField : Date().timeIntervalSince1970]) { (error) in
                if error != nil {
                    print(error)
                } else  {
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.appName
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        loadMessages()
    }
    
    // MARK: - Methods
    func loadMessages() {
        // Retrive our collection, order it by the date field in ascending order, and our snapshotListener will listens for changes.
        db.collection(Constants.FStore.collectionName).order(by: Constants.FStore.dateField).addSnapshotListener { (querySnapshot, error) in
            self.messages = []
            if error != nil {
                print(error)
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let sender = data[Constants.FStore.senderField] as? String, let messageBody = data[Constants.FStore.bodyField] as? String {
                            let newMessage = Message(sender: sender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            // This ensures our tableView is updated on the main thread
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body
        
        // This is a message from the current user
        if message.sender == Auth.auth().currentUser?.email {
            // Hide the left image and show the right one, assign it a color to differentiate
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor.purple
            cell.label.textColor = UIColor.white
        } else {
            // otherwise if it's not the current user, hide the right image and show the left one and assign it a different color.
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor.blue
            cell.label.textColor = UIColor.white
        }
        
        return cell
    }
}
