//
//  ViewController.swift
//  myProject
//
//  Created by student05 on 27.02.17.
//  Copyright © 2017 student05. All rights reserved.
//

import UIKit
import FMDB

class ConnectToServer {
    private var imai = ""
    private var devid = ""
    private var servaddr = ""
    private var usernick = ""
    private var username = ""
    private var userphone = ""
    private var useravatar = Data()
    private var connected = false
    private var errmessage = ""
    
    init() {
        self.imai = UIDevice.current.identifierForVendor!.uuidString
        self.devid = ""
        self.servaddr = ""
        self.usernick = ""
        self.username = ""
        self.userphone = ""
        self.useravatar = Data()
        self.connected = false
        self.errmessage = ""
        
        let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let fileURL = documents.appendingPathComponent("option.db")
        let database = FMDatabase(path: fileURL.path)
        if (database?.open())! {
            var strSQL = ""
            do {
                //database?.beginTransaction()
                strSQL = "drop table SETTINGS"
                try database?.executeUpdate(strSQL, values: nil)
                //database?.commit()
                // create table if not exists
                //strSQL = "create table if not exists SETTINGS (ID integer primaty key auto_increment, DEVID text, SRVADR text, UNICK text, UNAME text, UPHONE text, UAVATAR data)"
                strSQL = "create table if not exists SETTINGS (DEVID text, SRVADR text, UNICK text, UNAME text, UPHONE text, UAVATAR data)"
                try database?.executeUpdate(strSQL, values: nil)
                
                // select option values
                strSQL = "select * from SETTINGS"
                let rs = try database?.executeQuery(strSQL, values: nil)
                while (rs?.next())! {
                    self.devid = rs?.string(forColumn: "DEVID") ?? ""
                    self.servaddr = rs?.string(forColumn: "SRVADR") ?? ""
                    self.usernick = rs?.string(forColumn: "UNICK") ?? ""
                    self.username = rs?.string(forColumn: "UNAME") ?? ""
                    self.userphone = rs?.string(forColumn: "UPHONE") ?? ""
                    self.useravatar = rs?.data(forColumn: "UAVATAR") ?? Data()
                    
                }
                if doCheckSocked() {
                    let chDev = doCheckDevice()
                    if  chDev != "No" {
                        if chDev != "Yes" {self.devid = chDev}
                        let chNick = doCheckNick()
                        if chNick != "No" {
                            if chNick != "Yes" {self.usernick = chNick}
                            self.connected = true
                            self.errmessage = ""
                        } else {self.errmessage = "Current user blocked"}
                    } else {self.errmessage = "Current imai end device ID not supported"}
                } else {self.errmessage = "Current server not available"}
                strSQL = "insert or replace into SETTINGS (DEVID, SRVADR, UNICK, UNAME, UPHONE, UAVATAR) values (?, ?, ?, ?, ?, ?)"
                print(self.devid + "|" + self.servaddr + "|" + self.usernick + "|" + self.username + "|" + self.userphone)
                try database?.executeUpdate(strSQL, values: [self.devid, self.servaddr, self.usernick, self.username, self.userphone, self.useravatar])
                database?.close()
            } catch let error as NSError {
                self.errmessage = "\(error.localizedDescription)"
            }
        } else {
            self.errmessage = "Unable to open or create a database on this device"
        }
    }
    /*
     func setSAdr(mySAdr: String) {self.sadr = mySAdr}
     func setImai(myImai: String){self.imai = myImai}
     func setDevId(myDevId: String){self.devid = myDevId}
     func setUNick(myUNick: String){self.usernick = myUNick}
     func setConn(myConn: Bool){self.connected = myConn}
     
     func getSAdr() -> String {return self.sadr}
     func getImai() -> String {return self.imai}
     func getDevId() -> String {return self.devid}
     func getUNick() -> String {return self.usernick}
     */
    
    func checkConn() -> Bool {
        self.connected = false
        if doCheckSocked() {
            if doCheckDevice() == "Yes" {
                if doCheckNick() == "Yes" {
                    self.connected = true
                    self.errmessage = ""
                } else {self.errmessage = "Current user blocked"}
            } else {self.errmessage = "Current imai end device ID not supported"}
        } else {self.errmessage = "Current server not available"}
        return self.connected
    }
    
    func getConn() -> Bool {return self.connected}
    func getErr()->String {return self.errmessage}
    
    private func doCheckSocked()->Bool{
        return arc4random() % 2 == 0 ? true : false
        //return true
    }
    
    private func doCheckDevice()->String{
        var serverDevId = ""
        // check 'imai' and 'devid' from server
        serverDevId = "0000000000000000"
        //
        return arc4random() % 2 == 0 ? serverDevId : "Yes"
    }
    
    private func doCheckNick()->String{
        var serverUserNick = ""
        // check 'devid' and 'usernick' from server
        serverUserNick = "NewUserNick"
        //
        return arc4random() % 2 == 0 ? serverUserNick : "Yes"
    }
}

