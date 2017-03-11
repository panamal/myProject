//
//  ViewController.swift
//  myProject
//
//  Created by student05 on 27.02.17.
//  Copyright © 2017 student05. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func btnExit(_ sender: UIButton) {
        let alertMessage = UIAlertController(title: "Attention!", message: "Do you want to exit the programm?", preferredStyle: UIAlertControllerStyle.alert)
        alertMessage.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        alertMessage.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alertMessage, animated: true, completion: nil)
        
        
    }
    
    @IBOutlet weak var msgAddress: UITextField!
    
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnAlarm: UIButton!
    
    @IBOutlet weak var msgText: UITextView!
    
    @IBOutlet weak var fileName1: UITextField!
    @IBOutlet weak var fileName2: UITextField!
    @IBOutlet weak var fileName3: UITextField!
    
    @IBAction func typeExit(_ sender: UIButton) {
        

    }
    
    
    @IBAction func addFileName(_ sender: UIButton) {
        
        //let dialog = FileManager()
        
        //let diag = UIAlertController()

        
    }
    
    
    
    @IBAction func btnCancelClick(_ sender: UIButton) {
    }
    
    var shadowSwitch = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        msgAddress.layer.borderWidth = 1
        msgAddress.layer.borderColor = UIColor.gray.cgColor
        msgAddress.layer.cornerRadius = 5
        
        msgText.layer.borderWidth = 1
        msgText.layer.borderColor = UIColor.gray.cgColor
        msgText.layer.cornerRadius = 5

        fileName1.layer.borderWidth = 1
        fileName1.layer.borderColor = UIColor.gray.cgColor
        fileName1.layer.cornerRadius = 5
        
        fileName2.layer.borderWidth = 1
        fileName2.layer.borderColor = UIColor.gray.cgColor
        fileName2.layer.cornerRadius = 5
        
        fileName3.layer.borderWidth = 1
        fileName3.layer.borderColor = UIColor.gray.cgColor
        fileName3.layer.cornerRadius = 5
        
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

