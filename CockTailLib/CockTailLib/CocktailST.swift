//
//  CocktailST.swift
//  CockTailLib
//
//  Created by Hugo Adams on 11/02/20.
//  Copyright © 2020 Hugo Adams. All rights reserved.
//

import UIKit

struct CocktailSt
{
    var id : Int
    var drink : String
    var thumbnail : String
}

class DataService : NSObject
{
    let ingredientFilter : String = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i="
    
    public func RequestCocktails(ingredient: String, vc: ViewController)
    {
        let url = URL(string: ingredientFilter + ingredient)
        var cocktailArr = [CocktailSt]()

        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : Any]                
                let drinks = json["drinks"] as? [[String: Any]] ?? []
                
                for numb in 0..<drinks.count
                {
                    cocktailArr.append(self.CocktailData(drink: drinks[numb]))
                }
                
                vc.UpdateCocktails(cktls: cocktailArr)
            }
            catch let error as NSError
            {
                print("printing ERROR")
                print(error)
            }
        }).resume()
    }
    
    func CocktailData(drink: [String: Any]) -> CocktailSt
    {
        let id : Int = Int(drink["idDrink"] as! String)!
        let thumb = drink["strDrinkThumb"]
        let drink : String = (drink["strDrink"] as! String)
        
        let cktl: CocktailSt = CocktailSt(id: id, drink: drink, thumbnail: thumb as! String)

        return cktl
    }
}
