//
//  ChatViewController.swift
//  QuickMessage
//
//  Created by Enrique Gongora on 10/29/20.
//

import UIKit

class ChatViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    // MARK: - IBActions
    @IBAction func sendPressed(_ sender: UIButton) {
    }
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
