//
//  ViewController.swift
//  MyFirst
//
//  Created by USER1 on 2020/05/05.
//  Copyright © 2020 Swift-Beginners. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //（１）ラベルに文字を入れる
        outputLabel.text = "Hello Swift!"
        
    }

    @IBOutlet weak var outputLabel: UILabel!
    
    
}

