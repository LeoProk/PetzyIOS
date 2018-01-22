//
//model class for new park with the following verables
//title of the park
//address of the park
//user to idenify if park for sumbited or premade
//image of the park from google maps
//camera with the x and y axis
//location of the current park with lat and lang
//

import Foundation

class Park{
    
    //title of the park
    var title : String
    
    //address of the park
    var address : String
    
    //used to identify if park was sumbited by user
    var user : String
    
    //image of the park from google maps
    var image : String
    
    //camera x and y
    var camera : String
    
    //lat lang location
    var location : Location
    
    
    //class init for new park
    init(title : String,address : String,user : String,image : String,camera : String,
         location : Location) {
        self.title = title
        self.address = address
        self.user = user
        self.image = image
        self.camera = camera
        self.location = location
    }
}
