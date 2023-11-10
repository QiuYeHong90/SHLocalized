//
//  SettingsGJHViewController.swift
//  KBCore_Example
//
//  Created by Ray on 2023/11/10.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import SHLocalized

class SettingsGJHViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = dataArray[indexPath.row]
        SHLocalizedManager.share.currentLanguage = text
        self.tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableView", for: indexPath)
        let text = dataArray[indexPath.row]
        cell.backgroundColor = SHLocalizedManager.share.currentLanguage == text ? .red: .clear
        cell.textLabel?.text = SHLocalizedManager.share.displayNameForLanguage(text)
        return cell
    }
    var dataArray: [String] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        self.dataArray = SHLocalizedManager.share.availableLanguages(true)
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "tableView")
        
        tableView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
