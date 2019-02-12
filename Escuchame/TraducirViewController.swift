//
//  TraducirViewController.swift
//  Escuchame
//
//  Created by Daniel Reyes Sánchez on 15/11/16.
//  Copyright © 2016 Daniel Reyes Sánchez. All rights reserved.
//

import UIKit

protocol CustomDismiss {
    func dismissView(withTimes times:Int)
}

class TraducirViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var tarjetasCollectionView: UICollectionView!
    
    @IBOutlet weak var imgTarjeta: UIImageView!
    
    @IBOutlet weak var lblTarjeta: UILabel!
    @IBOutlet weak var viewTarjeta: UIView!
    var customDismissDelegate:CustomDismiss? = nil
    
    
    var oracion = ""
    var conceptos:[Concepto]!
    
    
    var availableVideos:[Int:String] = [Int:String]()
    var manitaSeleccionada:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("-------------------")
        print(oracion)
        print("-------------------")
        
        
        
        let palabras : [String] = oracion.components(separatedBy: " ")
        conceptos = ModelDB.getInstance().getRelatedConcepts(withWords: palabras)
        print(conceptos)
        
        /*
        if oracion == "Cómo estás" {
            let palabras : [String] = oracion.components(separatedBy: ".")
            conceptos = ModelDB.getInstance().getRelatedConcepts(withWords: palabras)
        } else {
            let palabras : [String] = oracion.components(separatedBy: " ")
            conceptos = ModelDB.getInstance().getRelatedConcepts(withWords: palabras)
            print(conceptos)
        }*/
        
        
        
        
        tarjetasCollectionView.delegate = self
        tarjetasCollectionView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cerrar(_ sender: Any) {
        if (customDismissDelegate != nil) {
            customDismissDelegate!.dismissView(withTimes: 2)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nuevaFrase(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func redirigirHaciaConceptos(_ sender: Any) {
        if (customDismissDelegate != nil) {
            customDismissDelegate!.dismissView(withTimes: 3)
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return conceptos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ConceptoCell
        
        cell.manoButton.isHidden = true
        
        let imageName = conceptos[indexPath.row].nombre
        
        print("IMAGENAME: \(imageName)")
        //let videoName = String(imageName.characters.dropLast(4))
        let videoName = imageName.lowercased()
        print("VIDEONAME: \(videoName)")
        if Bundle.main.url(forResource: String(videoName), withExtension: "mov") != nil {
            cell.manoButton.isHidden = false
            cell.manoButton.addTarget(self, action: #selector(mostrarVideo(_:)), for: .touchUpInside)
            
            availableVideos[cell.manoButton.tag] = videoName
        }
        
        
        
        
        //String(self.allergies.characters.dropLast(2))
        
        //Bundle.main.url(forResource: "como_estas", withExtension: "mov")
        
        
        cell.titulo.text = conceptos[indexPath.row].nombre
        if let img = conceptos[indexPath.row].imagen {
            cell.imagen.image = img
        }
        
        return cell

    }
    
    func mostrarVideo(_ sender : UIButton) {
        print("MANITA DEL CONCEPTO #\(sender.tag)")
        manitaSeleccionada = sender.tag
        performSegue(withIdentifier: "toVideoSign", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        
        
        let width = floor(collectionView.bounds.size.width*0.7)
        let height = floor(width*16/13)
        return CGSize(width: width, height: height)
        
    }
 
    
    
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toVideoSign" {
            let vc = segue.destination as! VideoViewController
            vc.videoName = availableVideos[manitaSeleccionada]
        }
    }
    

}
