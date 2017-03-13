//
//  ViewController.swift
//  myProject
//
//  Created by student05 on 27.02.17.
//  Copyright © 2017 student05. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    @IBAction func btnExit(_ sender: UIBarButtonItem) {
        let alertMessage = UIAlertController(title: "Attention!", message: "Do you want to exit the programm?", preferredStyle: UIAlertControllerStyle.alert)
        let alertActionOk = UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive, handler: {
            (action:UIAlertAction!) -> Void in exit(0)
        })
        alertMessage.addAction(alertActionOk)
        alertMessage.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alertMessage, animated: true, completion: nil)
        
    }

    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var btnFavorites: UIButton!
    @IBOutlet weak var btnAllUser: UIButton!
    @IBOutlet weak var txtMessage: UITextView!
    @IBOutlet weak var txtFileName1: UITextField!
    @IBOutlet weak var txtFileName2: UITextField!
    @IBOutlet weak var txtFileName3: UITextField!
    @IBOutlet weak var btnAddFile1: UIButton!
    @IBOutlet weak var btnAddFile2: UIButton!
    @IBOutlet weak var btnAddFile3: UIButton!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnAlarm: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtAddress.layer.borderWidth = 1
        txtAddress.layer.borderColor = UIColor.gray.cgColor
        txtAddress.layer.cornerRadius = 5
        
        txtMessage.layer.borderWidth = 1
        txtMessage.layer.borderColor = UIColor.gray.cgColor
        txtMessage.layer.cornerRadius = 5
        
        txtFileName1.layer.borderWidth = 1
        txtFileName1.layer.borderColor = UIColor.gray.cgColor
        txtFileName1.layer.cornerRadius = 5
        
        txtFileName2.layer.borderWidth = 1
        txtFileName2.layer.borderColor = UIColor.gray.cgColor
        txtFileName2.layer.cornerRadius = 5
        
        txtFileName3.layer.borderWidth = 1
        txtFileName3.layer.borderColor = UIColor.gray.cgColor
        txtFileName3.layer.cornerRadius = 5
        
        btnSend.layer.cornerRadius = btnSend.bounds.height / 3
        btnSend.layer.borderColor = UIColor.green.cgColor
        btnSend.layer.borderWidth = 2.0
        
        btnCancel.layer.cornerRadius = btnCancel.bounds.height / 3
        btnCancel.layer.borderColor = UIColor.yellow.cgColor
        btnCancel.layer.borderWidth = 2.0
        
        btnAlarm.layer.cornerRadius = btnAlarm.bounds.height / 3
        btnAlarm.layer.borderColor = UIColor.red.cgColor
        btnAlarm.layer.borderWidth = 2.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

