//
//  ModelDB.swift
//  Escuchame
//
//  Created by Daniel Reyes Sánchez on 12/12/16.
//  Copyright © 2016 Daniel Reyes Sánchez. All rights reserved.
//

import UIKit

let FMDB = ModelDB()

class ModelDB: NSObject {
    var database: FMDatabase? = nil
    
    class func getInstance() -> ModelDB
    {
        if(FMDB.database == nil)
        {
            FMDB.database = FMDatabase(path: Utilities.getPath("EscuchameTest.db"))
        }
        
        return FMDB
    }
    

    
    /*
    func getAllCategorias() -> NSMutableArray {
        
        FMDB.database!.open()
        let resultSet: FMResultSet! = FMDB.database!.executeQuery("SELECT * FROM Categoria", withArgumentsIn: nil)
        let categorias : NSMutableArray = NSMutableArray()
        
        if (resultSet != nil) {
            while resultSet.next() {
                
                //init(idCategoria:Int, name: String, image:String){
                
                let categoria : Categoria = Categoria(idCategoria: Int(resultSet.int(forColumn: "idCategoria")),
                                                      name: resultSet.string(forColumn: "Nombre"),
                                                      image: resultSet.string(forColumn: "Imagen"))
                
                categorias.add(categoria)
                
            }
        }
        
        FMDB.database!.close()
        return categorias
 
    }
    */
    
    
    
    func getAllConceptos(_ idCategoria: Int) -> [Concepto] {
        FMDB.database!.open()
        print("Se eligiran los conceptos con la categoria: \(idCategoria)")
        let resultSet: FMResultSet! = FMDB.database!.executeQuery("SELECT * FROM Concepto WHERE idCategoria = \(idCategoria)", withArgumentsIn: nil)
        var conceptos:[Concepto] = [Concepto]()
        
        if (resultSet != nil) {
            while resultSet.next() {
                print(resultSet.string(forColumn: "Nombre"))
                conceptos.append(Concepto(idConcept: Int(resultSet.int(forColumn: "idConcepto")),
                                              name: resultSet.string(forColumn: "Nombre"),
                                              image: resultSet.string(forColumn: "Imagen")))
            }
        }
        FMDB.database!.close()
        return conceptos
    }
    
    func getAllCategorias() -> [Int] {
        FMDB.database!.open()
        let resultSet: FMResultSet! = FMDB.database!.executeQuery("SELECT idCategoria FROM Categoria", withArgumentsIn: nil)
        var categorias:[Int] = [Int]()
        
        if (resultSet != nil) {
            while resultSet.next() {
                categorias.append(Int(resultSet.int(forColumn: "idCategoria")))
            }
        }
        FMDB.database!.close()
        return categorias
    }
    
    
    func getRutasMisPalabras()->[String] {
        FMDB.database!.open()
        print("Se obtendrán las rutas de las imágenes tomadas")
        let resultSet: FMResultSet! = FMDB.database!.executeQuery("SELECT Imagen FROM MisPalabras", withArgumentsIn: nil)
        var imagenes:[String] = [String]()
        
        if (resultSet != nil) {
            while resultSet.next() {
                imagenes.append(resultSet.string(forColumn: "Imagen"))
            }
            
        }
        FMDB.database!.close()
        return imagenes
    }
    
    func eliminarMisPalabras() {
        FMDB.database!.open()
        print("Se eliminarán mis palabras")
        FMDB.database!.executeUpdate("DELETE FROM MisPalabras", withArgumentsIn: nil)
        FMDB.database!.close()
    }
    
    
    func getMisPalabras()->[Concepto]{
        FMDB.database!.open()
        print("Se eligiran mis palabras")
        let resultSet: FMResultSet! = FMDB.database!.executeQuery("SELECT * FROM MisPalabras", withArgumentsIn: nil)
        var conceptos:[Concepto] = [Concepto]()
        
        if (resultSet != nil) {
            while resultSet.next() {
                print(resultSet.string(forColumn: "Nombre"))
                conceptos.append(Concepto(idConcept: Int(resultSet.int(forColumn: "idConcepto")),
                                          name: resultSet.string(forColumn: "Nombre"),
                                          image: resultSet.string(forColumn: "Imagen")))
            }
            
        }
        FMDB.database!.close()
        return conceptos
    }
    
    func agregarConcepto(_ nombre:String, _ ruta:String){
        FMDB.database!.open()
        print("Se agregará un nuevo concepto")
        do {
            try FMDB.database!.executeUpdate("INSERT INTO MisPalabras (Nombre,Imagen) VALUES (?,?)", withArgumentsIn: ["\(nombre)","\(ruta)"])
        }catch let error as NSError {
            print("Error al insertar un nuevo concepto: \(error)")
        }
        
            //.executeQuery("INSERT INTO MisPalabras(Nombre, Imagen) VALUES('\(nombre)','\(ruta))'", withArgumentsIn: nil)
        
        FMDB.database!.close()
    }
    
    
    // try database.executeUpdate("insert into test (x, y, z) values (?, ?, ?)", values: ["a", "b", "c"]) 
    
    func getRelatedConcepts(withWords words:[String])->[Concepto]?{
        print("getRelatedConcepts")
        let result = FMDB.database!.open()
        print("Se pudeo abrir? \(result)")
        var conceptos:[Concepto] = [Concepto]()
        
        let existing = FMDB.database?.tableExists("Palabra")
        print("Existe la tabla: \(existing)")
        
        for word in words {
            //let resultSet: FMResultSet! = FMDB.database!.executeQuery("SELECT * FROM Concepto WHERE Nombre LIKE ?", withArgumentsIn: ["%%\(word)%%"])
            //let resultSet: FMResultSet! = FMDB.database!.executeQuery("SELECT * FROM Palabra WHERE Nombre = \"\(word)\"", withArgumentsIn: [])
            
            let resultSet: FMResultSet! = FMDB.database!.executeQuery("SELECT * FROM Palabra WHERE Nombre = \"\(word)\"", withArgumentsIn: [])
            
            //print("resultSet? \(resultSet)")
            
            if (resultSet != nil) {
                resultSet.next()
                
                // Se omiten las que no se encontraron
                if !resultSet.columnIsNull("Nombre"){
                    print(resultSet.string(forColumn: "Nombre"))
                    conceptos.append(Concepto(idConcept: Int(resultSet.int(forColumn: "idPalabra")),
                                              name: resultSet.string(forColumn: "Nombre"),
                                              image: resultSet.string(forColumn: "Imagen")))
                } else {
                    conceptos.append(Concepto(name: word))
                }
                
                
            }
        }
        
        FMDB.database!.close()
        return conceptos
    }

    

}
