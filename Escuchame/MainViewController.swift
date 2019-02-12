//
//  MainViewController.swift
//  Escuchame
//
//  Created by Daniel Reyes Sánchez on 17/12/16.
//  Copyright © 2016 Daniel Reyes Sánchez. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, CustomDismiss {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func dismissView(withTimes times:Int) {
        if times == 3 {
            print("to conceptos...")
            
            performSegue(withIdentifier: "toConceptos", sender: nil)
        }
        
    }
    
    @IBAction func showCatalog(_ sender: Any) {
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEscuchando" {
            
            let defaults = UserDefaults.standard
            print("Online Recognition tiene: \(defaults.bool(forKey: "online_recognition"))")
            
            let escuchandoVC:GrabarViewController = segue.destination as! GrabarViewController
            escuchandoVC.customDismissDelegate = self
            escuchandoVC.ONLINE_RECOGNITION = defaults.bool(forKey: "online_recognition")
            
        } else if segue.identifier == "toConceptos" {
            SVProgressHUD.show(withStatus: "Cargando Catálogo")
        }
    }

}
