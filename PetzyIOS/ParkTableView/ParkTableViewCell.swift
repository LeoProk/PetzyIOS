//
//empty cell with park image park title
//park address 
//


import UIKit

class ParkTableViewCell: UITableViewCell {
    
    //the image of park from google maps
    @IBOutlet weak var parkImage: UIImageView!
    //how far the park from current location
    @IBOutlet weak var parkRange: UILabel!
    //name of the park
    @IBOutlet weak var parkName: UILabel!
    //adress of the park
    @IBOutlet weak var parkAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
       
    }
}
