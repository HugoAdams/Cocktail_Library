//
//  CocktailST.swift
//  CockTailLib
//
//  Created by Hugo Adams on 11/02/20.
//  Copyright © 2020 Hugo Adams. All rights reserved.
//

import UIKit

struct CocktailSt // struct to hold cocktail data
{
    var id : Int    //id in database
    var drink : String // name of drink
    var thumbnail : String // address of image
}

class DataService : NSObject //DataService class for getting data from database
{
    let ingredientFilter : String = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i="
    
    public func RequestCocktails(ingredient: String, viewCon: ViewController)
    {   //func that will return an array of CocktailSt async to viewcontroller
        
        var str = ingredient.replacingOccurrences(of: "\\", with: "")//removes all ecsape charas from sent string eg \n
        
        while(str.first == " ")
        { str = String(str.dropFirst()) } //removes all spaces from start of string
        
        str = str.replacingOccurrences(of: " ", with: "_") // replaces remaining spaces with "_"
        
        let url = URL(string: ingredientFilter + str)//create URL

        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : Any]                
                let drinks = json["drinks"] as? [[String: Any]] ?? []
                
                var cocktailArr = [CocktailSt]() //setup array
                for numb in 0..<drinks.count    //for loop filling array of CocktailSt
                {
                    cocktailArr.append(self.CocktailData(drink: drinks[numb]))
                }
                
                viewCon.UpdateCocktails(cktls: cocktailArr) // returning data back to view controller
            }
            catch let error as NSError
            {
                print("printing ERROR")
                print(error)
                viewCon.NoCocktailsFound(string: str) //telling view controller no drinks found
            }
        }).resume()
    }
    
    func CocktailData(drink: [String: Any]) -> CocktailSt
    {//func to convert string/Dictionary from data base into struct
        let id : Int = Int(drink["idDrink"] as! String)!
        let thumb = drink["strDrinkThumb"]  // mysterious errors were coming from this line. thats why
                                            // thats why doesnt convert until later
        let drink : String = (drink["strDrink"] as! String)
        
        let cktl: CocktailSt = CocktailSt(id: id, drink: drink, thumbnail: thumb as! String)

        return cktl
    }
}
