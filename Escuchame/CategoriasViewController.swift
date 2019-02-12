//
//  CategoriasViewController.swift
//  Escuchame
//
//  Created by Daniel Reyes Sánchez on 10/12/16.
//  Copyright © 2016 Daniel Reyes Sánchez. All rights reserved.
//

import UIKit

class CategoriasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var speakerButton: BFPaperButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var fraseCollectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var fraseHolderView: UIView!
    let greyishColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.00)
    let darkgreyishColor = UIColor(red:0.92, green:0.93, blue:0.93, alpha:1.00)
    var emptyConceptsImageView:UIImageView!
    var label:UILabel!
    var HABLAR = true
    var categorias = [Int]()
    var conceptos = [Int:[Concepto]]() //también es posible como: Dictionary<Int,Array<Concepto>>
    var respaldoConceptos = [Int:[Concepto]]() //también es posible como: Dictionary<Int,Array<Concepto>>
    var conceptosFrase = [Concepto]()
    let SCREEN_WIDTH = UIScreen.main.bounds.width
    
    
    
    var imagesNames = [
                       "illustrations_cards00002.png",
                       "illustrations_cards00003.png",
                       "illustrations_cards00004.png",
                       "illustrations_cards00005.png",
                       "illustrations_cards00006.png",
                       "illustrations_cards00007.png",
                       "illustrations_cards00008.png",
                       "illustrations_cards00009.png",
                       "illustrations_cards00010.png",
                       "illustrations_cards00011.png",
                       "illustrations_cards00012.png",
                       "illustrations_cards00013.png",
                       "illustrations_cards00014.png",
                       "illustrations_cards00015.png",
                       "illustrations_cards00016.png",
                       "illustrations_cards00017.png",
                       "illustrations_cards00018.png",
                       "illustrations_cards00019.png",
                       "illustrations_cards00020.png",
                       "illustrations_cards00021.png",
                       "illustrations_cards00022.png",
                       "illustrations_cards00023.png",
                       "illustrations_cards00024.png",
                       "illustrations_cards00025.png",
                       "illustrations_cards00026.png",
                       "illustrations_cards00027.png",
                       "illustrations_cards00028.png",
                       "illustrations_cards00029.png",
                       "illustrations_cards00030.png",
                       "illustrations_cards00031.png",
                       "illustrations_cards00032.png",
                       "illustrations_cards00033.png",
                       "illustrations_cards00034.png",
                       "illustrations_cards00035.png",
                       "illustrations_cards00036.png",
                       "illustrations_cards00037.png",
                       "illustrations_cards00038.png",
                       "illustrations_cards00039.png",
                       "illustrations_cards00040.png",
                       "illustrations_cards00041.png",
                       "illustrations_cards00042.png",
                       "illustrations_cards00043.png",
                       "illustrations_cards00044.png",
                       "illustrations_cards00045.png"]
    
    func getAllConceptos(){
        categorias = ModelDB.getInstance().getAllCategorias()
        
        var index = 0
        for category in categorias {
            let concepts = ModelDB.getInstance().getAllConceptos(category)
            conceptos[index] = concepts
            index += 1
        }
        respaldoConceptos = conceptos
        //print(conceptos)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.dismiss()
        self.navigationController?.navigationBar.isTranslucent = false
        getAllConceptos()
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if segmentedControl.selectedSegmentIndex == 1 {
            let misPalabras = ModelDB.getInstance().getMisPalabras()
            if misPalabras.count > 0 {
                vistaConPalabrasPropias(misPalabras)
                vistaEstandar()
                //self.tableView.backgroundColor = darkgreyishColor
                //self.fraseCollectionView.backgroundColor = UIColor.black
            }
            
        } else {
            volverAVistaEstandar()
        }
        self.tableView.reloadData()
    }
    
    /*
    override func viewDidLayoutSubviews() {
        if let rect = self.navigationController?.navigationBar.frame {
            let y = rect.size.height + rect.origin.y
            self.tableView.contentInset = UIEdgeInsetsMake( y, 0, 0, 0)
        }
    }
    */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cambiarVista(_ sender: UISegmentedControl) {
        
        let misPalabras = ModelDB.getInstance().getMisPalabras()
        
        switch sender.selectedSegmentIndex {
            case 1:
                if misPalabras.count > 0 {
                    vistaConPalabrasPropias(misPalabras)
                } else {
                    vistaSinPalabrasPropias()
                }
                break
           default:
                //view.backgroundColor = greyishColor
                if misPalabras.count == 0 {
                    vistaEstandar()
                } else {
                    volverAVistaEstandar()
                }
                break
        }
        
    }
    
    func vistaEstandar(){
        print("Categorías")
        self.tableView.isHidden = false
        self.fraseCollectionView.isHidden = false
        if label != nil {
            label.isHidden = true
            
        }
        if emptyConceptsImageView != nil {
            emptyConceptsImageView.isHidden = true
        }
        
        self.fraseCollectionView.backgroundColor = UIColor.white
        HABLAR = true
        speakerButton.setImage(conceptosFrase.isEmpty ? #imageLiteral(resourceName: "speaker") : #imageLiteral(resourceName: "speaker_sound"), for: .normal)
    }
    
    func volverAVistaEstandar() {
        self.conceptos = self.respaldoConceptos
        self.tableView.reloadData()
    }
    
    func vistaConPalabrasPropias(_ misPalabras:[Concepto]){
        self.tableView.backgroundColor = darkgreyishColor
        self.conceptos.removeAll(keepingCapacity: false)
        self.conceptos[0] = misPalabras
        self.tableView.reloadData()
    }
    
    
    
    func startAnimation(){
        
        if #available(iOS 8.0, *) {
            var images = [UIImage]()
            for i in 0..<imagesNames.count {
                images.append(UIImage(named: imagesNames[i])!)
            }
            emptyConceptsImageView.image = images.last
            emptyConceptsImageView.animationDuration = 1.85
            emptyConceptsImageView.animationImages = images
            emptyConceptsImageView.animationRepeatCount = 1
            emptyConceptsImageView.startAnimating()
        } else {
            emptyConceptsImageView.image = UIImage(named: "illustrations_cards00045.png")!
        }
        
        
    }
    
    
    func vistaSinPalabrasPropias() {
        self.tableView.isHidden = true
        self.fraseCollectionView.isHidden = true
        //view.backgroundColor = darkgreyishColor
        //let img:UIImage = UIImage(named: "illustrations_cards00000.png")!
        //let imgSize = img.topCapHeight
        self.emptyConceptsImageView = UIImageView(image: nil)
        //self.emptyConceptsImageView.backgroundColor = greyishColor
        let bounds = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: tableView.bounds.height - 30)
        self.emptyConceptsImageView.frame = bounds
        self.emptyConceptsImageView.contentMode = .scaleAspectFit
        
        var scaleFactor:CGFloat = 1
        var device = "regular"
        if SCREEN_WIDTH >= 768 {
            scaleFactor = 2
            device = "iPad"
        }
        
        self.label = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: self.emptyConceptsImageView.bounds.height - (60*scaleFactor)),size: CGSize(width: self.view.frame.width,height: (30*scaleFactor))))
        self.label.text = "Agrega tus palabras"
        self.label.textAlignment = .center
        self.label.font = label.font.withSize((device == "iPad" ? 40 : 20))
        //self.label.center.x = self.view.center.x
        //self.label.center.y =
        
        
        self.fraseCollectionView.backgroundColor = greyishColor
        self.fraseHolderView.backgroundColor = greyishColor
        
        view.addSubview(emptyConceptsImageView)
        view.addSubview(label)
        HABLAR = false
        speakerButton.setImage(#imageLiteral(resourceName: "add2"), for: .normal)
        startAnimation()
    }
    
    
    @IBAction func agregarConcepto(_ sender: Any) {
        performSegue(withIdentifier: "toAgregar", sender: nil)
    }
    
    
    @IBAction func funcionPrincipal(_ sender: Any) {
        if HABLAR {
            performSegue(withIdentifier: "toHablando", sender: nil)
        } else {
            performSegue(withIdentifier: "toAgregar", sender: nil)
        }
    }
    
    
    @IBAction func cerrar(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            return categorias.count
        } else {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriaCell", for: indexPath)
        
        return cell
    }
    
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
     */
    
    func tableView(_ tableView: UITableView,willDisplay cell: UITableViewCell,forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? ConceptosTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self as UICollectionViewDataSource & UICollectionViewDelegate, forRow: indexPath.row)
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toHablando" {
            
            let hablandoViewController:HablandoViewController = segue.destination as! HablandoViewController
            
            hablandoViewController.conceptosFrase = self.conceptosFrase
        }
    }
    

}









