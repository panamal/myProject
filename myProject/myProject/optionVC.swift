//
//  optionVC.swift
//  myProject
//
//  Created by student05 on 11.03.17.
//  Copyright © 2017 student05. All rights reserved.
//

import UIKit
import FMDB
import MediaPlayer
import MobileCoreServices

class optionVC: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var avatarImage:UIImage?
    var movieURL:NSURL?
    var lastChosenMediaType:String?
    var currentImage = 0
    
    class optData {
        private var devImai = ""
        private var srvAdr = ""
        private var devId = ""
        private var usrNick = ""
        private var usrName = ""
        private var usrPhone = ""
        private var usrAvtr = UIImage()
        
        func setAdr(adr: String){self.srvAdr = adr}
        func setDId(did: String){self.devId = did}
        func setNick(nick: String){self.usrNick = nick}
        func setName(name: String){self.usrName = name}
        func setPhone(phone: String){self.usrPhone = phone}
        func setAvatar(avatar: UIImage){self.usrAvtr = avatar}
        
        func getAdr()->String{return self.srvAdr}
        func getDId()->String{return self.devId}
        func getNick()->String{return self.usrNick}
        func getName()->String{return self.usrName}
        func getPhone()->String{return self.usrPhone}
        func getAvatar()->UIImage{return self.usrAvtr}
        func getImai()->String{return self.devImai}
        
        init() {
            self.devImai = (UIDevice.current.identifierForVendor?.uuidString)!
            self.srvAdr = ""
            self.devId = ""
            self.usrNick = ""
            self.usrName = ""
            self.usrPhone = ""
            self.usrAvtr = UIImage()
        }
    }
    
    class myDatabase {
        private var database:FMDatabase = FMDatabase()
        
        init(dbFile: String) {
            let documents = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = documents.appendingPathComponent(dbFile)
            self.database = FMDatabase(path: fileURL.path)
        }
        
        func getDatabase()->FMDatabase{
            return self.database
        }
        
        func doDbOpen()->Bool{
            return self.database.open()
        }
        
        func doDbClose(){
            self.database.close()
        }
        
    }
    
    let myOption:optData = optData()
    var database = myDatabase(dbFile: "option.db")
    
    @IBOutlet weak var lblIdentifier: UILabel!
    @IBOutlet weak var lblDivId: UILabel!
    @IBOutlet weak var txtServer: UITextField!
    @IBOutlet weak var txtUserNick: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtUserPhone: UITextField!
    @IBOutlet weak var imgUserAvatar: UIImageView!
    @IBOutlet weak var btnCheckUser: UIButton!
    @IBOutlet weak var btnServConn: UIButton!
    
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }  
    
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
        if btnServConn.tag == 0 {
            let serverAddress = txtServer.text ?? ""
            if serverAddress.characters.count > 0 {
                //**********************************
                // connect to server & get device ID
                let servConnect = Int(arc4random() % 2) == 0 ? false : true
                //**********************************
                if servConnect {
                    myOption.setAdr(adr: serverAddress)
                    // Send to server 'devImai' and 'devId'
                    // Server must generate or reading 'devId'
                    myOption.setDId(did: "1111111111111111")
                    lblDivId.text = "Device ID: " + myOption.getDId()
                    // ***************************************
                    
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
                let userAvatar = imgUserAvatar.image!
                if userNick.characters.count * userName.characters.count * userPhone.characters.count > 0 {
                    //*********************
                    // check user nickname
                    //*********************
                    if userCheck {
                        myOption.setNick(nick: userNick)
                        myOption.setName(name: userName)
                        myOption.setPhone(phone: userPhone)
                        myOption.setAvatar(avatar: userAvatar)
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
                txtUserNick.text = myOption.getNick()
                txtUserName.text = myOption.getName()
                txtUserPhone.text = myOption.getPhone()
                imgUserAvatar.image = myOption.getAvatar()
                txtUserNick.isEnabled = false
                txtUserName.isEnabled = false
                txtUserPhone.isEnabled = false
                btnAvPhoto.isEnabled = false
                btnAvAlbum.isEnabled = false
                btnCheckUser.tag = 2
                btnCheckUser.setTitleColor(UIColor.green, for: .normal)
                btnCheckUser.setTitle("Ok!", for: .normal)
                
                if database.doDbOpen() {
                    //print("Database is open")
                    var strSQL = ""
                    do {
                        strSQL = "drop table SETTINGS"
                        try database.getDatabase().executeUpdate(strSQL, values: nil)
                        
                        strSQL = "create table if not exists SETTINGS (DEVID text, SRVADR text, UNICK text, UNAME text, UPHONE text, UAVATAR data)"
                        try database.getDatabase().executeUpdate(strSQL, values: nil)
                        
                        strSQL = "insert or replace into SETTINGS (DEVID, SRVADR, UNICK, UNAME, UPHONE, UAVATAR) values (?, ?, ?, ?, ?, ?)"
                        let myAvatar:Data = UIImagePNGRepresentation(myOption.getAvatar())!
                        try database.getDatabase().executeUpdate(strSQL, values: [myOption.getDId(), myOption.getAdr(), myOption.getNick(), myOption.getName(), myOption.getPhone(), myAvatar])
                    } catch let error as NSError {
                        print("failed: \(error.localizedDescription)")
                    }
                    database.doDbClose()
                }
            }
        }
    }

    @IBOutlet var btnAvPhoto: UIButton!
    @IBOutlet var btnAvAlbum: UIButton!
    
    @IBAction func fotoBtnType(_ sender: UIButton) {
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            pickMediaFromSource(sourceType: UIImagePickerControllerSourceType.photoLibrary)
        } else {
            pickMediaFromSource(sourceType: UIImagePickerControllerSourceType.camera)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("viewDidLoad")
        // ***************************
        btnCheckUser.setTitleColor(UIColor.white, for: .normal)
        btnCheckUser.setTitle("Check", for: UIControlState.normal)
        btnServConn.setTitleColor(UIColor.white, for: .normal)
        btnServConn.setTitle("Apply", for: UIControlState.normal)
        // ***************************
        if !(database.doDbOpen()) {
            return
        } else {
            do {
                let strSQL = "select * from SETTINGS"
                let rs = try database.getDatabase().executeQuery(strSQL, values: nil)
                while (rs.next()) {
                    myOption.setAdr(adr: rs.string(forColumn: "SRVADR") ?? "")
                    myOption.setDId(did: rs.string(forColumn: "DEVID") ?? "")
                    myOption.setNick(nick: rs.string(forColumn: "UNICK") ?? "")
                    myOption.setName(name: rs.string(forColumn: "UNAME") ?? "")
                    myOption.setPhone(phone: rs.string(forColumn: "UPHONE") ?? "")
                    myOption.setAvatar(avatar: (UIImage(data: (rs.data(forColumn: "UAVATAR") ?? Data()), scale: 1.0) ?? UIImage()))
                    lblIdentifier.text = "Your ID: " + myOption.getImai()
                    lblDivId.text = "Device ID: " + myOption.getDId()
                    txtServer.text = myOption.getAdr()
                    txtUserNick.text = myOption.getNick()
                    txtUserName.text = myOption.getName()
                    txtUserPhone.text = myOption.getPhone()
                    imgUserAvatar.image = myOption.getAvatar()
                }
            } catch let error as NSError {
                print("failed: \(error.localizedDescription)")
            }
            database.doDbClose()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print("viewWillAppear")
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            btnAvPhoto.isHidden = true
        }
        if avatarImage != nil {
            imgUserAvatar.image = avatarImage
        }
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

    func pickMediaFromSource(sourceType: UIImagePickerControllerSourceType){
        let mediaTypes = UIImagePickerController.availableMediaTypes(for: sourceType)!
        if UIImagePickerController.isSourceTypeAvailable(sourceType) && mediaTypes.count > 0 {
            let picker = UIImagePickerController()
            //picker.cameraDevice = UIImagePickerControllerCameraDevice.front
            picker.mediaTypes = mediaTypes
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = sourceType
            present(picker, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Error accessing media", message: "Unsupported media source", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        lastChosenMediaType = info[UIImagePickerControllerMediaType] as? String!
        if let mediaType = lastChosenMediaType {
            if mediaType == (kUTTypeImage as NSString) as String {
                avatarImage = info[UIImagePickerControllerEditedImage] as? UIImage
            } else if mediaType == (kUTTypeMovie as NSString) as String {
                movieURL = info[UIImagePickerControllerMediaURL] as? NSURL
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
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
