//
//  optionVC.swift
//  myProject
//
//  Created by student05 on 11.03.17.
//  Copyright © 2017 student05. All rights reserved.
//

import UIKit
import FMDB


class optionVC: UITableViewController {
    
    var varServAddress = ""
    var varUserNick = ""
    var varUserName = ""
    var varUserPhone = ""

    @IBOutlet weak var lblIdentifier: UILabel!
    @IBOutlet weak var txtServer: UITextField!
    @IBOutlet weak var txtUserNick: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtUserPhone: UITextField!
    @IBOutlet weak var imgUserAvatar: UIImageView!
    @IBOutlet weak var btnCheckUser: UIButton!
    @IBOutlet weak var btnServConn: UIButton!
    
    @IBAction func ifServerEdit(_ sender: UITextField) {
        btnServConn.setTitleColor(UIColor.white, for: .normal)
        btnServConn.setTitle("Apply", for: UIControlState.normal)
        btnServConn.tag = 0
        btnCheckUser.setTitleColor(UIColor.white, for: .normal)
        btnCheckUser.setTitle("Check", for: UIControlState.normal)
        btnCheckUser.tag = 0
    }
    
    @IBAction func ifUserEdit(_ sender: UITextField) {
        btnCheckUser.setTitleColor(UIColor.white, for: .normal)
        btnCheckUser.setTitle("Check", for: UIControlState.normal)
        btnCheckUser.tag = 0
    }
    
    @IBAction func btnServConnType(_ sender: UIButton) {
        let servConnect = Int(arc4random() % 2) == 0 ? false : true
        if btnServConn.tag == 0 {
            let serverAddress = txtServer.text ?? ""
            if serverAddress.characters.count > 0 {
                //*******************
                // connect to server
                //*******************
                if servConnect {
                    varServAddress = serverAddress
                    txtServer.isEnabled = false
                    btnServConn.tag = 1
                    btnServConn.setTitleColor(UIColor.green, for: UIControlState.normal)
                    btnServConn.setTitle("Ok!", for: UIControlState.normal)
                } else {
                    btnServConn.tag = 0
                    btnServConn.setTitleColor(UIColor.red, for: .normal)
                    btnServConn.setTitle("No connection!", for: .normal)
                    btnCheckUser.setTitleColor(UIColor.white, for: .normal)
                    btnCheckUser.setTitle("Check", for: UIControlState.normal)
                }
            } else {
                myAlert(myTitle: "Empty value", myMessage: "Please input server address!")
            }
        }
    }
    
    @IBAction func btnCheckUserType(_ sender: UIButton) {
        let userCheck = Int(arc4random() % 2) == 0 ? false : true
        if btnServConn.tag == 1 {
            if btnCheckUser.tag == 0 {
                let userNick = txtUserNick.text ?? ""
                let userName = txtUserName.text ?? ""
                let userPhone = txtUserPhone.text ?? ""
                if userNick.characters.count * userName.characters.count * userPhone.characters.count > 0 {
                    //*********************
                    // check user nickname
                    //*********************
                    if userCheck {
                        varUserNick = userNick
                        varUserName = userName
                        varUserPhone = userPhone
                        btnCheckUser.tag = 1
                        btnCheckUser.setTitleColor(UIColor.red, for: .normal)
                        btnCheckUser.setTitle("Save", for: UIControlState.normal)
                    } else {
                        btnCheckUser.tag = 0
                        btnCheckUser.setTitleColor(UIColor.red, for: .normal)
                        btnCheckUser.setTitle("Select another nickname", for: UIControlState.normal)
                    }
                } else {
                    myAlert(myTitle: "Empty value", myMessage: "The 'User Nickname', 'User Name' and 'User Phone number' fields must be filled in!")
                }
            } else if btnCheckUser.tag == 1 {
                txtUserNick.text = varUserNick
                txtUserName.text = varUserName
                txtUserPhone.text = varUserPhone
                txtUserNick.isEnabled = false
                txtUserName.isEnabled = false
                txtUserPhone.isEnabled = false
                btnCheckUser.tag = 2
                btnCheckUser.setTitleColor(UIColor.green, for: .normal)
                btnCheckUser.setTitle("Ok!", for: .normal)
                
                // search Document directory
                //let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
                //let documentsDirectory = paths[0] as String
                //let filename = documentsDirectory.appending("theFile.txt")
                //var database:OpaquePointer? = nil
                let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let fileURL = documents.appendingPathComponent("option.sqlite") //URLByAppendingPathComponent("test.sqlite")
                
                let database = FMDatabase(path: fileURL.path)
                
                if !(database?.open())! {
                    print("Unable to open database")
                    return
                }
                
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let deviceID = UIDevice.current.identifierForVendor
        lblIdentifier.text = "Your ID: " + deviceID!.uuidString
        
        //self.tableView.headerView(forSection: 1)?.backgroundColor = UIColor.blue
        btnCheckUser.setTitleColor(UIColor.white, for: .normal)
        btnCheckUser.setTitle("Check", for: UIControlState.normal)
        btnServConn.setTitleColor(UIColor.white, for: .normal)
        btnServConn.setTitle("Apply", for: UIControlState.normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func myAlert(myTitle: String, myMessage: String){
        let alertMessage = UIAlertController(title: myTitle, message: myMessage, preferredStyle: UIAlertControllerStyle.alert)
        alertMessage.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertMessage, animated: true, completion: nil)
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