extension CategoriasViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.fraseCollectionView {
            return conceptosFrase.count
        } else {
            if segmentedControl.selectedSegmentIndex == 0 {
                return (conceptos[collectionView.tag]?.count)!
            } else {
                return (conceptos[0]?.count)!
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
        if collectionView == self.fraseCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConceptoListaCell", for: indexPath) as! ConceptoListaCell
            cell.concepto = conceptosFrase[indexPath.row]
            
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConceptoCell", for: indexPath) as! ConceptoCell
            cell.concepto = conceptos[collectionView.tag]?[indexPath.row]
            return cell
            
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        if collectionView == self.fraseCollectionView {
            self.conceptosFrase.remove(at: indexPath.row)
            self.fraseCollectionView.deleteItems(at: [indexPath])
            
            if conceptosFrase.isEmpty {
                speakerButton.setImage(#imageLiteral(resourceName: "speaker"), for: .normal)
            }
        } else {
            self.conceptosFrase.append((conceptos[collectionView.tag]?[indexPath.row])!)
            self.fraseCollectionView.reloadData()
            
            if !conceptosFrase.isEmpty{
                speakerButton.setImage(#imageLiteral(resourceName: "speaker_sound"), for: .normal)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView != self.fraseCollectionView {
            
            //collectionView.frame.size = CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.width)
            //viewDidLayoutSubviews()
            
            var widthFactor:CGFloat = collectionView.bounds.size.width
            
            if SCREEN_WIDTH >= 700 && SCREEN_WIDTH < 1024{
                widthFactor = collectionView.bounds.size.width/2
            } else if SCREEN_WIDTH >= 1024 {
                widthFactor = collectionView.bounds.size.width/2.5
            }
            
            
            print("width: \(collectionView.bounds.size.width) height: \(collectionView.bounds.size.height)")
            
            let width = floor((widthFactor)*0.7)
            let height = floor(width*16/13)
            
            
            //collectionView.autoresizesSubviews = true
            
            print("-> width: \(width) -> height: \(height)")
            
            return CGSize(width: width, height: height)
        } else {
            print("ELSE 80 80")
            return CGSize(width: 80, height: 80)
        }
        
    }
}
