//
//  ConceptoListaCell.swift
//  Escuchame
//
//  Created by Daniel Reyes Sánchez on 13/12/16.
//  Copyright © 2016 Daniel Reyes Sánchez. All rights reserved.
//

import UIKit

class ConceptoListaCell: UICollectionViewCell {
    
    @IBOutlet weak var imagen: UIImageView!
    
    var concepto: Concepto? {
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        imagen.image = concepto?.imagen
    }
}
