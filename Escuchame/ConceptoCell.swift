//
//  ConceptoCell.swift
//  Escuchame
//
//  Created by Daniel Reyes Sánchez on 30/11/16.
//  Copyright © 2016 Daniel Reyes Sánchez. All rights reserved.
//

import UIKit

class ConceptoCell: UICollectionViewCell {
    
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var manoButton: UIButton!
    
    
    var concepto: Concepto? {
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        imagen.image = concepto?.imagen
        titulo.text = concepto?.nombre
    }
    
}
