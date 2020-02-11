//
//  ViewController.swift
//  CockTailLib
//
//  Created by Hugo Adams on 11/02/20.
//  Copyright © 2020 Hugo Adams. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    //MARK: Properties
    @IBOutlet weak var IngredientTF: UITextField!
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var CocktailTable: UITableView!
    var cocktails: [CocktailSt] = [CocktailSt]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return cocktails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = CocktailTable.dequeueReusableCell(withIdentifier: "idCKTL", for: indexPath)
        cell.textLabel!.text = cocktails[indexPath.row].drink
        return cell
    }
    

    //MARK: Actions
    @IBAction func FindCocktailBtn(_ sender: UIButton)
    {
        if(IngredientTF.text != "")
        {
            FetchCocktails(ingredi: IngredientTF.text!)
        }
        view.endEditing(true)
    }
    
    func FetchCocktails(ingredi: String)
    {
        let ds : DataService = DataService()
        ds.RequestCocktails(ingredient: ingredi, vc: self)
        
    }
    
    func Refresh()
    {
        print("refreshed")
        print("cocktails length = " + String(cocktails.count))
        CocktailTable.reloadData()
        
    }
    
    public func UpdateCocktails(cktls : [CocktailSt])
    {
        cocktails = cktls
        Refresh()
    }
}

