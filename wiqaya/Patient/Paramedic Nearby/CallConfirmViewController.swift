import UIKit


class CallConfirmViewController: UIViewController {
    
    @IBOutlet weak var counterView: UIView!
    @IBOutlet weak var counter: UILabel!
    @IBOutlet weak var lblCounter: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    
    @IBOutlet weak var progressDoneView: UIView!
    
    @IBOutlet weak var worningImage: UIImageView!
    
    
    
    @IBOutlet weak var importantInformationView: UIView!
    
    
    @IBOutlet weak var importantInformationHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var importantInfo2: UIView!
    
    @IBOutlet weak var mainChatView: UIView!
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var msgView: UIView!
    @IBOutlet weak var txtMsg: UITextField!
    @IBOutlet weak var sendMsg: UIButton!
    @IBOutlet weak var sendPhoto: UIButton!
    
    @IBOutlet weak var allViewHeight: NSLayoutConstraint!
    
    // MARK: - Timer
    var timer: Timer?
    
    /// إجمالي الوقت بالثواني (مثلاً 60 ثانية أو 120 = دقيقتين)
    var totalSeconds: Int = 60
    
    /// كم ثانية عدّت
    var elapsedSeconds: Int = 0

    // بدال array و array2 نخلي مصفوفة واحدة فيها كل الرسائل
    var messages: [ChatRow] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendMsg.alpha = 0.5
        allViewHeight.constant = 1400

        progressDoneView.isHidden = true
        
        importantInfo2.isHidden = true
    
        myTableView.delegate = self
        myTableView.dataSource = self
        txtMsg.delegate = self
        
        msgView.layer.cornerRadius = 10
        msgView.layer.masksToBounds = true
        msgView.layer.borderWidth = 1
        msgView.layer.borderColor = UIColor(hex: "BEDBFF").cgColor
        
        importantInformationView.layer.cornerRadius = 15
        importantInformationView.layer.masksToBounds = true
        importantInformationView.layer.borderWidth = 1
        importantInformationView.layer.borderColor = UIColor(hex: "BEDBFF").cgColor
        

        
        importantInfo2.layer.cornerRadius = 15
        importantInfo2.layer.masksToBounds = true
        importantInfo2.layer.borderWidth = 1
        importantInfo2.layer.borderColor = UIColor(hex: "BEDBFF").cgColor
        
        counterView.layer.cornerRadius = 15
        counterView.layer.masksToBounds = true
        counterView.layer.borderWidth = 1
        counterView.layer.borderColor = UIColor(hex: "BEDBFF").cgColor
        
        mainChatView.layer.cornerRadius = 15
        mainChatView.layer.masksToBounds = true
        mainChatView.layer.borderWidth = 1
        mainChatView.layer.borderColor = UIColor(hex: "E5E5E5").cgColor
        
        myTableView.layer.cornerRadius = 15
        myTableView.layer.masksToBounds = true


        myTableView.register(
            UINib(nibName: "MessageCellTableViewCell", bundle: nil),
            forCellReuseIdentifier: "MessageCell"
        )
        
        myTableView.register(
            UINib(nibName: "MyMessageCellTableViewCell", bundle: nil),
            forCellReuseIdentifier: "MyMessageCell"
        )
        
        
        setupDummyData()
        
        // إعداد مبدئي للـ progress والعداد
        progress.progress = 0
        elapsedSeconds = 0
        updateCounterUI()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        worningImage.layer.cornerRadius = worningImage.bounds.width / 2
        worningImage.clipsToBounds = true
    }

    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer()
    }
    
    // تشغيل التايمر
    func startTimer() {
        // نتأكد ما فيه تايمر قديم
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(timerFired),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    // إيقاف التايمر (لو احتجته لما تنتهي المكالمة)
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        
        progressDoneView.isHidden = false
        counterView.isHidden = true
        
        importantInfo2.isHidden = false
        
        importantInformationHeight.constant = 25
        allViewHeight.constant = 1500
        print("Timer Ended")
    }
    
    @objc func timerFired() {
        // نزيد الثواني اللي مرّت
        elapsedSeconds += 1
        
        // لو عدّينا الوقت الكلي نوقف
        if elapsedSeconds >= totalSeconds {
            elapsedSeconds = totalSeconds
            stopTimer()
        }
        
        updateCounterUI()
    }
    func updateCounterUI() {
        // ممكن تختار: تحسب اللي مر أو اللي باقي
        let remaining = totalSeconds - elapsedSeconds
        
        // لو تبي تعرض الوقت اللي "باقي":
        // counter.text = "\(remaining)"
        
        // لو تبي تعرضه كـ mm:ss
        let minutes = remaining / 60
        let seconds = remaining % 60
        
        if minutes > 0 {
            // مثال: 1:05
            counter.text = String(format: "%d:%02d", minutes, seconds)
            lblCounter.text = "دقيقة"
        } else {
            // أقل من دقيقة
            counter.text = "\(seconds)"
            lblCounter.text = "ثانية"
        }
        
        // تحديث الـ progress (من 0 إلى 1)
        let progressValue = Float(elapsedSeconds) / Float(totalSeconds)
        progress.setProgress(progressValue, animated: true)
    }

    private func setupDummyData() {
        // رسائل تجريبية عشان تشوف الشكل
        let other1 = message(
            image: UIImage(named: "Doctor") ?? UIImage(),
            sender: "الطبيب",
            body: "مرحباً، أنا متصل معك الآن. كيف تشعر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟ر؟",
            date: Date()
        )
        
        let me1 = Mymessage(
            body: "حسّيت بألم قبل شوي.",
            date: Date(),
            seen: true
        )
        
        let other2 = message(
            image: UIImage(named: "Doctor") ?? UIImage(),
            sender: "الطبيب",
            body: "طيب وصف لي الألم بالضبط.",
            date: Date()
        )
        
        messages = [
            .other(other1),
            .me(me1),
            .other(other2)
        ]
    }
    
    @IBAction func sendMsgTapped(_ sender: UIButton) {
        guard let text = txtMsg.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        let newMyMessage = Mymessage(body: text, date: Date(), seen: false)
        messages.append(.me(newMyMessage))
        
        txtMsg.text = ""
        
        myTableView.reloadData()
        
        // Scroll لآخر رسالة
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        myTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    @IBAction func sendPhotoTapped(_ sender: UIButton) {
        // هنا بعدين تفتح الـ image picker أو أي منطق تبيه
        print("Send photo tapped")
    }
}

extension CallConfirmViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = messages[indexPath.row]
        
        switch row {
        case .other(let msg):
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCellTableViewCell
            
            
            cell.imageSender.image = UIImage(named: "Doctor")
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
extension CallConfirmViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = (textField.text ?? "") as NSString
        let updated = currentText.replacingCharacters(in: range, with: string)
        
        let hasText = !updated.trimmingCharacters(in: .whitespaces).isEmpty
        
        sendMsg.isEnabled = hasText
        sendMsg.alpha = hasText ? 1.0 : 0.5
        
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = txtMsg.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        let newMyMessage = Mymessage(body: text, date: Date(), seen: false)
        messages.append(.me(newMyMessage))
        
        txtMsg.text = ""
        
        myTableView.reloadData()
        
        // Scroll لآخر رسالة
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        myTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        return true
    }
}



struct message {
    var image: UIImage?
    var sender: String
    var body: String
    var date: Date
}

struct Mymessage {
    var body: String
    var date: Date
    var seen: Bool
}

enum ChatRow {
    case me(Mymessage)
    case other(message)
}
