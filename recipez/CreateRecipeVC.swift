//
//  CreateRecipeVC.swift
//  recipez
//
//  Created by Nam-Anh Vu on 09/06/2016.
//  Copyright © 2016 namdashann. All rights reserved.
//

import UIKit
import CoreData

class CreateRecipeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var recipeTitle: UITextField!
    @IBOutlet weak var recipeIngredients: UITextField!
    @IBOutlet weak var recipeSteps: UITextField!
    @IBOutlet weak var recipeImg: UIImageView!
    @IBOutlet weak var addRecipeBtn: UIButton!
    
    // store an image picker
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker = UIImagePickerController()
        // set the delegate for the imagePicker
        imagePicker.delegate = self
        
        // get rid of square corners
        recipeImg.layer.cornerRadius = 4.0
        recipeImg.clipsToBounds = true
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        recipeImg.image = image
    }
    
    @IBAction func addImage(sender: UIButton) {
        // present the imagePicker
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func createRecipe(sender: AnyObject!) {
        // let's make sure there is a title, this is the only requirement
        if let title = recipeTitle.text where title != "" {
            
            // grab the data out of the text fields and save them
            // we're going to need that managedObjectContext again
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            // we need a reference to an entity that we're going to save
            // so in order to create an Entity class we need to say what entity
            // it's going to be by stating "Recipe"
            let entity = NSEntityDescription.entityForName("Recipe", inManagedObjectContext: context)!
            
            // now we create a recipe class
            // so since our Recipe class inherits from NSManagedObject one of the initialisers allows us to
            // pass in an entity and it wants the context you're going to be saving it into
            let recipe = Recipe(entity: entity, insertIntoManagedObjectContext: context)
            
            // now assign the values into our recipe object
            recipe.title = title
            recipe.ingredients = recipeIngredients.text
            recipe.steps = recipeSteps.text
            recipe.setRecipeImage(recipeImg.image!) // from line 37. ! assumes an image is there
            
            // now we save our recipe
            context.insertObject(recipe) // recipe from line 64.
            // remember the context is a scratchpad, nothing is persisted until we tell it to 
            // again this is going to throw an error so do a do catch
            
            do {
                // whenever you call the .save it's going to talk to the persistentStoreCoordinator and attempt
                // to save that into permanent storage
                try context.save()
            } catch {
                print("could not save recipe")
            }
            
            self.navigationController?.popViewControllerAnimated(true)
            
        }
    }

}
