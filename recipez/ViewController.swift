//
//  ViewController.swift
//  recipez
//
//  Created by Nam-Anh Vu on 06/06/2016.
//  Copyright © 2016 namdashann. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    // this table view needs to reference some type of data
    // we can just make a list of an array of recipes using our Recipe class
    var recipes = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the delegates
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(animated: Bool) {
        fetchAndSetResults()
        tableView.reloadData()
    }

    func fetchAndSetResults() {
        // in here we're going to work with what's in the App Delegate namely managedObjectContext
        // first grab the app delegate and this will always give you the main delegate
        // we're going to force unwrap it because we know it's going to work
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        
        // then we grab the managedObjectContext property from the App Delegate which is the scratchpad
        let context = app.managedObjectContext
        
        // to get data you have to make an NSFetchRequest and it's looking for a name of an entity
        // which in our case is recipe. The entity that you have in your data model is the same one 
        // that you want to call here. We want to grab all entities that have that name on it
        let fetchRequest = NSFetchRequest(entityName: "Recipe")
        // fetch requests can fail so we need to make a do block
        do {
            // here we are saying "context, make a request for us, talk to the database and grab data
            // and bring it to us. The persistentStoreCoordinator is going to grab stuff for us and 
            // store it into results
            let results = try context.executeFetchRequest(fetchRequest)
            // if this works then we call the following which stores the results in the recipes array. 
            // We force unwrap it becuase we know it's going to be a recipe.
            self.recipes = results as! [Recipe]
        } catch let err as NSError {
            print (err.debugDescription)
        }
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("RecipeCell") as? RecipeCell {
            
            // grab the recipe post, i.e. the current recipe at the current index
            let recipe = recipes[indexPath.row]
            // then we call the configureCell function we created and pass in that recipe we just grabbed
            cell.configureCell(recipe)
            return cell
        } else {
            return RecipeCell()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

