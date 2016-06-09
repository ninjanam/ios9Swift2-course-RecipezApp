//
//  RecipeCell.swift
//  recipez
//
//  Created by Nam-Anh Vu on 09/06/2016.
//  Copyright © 2016 namdashann. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // cellForRowIndexPath is going to call this every time we need a new cell
    func configureCell(recipe: Recipe) {
        recipeTitle.text = recipe.title
        recipeImg.image = recipe.getRecipeImage()
        
    }
}
