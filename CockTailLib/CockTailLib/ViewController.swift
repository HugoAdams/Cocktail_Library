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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return CocktailTable.dequeueReusableCell(withIdentifier: "idCKTL")!
    }
    

    //MARK: Actions
    @IBAction func FindCocktailBtn(_ sender: UIButton)
    {
        if(IngredientTF.text != "")
        {
            FetchCocktails(ingredi: IngredientTF.text!)
        }
    }
    
    func FetchCocktails(ingredi: String)
    {
        let ds : DataService = DataService()
        var cocktailList : [CocktailSt] = ds.RequestCocktails(ingredient: ingredi)
        
    }
    
}

