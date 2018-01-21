//
//
//
//


import UIKit

class ParkTableViewCell: UITableViewCell {
    
    //the image of park from google maps
    @IBOutlet weak var ParkImage: UIImageView!
    //how far the park from current location
    @IBOutlet weak var ParkRange: UILabel!
    //name of the park
    @IBOutlet weak var ParkName: UILabel!
    //adress of the park
    @IBOutlet weak var ParkAddress: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        <#code#>
    }
}