var connectToServer = ConnectToServer()

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

    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var btnFavorites: UIButton!
    @IBOutlet weak var btnAllUser: UIButton!
    @IBOutlet weak var txtMessage: UITextView!

    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnAlarm: UIButton!

    @IBOutlet weak var cellBtn: UITableViewCell!
    @IBOutlet weak var cell0: UIView!
    @IBOutlet weak var cell1: UITableViewCell!
    @IBOutlet weak var cell2: UITableViewCell!
    @IBOutlet weak var cell3: UITableViewCell!

    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    @IBOutlet weak var fotoBtnLeft: UIButton!
    @IBOutlet weak var fotoBtnCenter: UIButton!
    @IBOutlet weak var fotoBtnRight: UIButton!
    @IBOutlet weak var clrButtonLeft: UIButton!
    @IBOutlet weak var clrButtonCenter: UIButton!
    @IBOutlet weak var clrButtonRight: UIButton!
    
    @IBAction func imgClearType(_ sender: UIButton) {
        if sender.tag == 1 {
            img1.image = UIImage()
            img1.tag = 0
            fotoBtnLeft.isHidden = false
            clrButtonLeft.isHidden = true
        } else if sender.tag == 2 {
            img2.image = UIImage()
            img2.tag = 0
            fotoBtnCenter.isHidden = false
            clrButtonCenter.isHidden = true
        } else {
            img3.image = UIImage()
            img3.tag = 0
            fotoBtnRight.isHidden = false
            clrButtonRight.isHidden = true
        }
    }
    
    @IBAction func fotoBtnType(_ sender: UIButton) {
        if sender.tag == 1 {
            //img1.image = UIImage()
            //img1.tag = 0
            fotoBtnLeft.isHidden = true
            clrButtonLeft.isHidden = false
        } else if sender.tag == 2 {
            //img2.image = UIImage()
            //img2.tag = 0
            fotoBtnCenter.isHidden = true
            clrButtonCenter.isHidden = false
        } else {
            //img3.image = UIImage()
            //img3.tag = 0
            fotoBtnRight.isHidden = true
            clrButtonRight.isHidden = false
        }
    }
    
    @IBAction func btnCancelType(_ sender: UIButton) {
        self.txtAddress.text = ""
        self.txtMessage.text = ""
        self.img1.image = UIImage()
        self.img1.tag = 0
        self.img2.image = UIImage()
        self.img2.tag = 0
        self.img3.image = UIImage()
        self.img3.tag = 0
        self.clrButtonLeft.isHidden = true
        self.clrButtonCenter.isHidden = true
        self.clrButtonRight.isHidden = true
        self.fotoBtnLeft.isHidden = false
        self.fotoBtnCenter.isHidden = false
        self.fotoBtnRight.isHidden = false
    }
    
    @IBAction func btnSendType(_ sender: UIButton) {
        if connectToServer.getConn() {
            
        }
    }
    
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let connectToServer = ConnectToServer()
        /*
        if connectToServer.getConn() {
            lblStatus.backgroundColor = UIColor.green
            lblStatus.text = "Connection established!"
            lblStatus.tag = 1
        } else {
            let alertMessage = UIAlertController(title: "Connection failed", message: connectToServer.getErr(), preferredStyle: UIAlertControllerStyle.alert)
            let alertActionOk = UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive, handler: nil)
            alertMessage.addAction(alertActionOk)
            self.present(alertMessage, animated: true, completion: nil)
            lblStatus.backgroundColor = UIColor.red
            lblStatus.text = "No connection!"
            lblStatus.tag = 0
        }
        */
        self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "imgBack.jpg")!)
        cell0.backgroundColor = self.tableView.backgroundColor
        cell1.backgroundColor = self.tableView.backgroundColor
        cell2.backgroundColor = self.tableView.backgroundColor
        cell3.backgroundColor = self.tableView.backgroundColor
        cellBtn.backgroundColor = self.tableView.backgroundColor
        btnFavorites.tintColor = UIColor.white
        btnAllUser.tintColor = UIColor.white
        
        txtAddress.layer.borderWidth = 1
        txtAddress.layer.borderColor = UIColor.gray.cgColor
        txtAddress.layer.cornerRadius = 5
        
        txtMessage.layer.borderWidth = 1
        txtMessage.layer.borderColor = UIColor.gray.cgColor
        txtMessage.layer.cornerRadius = 5
        
        img1.layer.borderWidth = 1
        img1.layer.borderColor = UIColor.gray.cgColor
        img1.layer.cornerRadius = 5
        
        img2.layer.borderWidth = 1
        img2.layer.borderColor = UIColor.gray.cgColor
        img2.layer.cornerRadius = 5
        
        img3.layer.borderWidth = 1
        img3.layer.borderColor = UIColor.gray.cgColor
        img3.layer.cornerRadius = 5
        
        btnSend.layer.cornerRadius = btnSend.bounds.height / 2
        btnSend.layer.borderColor = UIColor.white.cgColor
        btnSend.layer.borderWidth = 2.0
        
        btnCancel.layer.cornerRadius = btnCancel.bounds.height / 2
        btnCancel.layer.borderColor = UIColor.blue.cgColor
        btnCancel.layer.borderWidth = 2.0
        
        btnAlarm.layer.cornerRadius = btnAlarm.bounds.height / 2
        btnAlarm.layer.borderColor = UIColor.red.cgColor
        btnAlarm.layer.borderWidth = 2.0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(Bool.init())
        
        if connectToServer.checkConn() {
            lblStatus.backgroundColor = UIColor.green
            lblStatus.text = "Connection established!"
            lblStatus.tag = 1
        } else {
            let alertMessage = UIAlertController(title: "Connection failed", message: connectToServer.getErr(), preferredStyle: UIAlertControllerStyle.alert)
            let alertActionOk = UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive, handler: nil)
            alertMessage.addAction(alertActionOk)
            self.present(alertMessage, animated: true, completion: nil)
            lblStatus.backgroundColor = UIColor.red
            lblStatus.text = "No connection!"
            lblStatus.tag = 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

