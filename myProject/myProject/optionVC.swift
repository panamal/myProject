//
//  optionVC.swift
//  myProject
//
//  Created by student05 on 11.03.17.
//  Copyright © 2017 student05. All rights reserved.
//

import UIKit

class optionVC: UITableViewController {

    @IBOutlet weak var txtServer: UITextField!
    @IBOutlet weak var txtUserNick: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtUserPhone: UITextField!
    @IBOutlet weak var imgUserAvatar: UIImageView!
    @IBOutlet weak var btnCheckUser: UIButton!
    @IBOutlet weak var btnServConn: UIButton!
    
    @IBAction func ifServerEdit(_ sender: UITextField) {
        btnServConn.setTitleColor(UIColor.blue, for: .normal)
        btnServConn.setTitle("Apply", for: UIControlState.normal)
        btnServConn.tag = 0
        btnCheckUser.setTitleColor(UIColor.blue, for: .normal)
        btnCheckUser.setTitle("Check", for: UIControlState.normal)
        btnCheckUser.tag = 0    }
    
    @IBAction func ifUserEdit(_ sender: UITextField) {
        btnCheckUser.setTitleColor(UIColor.blue, for: .normal)
        btnCheckUser.setTitle("Check", for: UIControlState.normal)
        btnCheckUser.tag = 0
    }
    
    @IBAction func btnServConnType(_ sender: UIButton) {
        //********************
        //connection to server
        //********************
        if btnServConn.tag == 0 {
            btnServConn.tag = 1
            btnServConn.setTitleColor(UIColor.green, for: .normal)
            btnServConn.setTitle("Ok!", for: .normal)
        }
    }
    
    @IBAction func btnCheckUserType(_ sender: UIButton) {
        //********************
        //connection to server and check user nickname
        //********************
        if btnServConn.tag == 1 {
            if btnCheckUser.tag == 0 {
                btnCheckUser.tag = 1
                btnCheckUser.setTitleColor(UIColor.red, for: .normal)
                btnCheckUser.setTitle("Save", for: UIControlState.normal)
            } else if btnCheckUser.tag == 1 {
                btnCheckUser.tag = 2
                btnCheckUser.setTitleColor(UIColor.green, for: .normal)
                btnCheckUser.setTitle("Ok!", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnCheckUser.setTitleColor(UIColor.blue, for: .normal)
        btnCheckUser.setTitle("Check", for: UIControlState.normal)
        btnServConn.setTitleColor(UIColor.blue, for: .normal)
        btnServConn.setTitle("Apply", for: UIControlState.normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
