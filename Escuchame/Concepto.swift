//
//  Concepto.swift
//  Escuchame
//
//  Created by Daniel Reyes Sánchez on 12/12/16.
//  Copyright © 2016 Daniel Reyes Sánchez. All rights reserved.
//

import UIKit

class Concepto {
    var idConcepto: Int?
    var nombre: String
    var imagen: UIImage?
    var nombreArchivo: String?
    
    
    init(idConcept: Int, name:String, image:String){
        self.idConcepto = idConcept
        self.nombre = name
        print("imagen:.:.:...", image)
        self.imagen = UIImage(named:image)!
        self.nombreArchivo = image
    }
    
    init(idConcept: Int, name:String){
        self.idConcepto = idConcept
        self.nombre = name
        self.imagen = nil
    }
    
    init(name:String){
        self.idConcepto = nil
        self.nombre = name
        self.imagen = nil
    }
    
    init(name:String, image:String){
        self.idConcepto = nil
        self.nombre = name
        self.imagen = UIImage(named:image)!
    }
    
}
