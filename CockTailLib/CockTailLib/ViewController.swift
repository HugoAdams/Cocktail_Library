//
//  ViewController.swift
//  CockTailLib
//
//  Created by Hugo Adams on 11/02/20.
//  Copyright © 2020 Hugo Adams. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate
{
    @IBOutlet weak var IngredientTF: UITextField!   //text field
    @IBOutlet weak var CocktailTable: UITableView!  //Table view
    
    var cocktails: [CocktailSt] = [CocktailSt]()    //array of cocktail objects
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {//default tableView func
        return cocktails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = CocktailTable.dequeueReusableCell(withIdentifier: "idCKTL", for: indexPath)
        cell.textLabel!.text = cocktails[indexPath.row].drink   //setting name of cocktail
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        view.endEditing(true) //hiding keyboard when scrolling
    }

    @IBAction func FindCocktailBtn(_ sender: UIButton)
    {   //Button Action functiom
        if(IngredientTF.text != "")//if the string isnt empty
        {
            FetchCocktails(ingredi: IngredientTF.text!)
        }
        view.endEditing(true)//hide keyboard when button is pressed
    }
    
    func FetchCocktails(ingredi: String)
    {
        let ds : DataService = DataService() //create instance of DataService
        ds.RequestCocktails(ingredient: ingredi, viewCon: self)  //call DataService func giving text from
                                                            //text feild and instance of viewcontroller
    }
    
    func Refresh()
    {   //to reload the table view
        print("refreshed")
        print("cocktails length = " + String(cocktails.count))
        CocktailTable.reloadData()
        
    }
    
    public func UpdateCocktails(cktls : [CocktailSt])
    {   // func to be called from Data Service
        cocktails = cktls
        DispatchQueue.main.async {
            self.Refresh() // refresh needs to be called from main thread
        }
    }
    
    public func NoCocktailsFound(string: String)
    {   //func creates an alert if no cocktails were found
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "", message: "No cocktails were found including " + string, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}

