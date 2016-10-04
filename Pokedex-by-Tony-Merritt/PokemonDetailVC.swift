//
//  PokemonDetailVC.swift
//  Pokedex-by-Tony-Merritt
//
//  Created by Tony Merritt on 03/10/2016.
//  Copyright © 2016 Tony Merritt. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var defenseLabel: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var pokedexLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var baseAttackLabel: UILabel!
  
    @IBOutlet weak var currentEvoImage: UIImageView!
    
    @IBOutlet weak var nextEvoImage: UIImageView!
    
    @IBOutlet weak var NextEvolutionLabel: UILabel!
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = pokemon.name.capitalized
        let image = UIImage(named: "\(pokemon.pokedexId)")
        mainImage.image = image
        currentEvoImage.image = image
        
        pokemon.downloadPokemonDetails { () -> () in 
        
            // This code will be called after download is done.
            self.updateUi()
            
            
        }
    }
    
    func updateUi() {
       descriptionLabel.text = pokemon.description
        typeLabel.text = pokemon.type
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        pokedexLabel.text = "\(pokemon.pokedexId)"
        weightLabel.text = pokemon.weight
        baseAttackLabel.text = pokemon.baseAttack
        
        if pokemon.nextEvolutionId == "" {
            NextEvolutionLabel.text = "No Evolutions"
            nextEvoImage.isHidden = true
        }else {
            nextEvoImage.isHidden = false
            nextEvoImage.image = UIImage(named: pokemon.nextEvolutionId)
            
            var str = "Next Evolution: \(pokemon.nextEvolutionText)"
            
            if pokemon.nextEvolutionLevel !=
                "" {
                str += " - Level \(pokemon.nextEvolutionLevel)"
                NextEvolutionLabel.text = "\(str)"

            }
        }
        
        
    }
    
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }


}
