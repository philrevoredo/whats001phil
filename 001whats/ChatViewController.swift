//
//  ChatViewController.swift
//  001whats
//
//  Created by Isa Richter on 11/04/19.
//  Copyright © 2019 Philippe Richter. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import ChameleonFramework

class ChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    var messageArray: [Message] = [Message]()
    @IBOutlet weak var messagetextp: UITextField!
    @IBOutlet weak var sendfirstbutton: UIButton!
    @IBOutlet weak var messagetableview: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
messagetableview.delegate = self
        messagetableview.dataSource = self
        messagetextp.delegate = self
        
        messagetableview.register(UINib(nibName:"MessageCell",bundle:nil), forCellReuseIdentifier: "customMessageCell")
        
        configureTableView()
        retrieveMessages()
        messagetableview.separatorStyle = .none
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell",for: indexPath)as!
        CustomMessageCell
      
        
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUsername.text = messageArray[indexPath.row].sender
        cell.avatarImageView.image = UIImage(named:"tarantino")
        if cell.senderUsername.text == Auth.auth().currentUser?.email as String!{
            cell.avatarImageView.backgroundColor = UIColor.flatSkyBlue()
            cell.messageBackground.backgroundColor = UIColor.flatMint()}
            else { cell.avatarImageView.backgroundColor = UIColor.flatWatermelon()
                cell.messageBackground.backgroundColor = UIColor.flatGray()
            
        }
        
        
      
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
       
    }

    func configureTableView(){messagetableview.rowHeight = UITableView.automaticDimension
        messagetableview.estimatedRowHeight = 120.0
       
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        view.layoutIfNeeded()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    /*
     
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func sendbuttonp(_ sender: Any) {
        
        
        messagetextp.endEditing(true)
        messagetextp.isEnabled =  false
        sendfirstbutton.isEnabled = false
        let messagesDB = Database.database().reference().child("Messages")
        let messageDictionary = ["Sender": Auth.auth().currentUser?.email,"MessageBody":messagetextp.text!]
        messagesDB.childByAutoId().setValue(messageDictionary){(error,reference) in
            if error != nil{
            print(error)}
            else{
        print("message has been saved")
                self.messagetextp.isEnabled = true
                self.sendfirstbutton.isEnabled = true
                self.messagetextp.text = ""
            }}}
    func retrieveMessages(){
        let messageDB = Database.database().reference().child("Messages")
        messageDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as!  Dictionary<String,String>
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            print(sender,text)
            let message = Message()
            message.messageBody = text
            message.sender = sender
            self.messageArray.append(message)
            self.configureTableView()
            self.messagetableview.reloadData()
            
        }
    }
    
    
    @IBAction func Logoutbuttonp(_ sender: Any) {
        do{try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }catch{print("error, prolbem man")}
    }
}


