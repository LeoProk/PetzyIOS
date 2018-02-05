//
//  ParkTableViewController.swift
//  PetzyIOS
//
//  Created by user on 1/21/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import SDWebImage

class ParkTableViewController: UITableViewController {

    //empty array of parks
    var parksArray : Array<Park>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //populate the array with parks from firebase
        parksArray = ParkListMaker().getParks()
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
        //full link to get google map image uses lat and lng for location place
        //and camera for camera angle
        let imgUrl = "https://maps.googleapis.com/maps/api/streetview?size=400x400&location=\(String(describing: park.location.lat)),\(String(describing: park.location.lng))\(park.camera) &key=AIzaSyDGTKCSCY_lpKtVrA1bJYctJdrJhjzGMlE";
        //assign the park image to UIImage of the same category
        cell.parkImage.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "placeholder.png"))
        //assign the park title to UILabel of the same category
        cell.parkName.text = park.title
        //assign the park address to UILabel of the same category
        cell.parkAddress.text = park.address
        //assogn the park location to UILabel of the same category
        //cell.parkRange.text = park.location
        return cell
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
