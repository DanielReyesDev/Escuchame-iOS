//
//  InfoViewController.swift
//  Escuchame
//
//  Created by Daniel Reyes Sánchez on 18/12/16.
//  Copyright © 2016 Daniel Reyes Sánchez. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    let textToShare = "Escúchame App. Descárgala ya en la AppStore: "
    let webPage = URL(string: "http://escuchameapp.com")
    var activityViewController:UIActivityViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        activityViewController = UIActivityViewController(activityItems: [textToShare, webPage], applicationActivities: [])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cerrar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func compartir(_ sender: Any) {
        
        present(activityViewController, animated: true)
        
    }
    @IBAction func abrirTerminos(_ sender: UIButton) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string:"http://escuchameapp.com/terminos/")!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL(string:"http://escuchameapp.com/terminos/")!)
        }
    }
    
    @IBAction func abrirPagina(_ sender: UIButton) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string:"http://escuchameapp.com")!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL(string:"http://escuchameapp.com")!)
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
