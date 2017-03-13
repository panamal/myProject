//
//  FirstFormTVC.swift
//  myProject
//
//  Created by student05 on 13.03.17.
//  Copyright © 2017 student05. All rights reserved.
//

import UIKit

class FirstFormTVC: UITableViewController {

    @IBOutlet weak var txtAddress: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        /*
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
        */
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
