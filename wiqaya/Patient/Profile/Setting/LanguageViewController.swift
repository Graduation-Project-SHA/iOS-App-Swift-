//
//  LanguageViewController.swift
//  wiqaya
//
//  Created by AhmadALshafei on 12/8/25.
//

import UIKit

struct LanguageModel {
    var language: String
}

class LanguageViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    // كل اللغات الأصلية
    var allLanguages: [LanguageModel] = []
    // اللغات المعروضة (بعد الفلترة)
    var filteredLanguages: [LanguageModel] = []
    
    // اللغة المختارة حالياً
    var selectedLanguage: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self

        searchView.layer.cornerRadius = 12
        searchView.layer.masksToBounds = true
        searchView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        selectedLanguage = "العربية"

        setupLanguages()
        setupSearchBar()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        // نخلي الكنترولر الحالي هو الـ delegate
        navigationController?.interactivePopGestureRecognizer?.delegate = self

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
        appearance.shadowColor = .clear        // أهم واحدة
        appearance.shadowImage = UIImage()     // بعض الأنظمة تحتاجها
        
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        
        navigationItem.title = "اللغة"

        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    private func setupLanguages() {
        allLanguages = [
            LanguageModel(language: "العربية"),
            LanguageModel(language: "English"),
            LanguageModel(language: "Français"),
            LanguageModel(language: "Deutsch"),
            LanguageModel(language: "Español"),
            LanguageModel(language: "Türkçe"),
            LanguageModel(language: "Italiano")
        ]
        
        filteredLanguages = allLanguages
    }

    private func setupSearchBar() {
        let searchVC = SearchWithoutFilterViewController(nibName: "SearchWithoutFilterViewController", bundle: nil)
        searchVC.delegate = self

        addChild(searchVC)
        searchVC.view.frame = searchView.bounds
        searchVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        searchView.addSubview(searchVC.view)
        searchVC.didMove(toParent: self)
    }
    private func filterLanguages(with text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmed.isEmpty {
            filteredLanguages = allLanguages
        } else {
            filteredLanguages = allLanguages.filter {
                $0.language.lowercased().contains(trimmed.lowercased())
            }
        }
        
        myTableView.reloadData()
    }

}
extension LanguageViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLanguages.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell",
                                                   for: indexPath) as! LanguageTableViewCell
        
        let model = filteredLanguages[indexPath.row]
        let isSelected = (model.language == selectedLanguage)
        
        cell.configure(with: model, isSelected: isSelected)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        let model = filteredLanguages[indexPath.row]
        
        // لو ضغط على نفس اللغة → يلغي الاختيار
        if selectedLanguage == model.language {
            selectedLanguage = nil
        } else {
            selectedLanguage = model.language
        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
extension LanguageViewController: SearchWithoutFilterDelegate {
    func searchTextDidChange(_ text: String) {
        filterLanguages(with: text)
    }
}
