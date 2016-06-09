//
//  Recipe.swift
//  recipez
//
//  Created by Nam-Anh Vu on 08/06/2016.
//  Copyright © 2016 namdashann. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Recipe)
class Recipe: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    func setRecipeImage(img: UIImage) {
        let data = UIImagePNGRepresentation(img)
        self.image = data
    }
    
    // this converts images to data
    func getRecipeImage() -> UIImage {
        let img = UIImage(data: self.image!)!
        return img
    }

}
