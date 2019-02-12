//
//  HablandoViewController.swift
//  Escuchame
//
//  Created by Daniel Reyes Sánchez on 13/12/16.
//  Copyright © 2016 Daniel Reyes Sánchez. All rights reserved.
//

import UIKit
import AVFoundation

class HablandoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, AVSpeechSynthesizerDelegate {
    
    @IBOutlet weak var animatedImageView: UIImageView!
    @IBOutlet weak var fraseCollectionView: UICollectionView!
    var conceptosFrase:[Concepto] = [Concepto]()
    let speechSynthesizer = AVSpeechSynthesizer()
    var speechVoice : AVSpeechSynthesisVoice?
    var index = 0
    let animationDuration: TimeInterval = 0.25
    let switchingInterval: TimeInterval = 3
    @IBOutlet weak var pauseButton: BFPaperButton!
    
    // animacion de scroll
    var w:CGFloat=0.0
    
    var indexElementos:Int = 0
    
    var images = [UIImage]()
    
    
    var noPalabraActual = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("numero de palabras: \(conceptosFrase.count)")
        
        self.speechSynthesizer.delegate = self
        self.speechVoice = AVSpeechSynthesisVoice(language: "es-MX")
        self.pauseButton.isHidden = true
        
        DispatchQueue.main.async {
            self.reproducir()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.startAnimation()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func mensajeInicio(){
        print("Iniciando...")
    }
    
    
    func startAnimation() {
        
        
        for i in 0..<27 {
            let path = Bundle.main.path(forResource: "bocina_\(i)", ofType: "png")
            images.append(UIImage(contentsOfFile: path!)!)
        }
        
        
        animatedImageView.animationImages = images
        images.removeAll()
        //animatedImageView.animationDuration = 3
        animatedImageView.startAnimating()
        
        
        
    }
    
    
    var currentPhotoID = -1
    func cycleBackgroundImages() {
        if currentPhotoID < 25 { currentPhotoID += 1 }
        else { currentPhotoID = 0 }
        
        
        if conceptosFrase.count == noPalabraActual {
            CATransaction.disableActions()
            return
        }
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(1.0)
        
        CATransaction.setCompletionBlock {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0001) {
                self.cycleBackgroundImages()
            }
        }
        
        
        let name = "bocina_\(currentPhotoID)"
        
        let path = Bundle.main.path(forResource: name, ofType: "png")
        animatedImageView.image =  UIImage(contentsOfFile: path!)
        
        CATransaction.commit()
    }
    
    
    
    
    func reproducir(){
        
        let delay:TimeInterval = 0.35
        
        for concepto in conceptosFrase{
            let speechUtterance = AVSpeechUtterance(string: concepto.nombre)
            speechUtterance.postUtteranceDelay = delay
            speechUtterance.preUtteranceDelay = delay
            
            if #available(iOS 10.0, *) {
                speechUtterance.rate = 0.4
            } else {
                speechUtterance.rate = 0.1
            }
            //speechUtterance.rate = 0.1
            speechUtterance.pitchMultiplier = 1.25
            speechUtterance.volume = 0.75
            speechSynthesizer.speak(speechUtterance)
        }
        
        
        
    }
    
    
    
    

    
    // animando el collection view
    func autoScrollView(){
        print("moviendo el collection view...")
        if w < fraseCollectionView.contentSize.width{
            self.w += 135
        }
        
        let offsetPoint = CGPoint(x: w,y :0)
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                self.fraseCollectionView.contentOffset=offsetPoint
            })
        }
    }
    
    
    
    @IBAction func cerrar(_ sender: Any) {
        speechSynthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
    
    
    
    // Called before speaking an utterance
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("A punto de decir... '\(utterance.speechString)'")
        
        
    }
    
    // Called when the synthesizer is finished speaking the utterance
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("Ha finalizado de decir... \(indexElementos) '\(utterance.speechString)");
        if indexElementos == conceptosFrase.count {
            print("se ha terminado de decir toda la oración...")
            dismiss(animated: true, completion: nil)
        }
    }
    
    // This method is called before speaking each word in the utterance.
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        
        
        let startIndex = utterance.speechString.characters.index(utterance.speechString.startIndex, offsetBy: characterRange.location)
        let endIndex = utterance.speechString.characters.index(startIndex, offsetBy: characterRange.length)
        
        print("El sintetizador dirá la palabra... '\(utterance.speechString.substring(with: startIndex..<endIndex))'");
        indexElementos += 1
        if indexElementos >= 3 {
            autoScrollView()
        }
    }
    

    
    
    
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return conceptosFrase.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConceptoFraseCell", for: indexPath) as! ConceptoFraseCell
        cell.concepto = conceptosFrase[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.conceptosFrase.remove(at: indexPath.row)
        self.fraseCollectionView.deleteItems(at: [indexPath])
    }

}
