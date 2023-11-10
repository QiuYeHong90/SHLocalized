//
//  ViewController.swift
//  SHLocalized
//
//  Created by YeQiu on 11/10/2023.
//  Copyright (c) 2023 YeQiu. All rights reserved.
//


import SHLocalized
import UIKit

public func NSLocalizedString(_ key: String, tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "", comment: String) -> String {
    SHLocalizedManager.NSLocalizedString(key, tableName: tableName, bundle: bundle, value: value, comment: comment)
}


class ViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name( SHLocalizedManager.LCLLanguageChangeNotification), object: nil)
        setText()
    }
    @objc func setText(){
        
        self.textLabel.text = SHLocalizedManager.NSLocalizedString("fff", comment: "test")
        self.title = NSLocalizedString("I am chinese", comment: "test")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

