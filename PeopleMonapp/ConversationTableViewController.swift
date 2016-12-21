//
//  ConversationTableViewController.swift
//  PeopleMonapp
//
//  Created by Rigel Preston on 12/20/16.
//  Copyright © 2016 Rigel Preston. All rights reserved.
//

import UIKit

class ConversationTableViewController: UITableViewController, SegueHandlerType {
    var conversations: [Conversation] = []
    var newUsers: [Person] = []
    var selectedPerson: Person?
    
    enum SegueIdentifier: String {
        case OpenConversation
        case NewConversation
        case SelectUser
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let getConversations = Conversation(pageSize: 100, pageNumber: 0)
        WebServices.shared.getObjects(getConversations) { (objects, error) in
            if let objects = objects {
                self.conversations = objects
                self.tableView.reloadData()
                
                let person = Person()
                WebServices.shared.getObjects(person) { (people, error) in
                    if let people = people {
                        self.newUsers = people.filter({ (person) -> Bool in
                            let matches = self.conversations.filter({ (conversation) -> Bool in
                                return conversation.senderId == person.userId || conversation.recipientId == person.userId
                            })
                            return matches.count == 0
                        })
                    }
                }
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return conversations.count
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ConversationCell.self)) as! ConversationCell
     
     // Configure the cell...
        let conversation = conversations[indexPath.row]
        cell.setupCell(conversation: conversation)
     
     return cell
     }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch  segueIdentifierForSegue(segue: segue) {
        case .OpenConversation:
            let destVC = segue.destination as! ConversationViewController
            let cell = sender as! ConversationCell
            destVC.conversation = cell.conversation
            destVC.senderId = UserStore.shared.user!.id!
            destVC.senderDisplayName = ""
        case .NewConversation:
            let destVC = segue.destination as! ConversationViewController
            let conversation = Conversation()
            conversation.recipientId = selectedPerson?.userId
            conversation.senderId = UserStore.shared.user!.id!
            destVC.conversation = conversation
            destVC.senderId = UserStore.shared.user!.id!
            destVC.senderDisplayName = ""
        case .SelectUser:
            let destVC = segue.destination as! SelectUserViewController
            destVC.people = newUsers
            
        }
    }
    // MARK: - IBActions
    @IBAction func setNewConversationUser(segue: UIStoryboardSegue) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.performSegueWithIdentifier(segueIdentifier: .NewConversation, sender: self)
        }
    }
}

    // MARK: - Extensions
extension ConversationTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return newUsers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return newUsers[row].username
    }
}

