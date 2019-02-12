//
//  Utilities.swift
//  Escuchame
//
//  Created by Daniel Reyes Sánchez on 12/12/16.
//  Copyright © 2016 Daniel Reyes Sánchez. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    
    class func getPath(_ fileName: String) -> String {
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(fileName)
        
        return fileURL.path
    }
    
    class func copyFile(_ fileName: NSString) {
        let dbPath: String = getPath(fileName as String)
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: dbPath) {
            
            let documentsURL = Bundle.main.resourceURL
            let fromPath = documentsURL!.appendingPathComponent(fileName as String)
            
            var error : NSError?
            
            do {
                try fileManager.copyItem(atPath: fromPath.path, toPath: dbPath)
            } catch let error1 as NSError {
                error = error1
                print("error:\(error)")
            }
            /*
            let alert: UIAlertView = UIAlertView()
            if (error != nil) {
                alert.title = "Error al copiar la Base de datos"
                alert.message = error?.localizedDescription
            } else {
                alert.title = "Copia Exitosa"
                alert.message = "Base de datos copiada con éxito"
            }
            alert.delegate = nil
            alert.addButton(withTitle: "Ok")
            alert.show()*/
        }
    }
    
    class func invokeAlertMethod(_ strTitle: NSString, strBody: NSString, delegate: AnyObject?) {
        let alert: UIAlertView = UIAlertView()
        alert.message = strBody as String
        alert.title = strTitle as String
        alert.delegate = delegate
        alert.addButton(withTitle: "Ok")
        alert.show()
    }

}
