//
//  ParkTableViewController.swift
//  PetzyIOS
//
//  Created by user on 1/21/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class ParkTableViewController: UITableViewController {

    //empty array of parks
    var parksArray : Array<Park>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parksArray = []
         let dispatchGroup = DispatchGroup()
        //populate the array with parks from firebase
        let ref = Database.database().reference(fromURL: "https://petzy-1001.firebaseio.com/input")
        dispatchGroup.enter()
        ref.observe(DataEventType.value, with: { (snapshot) in
            _ = snapshot.value as? [String : AnyObject] ?? [:]
            //for loop that interact over snapshot data to poulate new park
            //add the park to parks array
            for fireObj in snapshot.children{
                //create new park from the firebase info
                let parkSnap = Park(dataSnap : fireObj as! DataSnapshot)
                //adds the park to the park list
                if self.parksArray.count < snapshot.childrenCount - 1{
                    self.parksArray.append(parkSnap)
                }else {
                    dispatchGroup.leave()
                }
            }
        })
        dispatchGroup.notify(queue: DispatchQueue.main, execute: {
           DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //uses size of park array
        return parksArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //identifer of the park
        let cellIdentifier = "ParkTableViewCell"
        //create custom cel with in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ParkTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ParkTableViewCell.")
        }
        // get the park by row index
        let park = parksArray[indexPath.row]
        //assign the park image to UIImage of the same category
        cell.parkImage.sd_setImage(with: URL(string: park.getImage()), placeholderImage: UIImage(named: "placeholder.png"))
        //assign the park title to UILabel of the same category
        cell.parkName.text = park.title
        //assign the park address to UILabel of the same category
        cell.parkAddress.text = park.address
        //assogn the park location to UILabel of the same category
        //cell.parkRange.text = park.location
        return cell
    }
    
    //sets the hieght of the row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 400.0;
    }
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