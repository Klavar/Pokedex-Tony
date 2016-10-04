//
//  Pokemon.swift
//  Pokedex-by-Tony-Merritt
//
//  Created by Tony Merritt on 02/10/2016.
//  Copyright © 2016 Tony Merritt. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    fileprivate var _description: String!
    fileprivate var _type: String!
    fileprivate var _defense: String!
    fileprivate var _height: String!
    fileprivate var _weight: String!
    fileprivate var _baseAttack: String!
    fileprivate var _nextEvolutionText: String!
    fileprivate var _nextEvolutionId: String!
    fileprivate var _nextEvolutionLevel: String!
    fileprivate var _pokemonUrl: String!
    
    
    var description: String {
            if _description == nil {
                _description = ""
            }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var baseAttack: String {
        if _baseAttack == nil {
            _baseAttack = ""
        }
        return _baseAttack
    }
    
    var nextEvolutionText: String {
        if _nextEvolutionText == nil {
            _nextEvolutionText = ""
        }
        return _nextEvolutionText
    }
    
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
  
    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    
    
     init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
      _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
        
    }
    
    func downloadPokemonDetails(compleated: @escaping DownloadCompleate) {
    
        
       
       let url = NSURL(string: _pokemonUrl)!
        let request = URLRequest(url: url as URL)
        Alamofire.request(request).responseJSON { response in
            let result = response.result
        
            
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let baseAttack = dict["attack"] as? Int {
                    self._baseAttack = "\(baseAttack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
              
                
                print(self._weight)
                print(self._height)
                print(self._baseAttack)
                print(self._defense)
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        
                        for x in 1 ..< types.count {
                        if let name = types[x]["name"] {
                            self._type! += "/\(name.capitalized)"
                        }
                    }
                }
                    
                    }else {
                        self._type = ""
                    }
                
                print(self._type)
            
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] ,
                    descArr.count > 0 {
                    
                    if let url = descArr[0]["resource_uri"] {
                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                        let nsrequest = URLRequest(url: nsurl as URL)
                        Alamofire.request(nsrequest).responseJSON { response in
                            let result = response.result
                            
                            if let descDict = result.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                        print(self._description)
                                    }
                            }
                            
                            compleated()
                        }
                    }
                }else {
                    self._description = ""
                    
                    }
                    
                    if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0{
                        
                        if let to = evolutions[0]["to"] as? String {
                            
                            //Can't support mega pokemon at the moment but the API still sends the info.
                            if to.range(of: "mega") == nil {
                            
                                if let uri = evolutions[0]["resource_uri"] as? String {
                                    
                                    let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                    let num = newStr.replacingOccurrences(of: "/", with: "")
                                    

                                    
                                    self._nextEvolutionId = num
                                    self._nextEvolutionText = to
                                    
                                    if let level = evolutions[0]["level"] as? Int {
                                        self._nextEvolutionLevel = "\(level)"
                                    
                                    }
                                    
                             
                                }
                            }
                        }
                        
                    }
                }
            }
        }
//    }
