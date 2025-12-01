//
//  MessagesViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/25/25.
//

import UIKit
import IQKeyboardManagerSwift

class MessagesViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var txtMsg: UITextField!
    @IBOutlet weak var sendMsg: UIButton!
    
    // نفس نوع الـ array اللي في CallConfirmViewController
    var messages: [ChatRow] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        IQKeyboardManager.shared.disabledDistanceHandlingClasses = [MessagesViewController.self]

        // UI مبدئي
//        sendMsg.alpha = 0.5
//        sendMsg.isEnabled = false
        
        myTableView.delegate = self
        myTableView.dataSource = self
        txtMsg.delegate = self
        
        myTableView.layer.cornerRadius = 15
        myTableView.layer.masksToBounds = true
        
        // تسجيل نفس الـ cells اللي هناك
        myTableView.register(
            UINib(nibName: "MessageCellTableViewCell", bundle: nil),
            forCellReuseIdentifier: "MessageCell"
        )
        
        myTableView.register(
            UINib(nibName: "MyMessageCellTableViewCell", bundle: nil),
            forCellReuseIdentifier: "MyMessageCell"
        )
        
        setupDummyData()
    }
    
    private func setupDummyData() {
        // نفس فكرة الداتا التجريبية
        let other1 = message(
            image: UIImage(named: "Doctor") ?? UIImage(),
            sender: "الطبيب",
            body: "اهلا",
            date: Date()
        )
        let other2 = message(
            image: UIImage(named: "Doctor") ?? UIImage(),
            sender: "الطبيب",
            body: "مرحباً، دي شاشة الشات الجديدارتاح شوية الأول، متضغطش على جسمك زيادة. عشان لو فضلت تِجهد نفسك، حالتك هتسوء.",
            date: Date()
        )
        let other3 = message(
            image: UIImage(named: "Doctor") ?? UIImage(),
            sender: "الطبيب",
            body: "مرحباً، دي شاشة الشات الجديدارتاح شوية الأول، متضغطش على جسمك زيادة. عشان لو فضلت تِجهد نفسك، حالتك هتسوء.",
            date: Date()
        )
        let other4 = message(
            image: UIImage(named: "Doctor") ?? UIImage(),
            sender: "الطبيب",
            body: "مرحباً، دي شاشة الشات الجديدارتاح شوية الأول، متضغطش على جسمك زيادة. عشان لو فضلت تِجهد نفسك، حالتك هتسوء.",
            date: Date()
        )
        let other5 = message(
            image: UIImage(named: "Doctor") ?? UIImage(),
            sender: "الطبيب",
            body: "مرحباً، دي شاشة الشات الجديدارتاح شوية الأول، متضغطش على جسمك زيادة. عشان لو فضلت تِجهد نفسك، حالتك هتسوء.",
            date: Date()
        )
        
        let me1 = Mymessage(
            body: "تمام دكتور… بس بصراحة حاسس إني مُجهَد شوية. هحاول أرتاح وأخفّف الحركة، عشان ما تتدهورش حالتي أكتر. شكراً إنك متابعني وبتطمنّي.",
            date: Date(),
            seen: true
        )
        
        messages = [
            .other(other1),.other(other2),.other(other3),.other(other4),.other(other5),
            .me(me1)
        ]
        
        myTableView.reloadData()
    }
    
    @IBAction func sendMsgTapped(_ sender: UIButton) {
        guard let text = txtMsg.text,
              !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        let newMyMessage = Mymessage(body: text, date: Date(), seen: false)
        messages.append(.me(newMyMessage))
        
        txtMsg.text = ""
//        sendMsg.isEnabled = false
//        sendMsg.alpha = 0.5
        
        myTableView.reloadData()
        
        // Scroll لآخر رسالة
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        myTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    @IBAction func backbutton(_ sender: Any) {
        dismiss(animated: true)

    }

}

// MARK: - TableView

extension MessagesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = messages[indexPath.row]
        
        switch row {
        case .other(let msg):
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCellTableViewCell
            
            cell.imageSender.image = msg.image
            cell.lblMsg.text = msg.body
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            cell.timeSend.text = formatter.string(from: msg.date)
            
            cell.selectionStyle = .none
            return cell
            
        case .me(let myMsg):
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyMessageCell", for: indexPath) as! MyMessageCellTableViewCell
            
            cell.lblmsg.text = myMsg.body
            
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            cell.sendTime.text = formatter.string(from: myMsg.date)
            
            cell.seenImage.isHidden = !myMsg.seen
            
            cell.selectionStyle = .none
            return cell
        }
    }
}

// MARK: - TextField

extension MessagesViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = txtMsg.text,
              !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        let newMyMessage = Mymessage(body: text, date: Date(), seen: false)
        messages.append(.me(newMyMessage))
        
        txtMsg.text = ""
//        sendMsg.isEnabled = false
//        sendMsg.alpha = 0.5
        
        myTableView.reloadData()
        
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        myTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
        return true
    }
}
