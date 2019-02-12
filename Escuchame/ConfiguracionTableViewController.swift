//
//  ConfiguracionTableViewController.swift
//  Escuchame
//
//  Created by Daniel Reyes Sánchez on 25/12/16.
//  Copyright © 2016 Daniel Reyes Sánchez. All rights reserved.
//

import UIKit

class ConfiguracionTableViewController: UITableViewController,UIAlertViewDelegate {

    @IBOutlet weak var speechRecognizerSwitch: UISwitch!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speechRecognizerSwitch.setOn(defaults.bool(forKey: "online_recognition"), animated: true)
        //self.tableView.select
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeSpeechRecognizerType(_ sender: Any) {
        
        //.value(forKey: "online_recognition")
        
        if speechRecognizerSwitch.isOn {
            defaults.set(true, forKey: "online_recognition")
        } else {
            defaults.set(false, forKey: "online_recognition")
        }
        defaults.synchronize()
        
    }
    
    @IBAction func cerrar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source  
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            // Restablecer imágenes
            let alertView = UIAlertView(title: "Reestablecer Imágenes", message: "Esta acción no se puede deshacer. ¿Desea continuar?", delegate: self, cancelButtonTitle: "Cancelar", otherButtonTitles: "Aceptar")
            
            
            alertView.show()
        } else if indexPath.section == 1{
            // Reportar un Problema
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string:"https://escuchameapp.com/contacto")!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(URL(string:"https://escuchameapp.com/contacto")!)
            }
            
            // considerar el caso contrario con un alertview u otra vista para ambos casos
            /*
            if #available(iOS 8.0, *) {
                let alertController = UIAlertController(title: "Reportar un Problema", message: "Escribe tu mensaje", preferredStyle: .alert)
                let reportarAction = UIAlertAction(title: "Reportar", style: .destructive) { action in
                    
                    if let mensaje:String = alertController.textFields?[0].text {
                        print("Enviando al servidor... \(mensaje)")
                    }
                }
                alertController.addTextField(configurationHandler: { textField in
                    textField.placeholder = "Problema"
                })
                alertController.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
                alertController.addAction(reportarAction)
                self.present(alertController, animated:true)
            }
            */
            
            
            
            
        } else {
            //nada
        }
    }
    
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        switch buttonIndex {
        case 1:
            print("Aceptar")
            eliminarMisPalabras()
            self.dismiss(animated: true, completion: nil)
        default:
            print("Cancelar")
            
        }
    }
    
    
    
    func removeImage(_ imagen:String) {
        let fileManager = FileManager.default
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        guard let dirPath = paths.first else {
            return
        }
        do {
            try fileManager.removeItem(atPath: imagen)
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    
    func eliminarMisPalabras() {
        let misPalabras = ModelDB.getInstance().getRutasMisPalabras()
        if misPalabras.count > 0 {
            for palabra in misPalabras {
                removeImage(palabra)
            }
            ModelDB.getInstance().eliminarMisPalabras()
        }
        
        
    }
    
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
