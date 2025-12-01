//
//  ChatViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/25/25.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var tableViewBackground: UIView!
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    @IBOutlet weak var myTableView: UITableView!
    
    var grad = GradientManager()
    
    var collectionArray = [OnlineUsersItem]()
    var tableArray = [UsersItem]()
    var filteredTableArray = [UsersItem]()   // دي اللي هنعرضها في الجدول
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Shadow
        setupShadow(for: tableViewBackground, cornerRadius: 25)
//        tableViewBackground.layer.cornerRadius = 25
        tableViewBackground.layer.masksToBounds = true

        setupShadow(for: searchView, cornerRadius: 15)
        searchView.clipsToBounds = true
        
        // CollectionView
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        implementUsersCollection()
        myCollectionView.reloadData()
        myCollectionView.backgroundColor = .clear
        
        // TableView
        myTableView.delegate = self
        myTableView.dataSource = self
        implementUsersTable()
        
        // أول مرة: نعرض كل العناصر
        filteredTableArray = tableArray
        myTableView.reloadData()
        
        // Search Bar
        setupSearchBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        grad.applySmoothBlueGradient(
            to: self.view,
            lightRatio: 0.03,   // الفاتح قليل جداً
            midRatio: 0.20,
            darkRatio: 0.80     // الغامق مسيطر
        )
    }
    
    private func setupShadow(for view: UIView, cornerRadius: CGFloat) {
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 6
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: cornerRadius).cgPath
    }
    
    // MARK: - Data
    
    func implementUsersCollection() {
        collectionArray.append(OnlineUsersItem(image: "Doctor"))
        collectionArray.append(OnlineUsersItem(image: "DoctorImage"))
        collectionArray.append(OnlineUsersItem(image: "nurse"))
        collectionArray.append(OnlineUsersItem(image: "DoctorImage"))
    }
    
    func implementUsersTable() {
        tableArray.append(UsersItem(image: "Doctor",
                                    name: "د.محمد مرعي",
                                    lastMessage: "إزيك يا دكتور؟",
                                    time: "10:30 AM",
                                    numberOfNewMessages: 2))
        
        tableArray.append(UsersItem(image: "nurse",
                                    name: "Dr. Sara",
                                    lastMessage: "تمام شكراً 🌸",
                                    time: "09:15 AM",
                                    numberOfNewMessages: 0))
        
        tableArray.append(UsersItem(image: "DoctorImage",
                                    name: "Dr. Ali",
                                    lastMessage: "هنبعتلك التقرير حالاً",
                                    time: "Yesterday",
                                    numberOfNewMessages: 5))
        tableArray.append(UsersItem(image: "Doctor",
                                    name: "د.احمد",
                                    lastMessage: "إزيك يا دكتور؟",
                                    time: "10:30 AM",
                                    numberOfNewMessages: 1))
        
        tableArray.append(UsersItem(image: "nurse",
                                    name: "د.امل",
                                    lastMessage: "تمام شكراً 🌸",
                                    time: "09:15 AM",
                                    numberOfNewMessages: 0))
        
        tableArray.append(UsersItem(image: "DoctorImage",
                                    name: "Dr. khaled",
                                    lastMessage: "هنبعتلك التقرير حالاً",
                                    time: "Yesterday",
                                    numberOfNewMessages: 3))
    }
    
    // MARK: - Search Bar
    
    private func setupSearchBar() {
        let searchVC = SearchWithoutFilterViewController(nibName: "SearchWithoutFilterViewController", bundle: nil)
        addChild(searchVC)
        searchVC.view.frame = searchView.bounds
        searchVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        searchView.addSubview(searchVC.view)
        searchVC.didMove(toParent: self)
        
        // هنا بنربطه بالـ delegate
        searchVC.delegate = self
    }
}

// MARK: - CollectionView

extension ChatViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OnlineUsersCollectionViewCell
        cell.usersImage.image = UIImage(named: collectionArray[indexPath.row].image)
        return cell
    }
}

// MARK: - TableView

extension ChatViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTableArray.count   // نعرض المتفلتر
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UsersTableViewCell
        
        let item = filteredTableArray[indexPath.row]
        
        cell.usersImage.image = UIImage(named: item.image)
        cell.usersName.text = item.name
        cell.lastMessage.text = item.lastMessage
        cell.timeLastMessage.text = item.time
        
        if item.numberOfNewMessages > 0 {
            cell.newMessageView.isHidden = false
            cell.numberOfNewMessage.text = "\(item.numberOfNewMessages)"
        } else {
            cell.newMessageView.isHidden = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Patient", bundle: nil)
        
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "Messages") as? MessagesViewController {
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: false)
        }

       
    }
}

// MARK: - Search Delegate

extension ChatViewController: SearchWithoutFilterDelegate {
    
    func searchTextDidChange(_ text: String) {
        let query = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        if query.isEmpty {
            // لو السيرش فاضي رجّع كل الناس
            filteredTableArray = tableArray
        } else {
            // بحث بالاسم بس دلوقتي
            filteredTableArray = tableArray.filter { item in
                item.name.lowercased().contains(query)
            }
        }
        
        myTableView.reloadData()
    }
}

// MARK: - Models

struct OnlineUsersItem {
    var image: String
}

struct UsersItem {
    var image: String
    var name: String
    var lastMessage: String
    var time: String
    var numberOfNewMessages: Int
}
