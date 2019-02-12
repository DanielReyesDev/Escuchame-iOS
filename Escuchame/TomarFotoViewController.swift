//
//  TomarFotoViewController.swift
//  Escuchame
//
//  Created by Daniel Reyes Sánchez on 14/12/16.
//  Copyright © 2016 Daniel Reyes Sánchez. All rights reserved.
//

import UIKit
import AVFoundation

class TomarFotoViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIScrollViewDelegate {
    
    //vista detrás del uiimage
    @IBOutlet weak var frameForCapture: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var session:AVCaptureSession?
    // deprecado en iOS 10 - var stillImageOutput:AVCaptureStillImageOutput = AVCaptureStillImageOutput()
    // iOS 10 - var photoOutput:AVCapturePhotoOutput = AVCapturePhotoOutput()
    var photoOutput:AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    let screenSize = UIScreen.main.bounds
    var camera:AVCaptureDevice!
    let FRONT_CAMERA = true
    let BACK_CAMERA = false
    var CAMERA_STATE = false
    //var imageView:UIImageView!
    var TAKEN_PHOTO = false
    
    
    let picker = UIImagePickerController()
    
    @IBOutlet weak var takenPhotoImageView: UIImageView!
    @IBOutlet weak var takePhotoButton: BFPaperButton!
    @IBOutlet weak var selfieButton: UIButton!
    @IBOutlet weak var chooseImageButton: UIButton!
    @IBOutlet weak var nombreTextField: UITextField!
    //@IBOutlet weak var retakePhotoButton: BFPaperButton!
    let retakePhotoButton:BFPaperButton = BFPaperButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50), raised: true)
    //UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50)) as! BFPaperButton
    
    var isChoosingImage = false
    
    var KEYBOARD_HEIGHT:CGFloat!
    //let SCREEN_HEIGHT = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)

        
        self.picker.delegate = self
        nombreTextField.delegate = self
        scrollView.delegate = self
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TomarFotoViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            self.KEYBOARD_HEIGHT = keyboardHeight
        }
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
   
    /*
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //print("height screen: \(SCREEN_HEIGHT)")
        
        //scrollView.scrollRectToVisible(CGRect(x: scrollView.contentSize.width - 1, y: scrollView.contentSize.height - 1, width: 1, height: 1), animated: true)
        /*if SCREEN_HEIGHT >= 736 {
            
        } else {
            scrollView.setContentOffset(CGPoint(x:0, y:20), animated: true)
        }*/
        /*
        UIView.animate(withDuration: 0.25) { 
            self.scrollView.setContentOffset(CGPoint(x:0, y:5), animated: true)
        }*/
        
        if textField == self.nombreTextField {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    self.scrollView.contentOffset.y = 10
                }, completion: nil)
            }
            
        }
        
        
    }*/
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.nombreTextField {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    self.scrollView.contentOffset.y = -66
                }, completion: nil)
            }
            
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.nombreTextField {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    self.scrollView.contentOffset.y = self.KEYBOARD_HEIGHT/3
                }, completion: nil)
            }
            
        }
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !isChoosingImage {
            // Instanciando los objetos AVCaptureSession y AVCaptureStillImageOutput 1 sola vez
            // y configurando la calidad de la foto
            retakePhotoButton.isHidden = true
            takenPhotoImageView.isHidden = true
            nombreTextField.isHidden = true
            
            session = AVCaptureSession()
            session!.sessionPreset = AVCaptureSessionPresetPhoto // AVCaptureSessionPresetMedium
            photoOutput = AVCaptureStillImageOutput()
            createSession(withCamera: BACK_CAMERA)
            
            
            //Old... revisar en más dispositivos
            //frameForCapture.frame = CGRect(x: 0, y: 0, width: screenSize.width*UIScreen.main.scale, height: screenSize.width*UIScreen.main.scale)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = frameForCapture.bounds
        
        print("height superview: ", screenSize.height)
        print("width superview: ", screenSize.width)
    }
    
    
    @IBAction func switchCamera(_ sender: Any) {
        //finishSession()
        /*
        if imageView != nil {
            self.imageView.removeFromSuperview()
        }
         */
        
        CAMERA_STATE = !CAMERA_STATE
        print("CAMERA_STATE: \(CAMERA_STATE)")
        createSession(withCamera: CAMERA_STATE)
    }
    
    
    func finishSession(){
        DispatchQueue.main.async {
            self.session?.stopRunning()
        }
        
        previewLayer?.removeFromSuperlayer()
    }
    
    
    func activateFrontCamera(_ ACTIVATE: Bool) -> AVCaptureDevice{
        
        if ACTIVATE {
            let videoDevices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo)
            
            for device in videoDevices!{
                let device = device as! AVCaptureDevice
                if device.position == AVCaptureDevicePosition.front {
                    self.selfieButton.setImage(#imageLiteral(resourceName: "back_camera"), for: .normal)
                    return device
                }
            }
        }
        self.selfieButton.setImage(#imageLiteral(resourceName: "front_camera"), for: .normal)
        return AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) as AVCaptureDevice
    }
    
    
    
    func createSession(withCamera cam: Bool) {
        
        
        camera = activateFrontCamera(cam)
        
        var error: NSError?
        var input: AVCaptureDeviceInput!
        
        do {
            input = try AVCaptureDeviceInput(device: camera)
        } catch let error1 as NSError {
            error = error1
            input = nil
        }
        
        for i : AVCaptureDeviceInput in (self.session?.inputs as! [AVCaptureDeviceInput]){
            self.session?.removeInput(i)
        }
        
        if error == nil && session!.canAddInput(input) {
            
            session!.addInput(input)
            
            
            photoOutput!.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            
            if session!.canAddOutput(photoOutput){
                session!.addOutput(photoOutput)
                previewLayer = AVCaptureVideoPreviewLayer(session: session)
                previewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
                                           //AVLayerVideoGravityResize
                                           //AVLayerVideoGravityResizeAspect
                
                previewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                frameForCapture.layer.addSublayer(previewLayer!)
                DispatchQueue.main.async {
                    self.session!.startRunning()
                }
                
                
                /*
                previewLayer!.bounds = frameForCapture.frame
                frameForCapture.bounds = frameForCapture.frame
                frameForCapture.layer.masksToBounds = true
                previewLayer?.masksToBounds = true
                frameForCapture.bounds = frameForCapture.frame
                frameForCapture.clipsToBounds = true
                */
            }
        }
        
        /*
        let devices = AVCaptureDevice.devices().filter{
            ($0 as AnyObject).hasMediaType(AVMediaTypeVideo) && ($0 as AnyObject).position == AVCaptureDevicePosition.back
        }
        */
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseImage(_ sender: UIButton) {
        isChoosingImage = true
        //self.takenPhotoImageView.backgroundColor = UIColor.black
        print("Choosing Image")
        
        
        
        
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.modalPresentationStyle = .pageSheet
        present(picker,animated:true, completion:nil)
        //picker.popoverPresentationController?.barButtonItem = sender
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("didFinishPickingMediaWithInfo")
        self.finishSession()
        self.takenPhotoImageView.isHidden = false
        
        var  chosenImage = UIImage()
        
        //chosenImage = info[UIImagePickerControllerCropRect] as! UIImage
        let rect = info[UIImagePickerControllerCropRect] as! CGRect
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        var imageRef = originalImage.cgImage!.cropping(to: rect)
        chosenImage = UIImage(cgImage: imageRef!, scale: originalImage.scale, orientation: originalImage.imageOrientation)
        imageRef = nil
        takenPhotoImageView.contentMode = .scaleAspectFit
        takenPhotoImageView.image = chosenImage
        //dismiss(animated:true, completion: nil)
        
        
        
        dismiss(animated: true) { 
            self.isChoosingImage = false
            self.nombreTextField.isHidden = false
            self.TAKEN_PHOTO = true
            
            self.takePhotoButton.backgroundColor = UIColor(red:0.01, green:0.79, blue:0.82, alpha:1.00)
            self.takePhotoButton.setImage(#imageLiteral(resourceName: "shot_ok"), for: UIControlState.normal)
            self.selfieButton.isHidden = true
            self.chooseImageButton.isHidden = true
            self.retakePhotoButton.isHidden = false
            self.retakePhotoButton.setImage(#imageLiteral(resourceName: "retake"), for: .normal)
            
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //self.isChoosingImage = false
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tomarFoto(_ sender: UIButton) {
        print("TOMANDO FOTO...")
        if !TAKEN_PHOTO {
            if let viewConnection = photoOutput!.connection(withMediaType: AVMediaTypeVideo){
                
                
                photoOutput!.captureStillImageAsynchronously(from: viewConnection, completionHandler: {(sampleBuffer, error) in
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    let dataProvider = CGDataProvider(data: imageData as! CFData)
                    let cgImageRef = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: .defaultIntent)
                    
                    var image = UIImage(cgImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.right)
                    image = self.cropImageToSquare(image: image)!
                    
                    //self.takenPhotoImageView = UIImageView(image: image)
                    self.frameForCapture.addSubview(self.takenPhotoImageView)
                    self.takenPhotoImageView.isHidden = false
                    self.takenPhotoImageView.image = image
                    //
                    //self.imageView.frame = self.frameForCapture.bounds
                    //self.imageView.addSubview(self.retakePhotoButton)
                    
                    self.takePhotoButton.backgroundColor = UIColor(red:0.01, green:0.79, blue:0.82, alpha:1.00)
                    self.takePhotoButton.setImage(#imageLiteral(resourceName: "shot_ok"), for: UIControlState.normal)
                    self.selfieButton.isHidden = true
                    self.chooseImageButton.isHidden = true
                    
                    
                    
                    
                    self.retakePhotoButton.cornerRadius = 25
                    self.retakePhotoButton.backgroundColor = UIColor.white
                    self.retakePhotoButton.setImage(#imageLiteral(resourceName: "retake"), for: .normal)
                    self.retakePhotoButton.isHidden = false
                    
                    self.retakePhotoButton.addTarget(self, action: #selector(self.retomarFoto(_:)), for: .touchUpInside)
                    self.retakePhotoButton.translatesAutoresizingMaskIntoConstraints = false
                    self.frameForCapture.addSubview(self.retakePhotoButton)
                    
                    
                    let heightConstraint = NSLayoutConstraint(item: self.retakePhotoButton, attribute:NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute(rawValue: 0)!, multiplier: 1, constant:50)
                    let widthConstraint = NSLayoutConstraint(item: self.retakePhotoButton, attribute:NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute(rawValue: 0)!, multiplier: 1, constant:50)
                    let xConstraint = NSLayoutConstraint(item: self.retakePhotoButton, attribute:NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.takenPhotoImageView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant:0)
                    let yConstraint = NSLayoutConstraint(item: self.retakePhotoButton, attribute:NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.takenPhotoImageView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant:0)
                    
                    NSLayoutConstraint.activate([widthConstraint, heightConstraint, xConstraint, yConstraint])
                    

                    self.nombreTextField.isHidden = false
                    
                    self.TAKEN_PHOTO = true
                    
                    //let bgcolor = UIColor(red:0.00, green:0.85, blue:0.80, alpha:1.00)
                    //self.takePhotoButton.inputView?.backgroundColor = bgcolor
                })
                
            }
        } else {
            // insertar en la base de datos
            let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
            let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
            let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
            //let imagePath:String
            
            if !paths.isEmpty {
                if paths.count > 0 {
                    if let dirPath = paths[0] as? String {
                        
                        /*
                         let image = self.takenPhotoImageView.image
                         
                         let nombreImagen:String = "escuchame_" + self.nombreTextField.text! + ".jpg"
                         //let writePath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(nombreImagen)
                         
                         let imageData = UIImageJPEGRepresentation(image!,0.2)
                         //let relativePath = "image_\(Date.timeIntervalSinceReferenceDate).jpg"
                         let imagePath = fileInDocumentsDirectory(nombreImagen)
                         try? imageData!.write(to: URL(fileURLWithPath: imagePath), options: [.atomic])
                         print(imagePath)
                         */
                        
                        
                        let image = self.takenPhotoImageView.image
                        
                        let nombreImagen:String = "escuchame_" + self.nombreTextField.text! + ".png"
                        //let writePath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(nombreImagen)
                        
                        let imageData = UIImageJPEGRepresentation(image!,0.2)
                        //let relativePath = "image_\(Date.timeIntervalSinceReferenceDate).jpg"
                        let imagePath = fileInDocumentsDirectory(nombreImagen)
                        try? imageData!.write(to: URL(fileURLWithPath: imagePath), options: [.atomic])
                        print(imagePath)
                        
                        
                        /*
                         NSUserDefaults.standardUserDefaults().setObject(relativePath, forKey: "path_image")
                         NSUserDefaults.standardUserDefaults().synchronize()
                         */
                        
                        
                        //let newConcept:Concepto = Concepto(self.nombreTextField.text!, image)
                        ModelDB.getInstance().agregarConcepto(self.nombreTextField.text!, imagePath)
                        
                        print("agrgeado correctamente!")
                        
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    
    func getDocumentsURL() -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsURL
    }
    
    func fileInDocumentsDirectory(_ filename: String) -> String {
        
        let fileURL = getDocumentsURL().appendingPathComponent(filename)
        return fileURL.path
        
    }
    
    
    
    @IBAction func retomarFoto(_ sender: Any) {
        print("retomarFoto...")
        self.takePhotoButton.backgroundColor = UIColor.clear
        self.takenPhotoImageView.isHidden = true
        self.selfieButton.isHidden = false
        self.chooseImageButton.isHidden = false
        self.retakePhotoButton.isHidden = true
        self.nombreTextField.text = ""
        self.nombreTextField.isHidden = true
        self.takePhotoButton.setImage(#imageLiteral(resourceName: "shot"), for: UIControlState.normal)
        self.TAKEN_PHOTO = false
        print("session: \(session?.isRunning)")
        if session?.isRunning == false {
            self.session = AVCaptureSession()
            self.session!.sessionPreset = AVCaptureSessionPresetPhoto // AVCaptureSessionPresetMedium
            self.photoOutput = AVCaptureStillImageOutput()
            self.createSession(withCamera: BACK_CAMERA)
        }
    }
    
    func cropImageToSquare(image: UIImage) -> UIImage? {
        var imageHeight = image.size.height
        var imageWidth = image.size.width
        
        if imageHeight > imageWidth {
            imageHeight = imageWidth
        }
        else {
            imageWidth = imageHeight
        }
        
        let size = CGSize(width: imageWidth, height: imageHeight)
        
        let refWidth : CGFloat = CGFloat(image.cgImage!.width)
        let refHeight : CGFloat = CGFloat(image.cgImage!.height)
        
        let x = (refWidth - size.width) / 2
        let y = (refHeight - size.height) / 2
        
        let cropRect = CGRect(x: x, y: y, width: size.height, height: size.width)
        if let imageRef = image.cgImage!.cropping(to: cropRect) {
            return UIImage(cgImage: imageRef, scale: 0, orientation: image.imageOrientation)
        }
        
        return nil
    }

    @IBAction func cerrar(_ sender: Any) {
        print("cerrando...")
        self.dismiss(animated: true, completion: nil)
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
