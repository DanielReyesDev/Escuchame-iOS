//
//  GrabarViewController.swift
//  Escuchame
//
//  Created by Daniel Reyes Sánchez on 13/11/16.
//  Copyright © 2016 Daniel Reyes Sánchez. All rights reserved.
//

import UIKit
import googleapis
import AVFoundation

let SAMPLE_RATE = 16000

class GrabarViewController: UIViewController, CustomDismiss  {
    
    var audioData: NSMutableData!
    
    var ONLINE_RECOGNITION:Bool = true {
        willSet(preference){
            ONLINE_RECOGNITION = preference
        }
    }
    
    
    
    private var escuchando:Bool = true
    var oracion=""
    private var dismisses:Int = 0
    var customDismissDelegate:CustomDismiss? = nil
    
    /* OpenEars
    
    var palabras = [String]()
    var slt = Slt()
    var openEarsEventsObserver = OEEventsObserver()
    var fliteController = OEFliteController()
    var usingStartingLanguageModel = Bool()
    var startupFailedDueToLackOfPermissions = Bool()
    var restartAttemptsDueToPermissionRequests = Int()
    var pathToFirstDynamicallyGeneratedLanguageModel: String!
    var pathToFirstDynamicallyGeneratedDictionary: String!
    var pathToSecondDynamicallyGeneratedLanguageModel: String!
    var pathToSecondDynamicallyGeneratedDictionary: String!
    var timer: Timer!
     OpenEars */
    
    var iOS10Available:Bool!
    

    
    /*
    private var _speechRecognizer: AnyObject?
    @available(iOS 10.0, *)
    var speechRecognizer: SpeechRecognizer? {
        get {
            return _speechRecognizer as? SpeechRecognizer
        }
        set {
            _speechRecognizer = newValue
        }
    }*/
    
    
    
    @IBOutlet weak var animatedImageView: UIImageView!
    
    @IBOutlet weak var grabarBtn: BFPaperButton!
    
    
    @IBAction func grabar(_ sender: Any) {
        
        
        if escuchando == false {
            // Visualizando resultados
            escuchando = true
            performSegue(withIdentifier: "toTraducir", sender: nil)
            
        } else {
            // Deteniendo reconocimiento de voz
            escuchando = false
            self.grabarBtn.backgroundColor = UIColor(red:0.01, green:0.79, blue:0.82, alpha:1.00)
            self.grabarBtn.setImage(#imageLiteral(resourceName: "visualize"), for: .normal)
            self.stopAnimation()
            
            
            _ = AudioController.sharedInstance.stop()
            SpeechRecognitionService.sharedInstance.stopStreaming()
            
            
            
        }
        
        
        /*
        if escuchando == false {
            // Visualizando resultados
            escuchando = true
            
            //self.grabarBtn.backgroundColor = UIColor.white
            //self.grabarBtn.setImage(#imageLiteral(resourceName: "record"), for: .normal)
            
            performSegue(withIdentifier: "toTraducir", sender: nil)
        } else {
            // Deteniendo reconocimiento de voz
            escuchando = false
            self.grabarBtn.backgroundColor = UIColor(red:0.01, green:0.79, blue:0.82, alpha:1.00)
            self.grabarBtn.setImage(#imageLiteral(resourceName: "visualize"), for: .normal)
            self.stopAnimation()
            
            
            if ONLINE_RECOGNITION, #available(iOS 10.0, *) {
                print("reconocimiento de voz Online detenido")
                speechRecognizer?.stopSession()
                self.oracion = (speechRecognizer?.getOracion())!
            } else {
                print("reconocimiento de voz OpenEars detenido")
                self.testRecognitionCompleted()
            }
        }
         */
    }
    
    
    
    func startAnimation() {
        var imagesNames = ["lines_00000",
                      "lines_00001",
                      "lines_00002",
                      "lines_00003",
                      "lines_00004",
                      "lines_00005",
                      "lines_00006",
                      "lines_00007",
                      "lines_00008",
                      "lines_00009",
                      "lines_00010",
                      "lines_00011",
                      "lines_00012",
                      "lines_00013",
                      "lines_00014",
                      "lines_00015",
                      "lines_00016",
                      "lines_00017",
                      "lines_00018",
                      "lines_00019",
                      "lines_00020",
                      "lines_00021",
                      "lines_00022",
                      "lines_00023",
                      "lines_00024",
                      "lines_00025",
                      "lines_00026",
                      "lines_00027",
                      "lines_00028",
                      "lines_00029",
                      "lines_00030",
                      "lines_00031",
                      "lines_00032",
                      "lines_00033"
                    ]
        
        
        var images = [UIImage]()
        
        for i in 0..<imagesNames.count {
            images.append(UIImage(named: imagesNames[i])!)
        }
        
        
        animatedImageView.animationImages = images
        animatedImageView.startAnimating()
        
        
    }
    
    func stopAnimation(){
        
        animatedImageView.stopAnimating()
        animatedImageView.image = animatedImageView.animationImages?.last
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        /*
         print("iniciando")
        if ONLINE_RECOGNITION, #available(iOS 10.0, *) {
            //authorizeSR()
            self.speechRecognizer = SpeechRecognizer()
            startAnimation()
        } else {
            if let path = Bundle.main.path(forResource: "lemario-general-del-espanol", ofType: "txt") {
                do {
                    let data = try String(contentsOfFile: path, encoding: .utf8)
                    palabras = data.components(separatedBy: .newlines)
                    print(palabras)
                } catch {
                    print(error)
                }
            }
            openEarsSetup()
            startAnimation()
        }
        */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if dismisses == 2{
            self.dismiss(animated: true, completion: nil)
        } else if dismisses == 3 {
            
            self.dismiss(animated: true, completion: {
                self.customDismissDelegate!.dismissView(withTimes: 3)
            })
        } else {
            AudioController.sharedInstance.delegate = self
            
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSessionCategoryRecord)
            } catch {
                
            }
            audioData = NSMutableData()
            
            
            _ = AudioController.sharedInstance.prepare(specifiedSampleRate: SAMPLE_RATE)
            SpeechRecognitionService.sharedInstance.sampleRate = SAMPLE_RATE
            _ = AudioController.sharedInstance.start()
            
            startAnimation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissView(withTimes times:Int) {
        dismisses = times
        SVProgressHUD.show(withStatus: "Cargando Catálogo")
    }
    
    @IBAction func cerrar(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTraducir" {
            let navigationViewController = segue.destination
            let traducirVC = navigationViewController.childViewControllers[0] as! TraducirViewController
            traducirVC.oracion = oracion
            traducirVC.customDismissDelegate = self
        }
        
        
    }
    

}





extension GrabarViewController: AudioControllerDelegate {
    
    
    func processSampleData(_ data: Data) -> Void {
        audioData.append(data)
        
        // We recommend sending samples in 100ms chunks
        let chunkSize : Int /* bytes/chunk */ = Int(0.1 /* seconds/chunk */
            * Double(SAMPLE_RATE) /* samples/second */
            * 2 /* bytes/sample */);
        
        if (audioData.length > chunkSize) {
            SpeechRecognitionService.sharedInstance.streamAudioData(audioData,
                                                                    completion:
                { [weak self] (response, error) in
                    guard let strongSelf = self else {
                        return
                    }
                    
                    if let error = error {
                        //print(error.localizedDescription)
                    } else if let response = response {
                        var finished = false
                        //print(response)
                        for result in response.resultsArray! {
                            if let result = result as? StreamingRecognitionResult {
                                if result.isFinal {
                                    finished = true
                                    let transcript = result.alternativesArray.firstObject as! SpeechRecognitionAlternative
                                    print("RESULTADO: \(transcript.transcript)")
                                    if let oracionReconocida = transcript.transcript {
                                        self?.oracion = oracionReconocida
                                    }
                                    
                                }
                            }
                        }
                        //print(response.description)
                        /*
                         if finished {
                         strongSelf.grabar(strongSelf)
                         }*/
                    }
            })
            self.audioData = NSMutableData()
        }
    }
}













/*
extension GrabarViewController {
    
    func openEarsSetup() {
        self.openEarsEventsObserver.delegate = self
        self.restartAttemptsDueToPermissionRequests = 0
        self.startupFailedDueToLackOfPermissions = false
        
        let languageModelGenerator = OELanguageModelGenerator()
        
        let firstVocabularyName = "MisPalabras"
        
        
        let firstLanguageModelGenerationError: Error! = languageModelGenerator.generateLanguageModel(from: palabras, withFilesNamed: firstVocabularyName, forAcousticModelAtPath: OEAcousticModel.path(toModel: "AcousticModelSpanish"))
        
        if(firstLanguageModelGenerationError != nil) {
            print("Error while creating initial language model: \(firstLanguageModelGenerationError)")
        } else {
            self.pathToFirstDynamicallyGeneratedLanguageModel = languageModelGenerator.pathToSuccessfullyGeneratedLanguageModel(withRequestedName: firstVocabularyName) // these are convenience methods you can use to reference the file location of a language model that is known to have been created successfully.
            
            
            self.pathToFirstDynamicallyGeneratedDictionary = languageModelGenerator.pathToSuccessfullyGeneratedDictionary(withRequestedName: firstVocabularyName) // these are convenience methods you can use to reference the file location of a dictionary that is known to have been created successfully.
            
            
            self.usingStartingLanguageModel = true // Just keeping track of which model we're using.
            
            
            
            
            
            do {
                try OEPocketsphinxController.sharedInstance().setActive(true) // Setting the shared OEPocketsphinxController active is necessary before any of its properties are accessed.
            }
            catch {
                print("Error: it wasn't possible to set the shared instance to active: \"\(error)\"")
            }
            
            // OEPocketsphinxController.sharedInstance().verbosePocketSphinx = true // If you encounter any issues, set this to true to get verbose logging output from OEPocketsphinxController to either diagnose your issue or provide information when asking for help at the forums.
            
            if(!OEPocketsphinxController.sharedInstance().isListening) {
                OEPocketsphinxController.sharedInstance().startListeningWithLanguageModel(atPath: self.pathToFirstDynamicallyGeneratedLanguageModel, dictionaryAtPath: self.pathToFirstDynamicallyGeneratedDictionary, acousticModelAtPath: OEAcousticModel.path(toModel: "AcousticModelSpanish"), languageModelIsJSGF: false)
        
            }
        }
    }
    
    
    func pocketsphinxDidReceiveHypothesis(_ hypothesis: String!, recognitionScore: String!, utteranceID: String!) {
        print("Local callback: The received hypothesis is \(hypothesis!) with a score of \(recognitionScore!) and an ID of \(utteranceID!)") // Log it.
        if(hypothesis! == "change model") { // If the user says "change model", we will switch to the alternate model (which happens to be the dynamically generated model).
            
            // Here is an example of language model switching in OpenEars. Deciding on what logical basis to switch models is your responsibility.
            // For instance, when you call a customer service line and get a response tree that takes you through different options depending on what you say to it,
            // the models are being switched as you progress through it so that only relevant choices can be understood. The construction of that logical branching and
            // how to react to it is your job OpenEars just lets you send the signal to switch the language model when you've decided it's the right time to do so.
            
            if(self.usingStartingLanguageModel) { // If we're on the starting model, switch to the dynamically generated one.
                OEPocketsphinxController.sharedInstance().changeLanguageModel(toFile: self.pathToSecondDynamicallyGeneratedLanguageModel, withDictionary:self.pathToSecondDynamicallyGeneratedDictionary)
                self.usingStartingLanguageModel = false
                
            } else { // If we're on the dynamically generated model, switch to the start model (this is an example of a trigger and method for switching models).
                OEPocketsphinxController.sharedInstance().changeLanguageModel(toFile: self.pathToFirstDynamicallyGeneratedLanguageModel, withDictionary:self.pathToFirstDynamicallyGeneratedDictionary)
                self.usingStartingLanguageModel = true
            }
        }
        
        print("Heard: \"\(hypothesis!)\"")
        self.oracion = hypothesis
        
        // This is how to use an available instance of OEFliteController. We're going to repeat back 😨 the command that we heard with the voice we've chosen.
        //self.fliteController.say(_:"You said \(hypothesis!)", with:self.slt)
    }
    // An optional delegate method of OEEventsObserver which informs that the interruption to the audio session ended.
    func audioSessionInterruptionDidEnd() {
        print("Local callback:  AudioSession interruption ended.") // Log it.
        //self.statusTextView.text = "Status: AudioSession interruption ended." // Show it in the status box.
        // We're restarting the previously-stopped listening loop.
        if(!OEPocketsphinxController.sharedInstance().isListening){
            OEPocketsphinxController.sharedInstance().startListeningWithLanguageModel(atPath: self.pathToFirstDynamicallyGeneratedLanguageModel, dictionaryAtPath: self.pathToFirstDynamicallyGeneratedDictionary, acousticModelAtPath: OEAcousticModel.path(toModel: "AcousticModelEnglish"), languageModelIsJSGF: false)
            
        }
    }
    
    // An optional delegate method of OEEventsObserver which informs that the audio input became unavailable.
    func audioInputDidBecomeUnavailable() {
        print("Local callback:  The audio input has become unavailable") // Log it.
        //self.statusTextView.text = "Status: The audio input has become unavailable" // Show it in the status box.
        
        if(OEPocketsphinxController.sharedInstance().isListening){
            let stopListeningError: Error! = OEPocketsphinxController.sharedInstance().stopListening() // React to it by telling Pocketsphinx to stop listening since there is no available input (but only if we are listening).
            if(stopListeningError != nil) {
                print("Error while stopping listening in audioInputDidBecomeUnavailable: \(stopListeningError)")
            }
        }
        
        // An optional delegate method of OEEventsObserver which informs that the unavailable audio input became available again.
        func audioInputDidBecomeAvailable() {
            print("Local callback: The audio input is available") // Log it.
            //self.statusTextView.text = "Status: The audio input is available" // Show it in the status box.
            if(!OEPocketsphinxController.sharedInstance().isListening) {
                OEPocketsphinxController.sharedInstance().startListeningWithLanguageModel(atPath: self.pathToFirstDynamicallyGeneratedLanguageModel, dictionaryAtPath: self.pathToFirstDynamicallyGeneratedDictionary, acousticModelAtPath: OEAcousticModel.path(toModel: "AcousticModelEnglish"), languageModelIsJSGF: false) // Start speech recognition, but only if we aren't already listening.
            }
        }
        // An optional delegate method of OEEventsObserver which informs that there was a change to the audio route (e.g. headphones were plugged in or unplugged).
        func audioRouteDidChange(toRoute newRoute: String!) {
            print("Local callback: Audio route change. The new audio route is \(newRoute)") // Log it.
            //self.statusTextView.text = "Status: Audio route change. The new audio route is \(newRoute)"// Show it in the status box.
            let stopListeningError: Error! = OEPocketsphinxController.sharedInstance().stopListening() // React to it by telling Pocketsphinx to stop listening since there is no available input (but only if we are listening).
            if(stopListeningError != nil) {
                print("Error while stopping listening in audioInputDidBecomeAvailable: \(stopListeningError)")
            }
        }
        
        
        
        
        if(!OEPocketsphinxController.sharedInstance().isListening) {
            OEPocketsphinxController.sharedInstance().startListeningWithLanguageModel(atPath: self.pathToFirstDynamicallyGeneratedLanguageModel, dictionaryAtPath: self.pathToFirstDynamicallyGeneratedDictionary, acousticModelAtPath: OEAcousticModel.path(toModel: "AcousticModelEnglish"), languageModelIsJSGF: false) // Start speech recognition, but only if we aren't already listening.
        }
    }
    
    // An optional delegate method of OEEventsObserver which informs that the Pocketsphinx recognition loop has entered its actual loop.
    // This might be useful in debugging a conflict between another sound class and Pocketsphinx.
    func pocketsphinxRecognitionLoopDidStart() {
        
        print("Local callback: Pocketsphinx started.") // Log it.
        //self.statusTextView.text = "Status: Pocketsphinx started." // Show it in the status box.
    }
    
    // An optional delegate method of OEEventsObserver which informs that Pocketsphinx is now listening for speech.
    func pocketsphinxDidStartListening() {
        
        print("Local callback: Pocketsphinx is now listening.") // Log it.
        
    }
    
    // An optional delegate method of OEEventsObserver which informs that Pocketsphinx detected speech and is starting to process it.
    func pocketsphinxDidDetectSpeech() {
        print("Local callback: Pocketsphinx has detected speech.") // Log it.
        //self.statusTextView.text = "Status: Pocketsphinx has detected speech." // Show it in the status box.
    }
    
    // An optional delegate method of OEEventsObserver which informs that Pocketsphinx detected a second of silence, indicating the end of an utterance.
    // This was added because developers requested being able to time the recognition speed without the speech time. The processing time is the time between
    // this method being called and the hypothesis being returned.
    func pocketsphinxDidDetectFinishedSpeech() {
        print("Local callback: Pocketsphinx has detected a second of silence, concluding an utterance.") // Log it.
        //self.statusTextView.text = "Status: Pocketsphinx has detected finished speech." // Show it in the status box.
    }
    
    
    // An optional delegate method of OEEventsObserver which informs that Pocketsphinx has exited its recognition loop, most
    // likely in response to the OEPocketsphinxController being told to stop listening via the stopListening method.
    func pocketsphinxDidStopListening() {
        print("Local callback: Pocketsphinx has stopped listening.") // Log it.
        //self.statusTextView.text = "Status: Pocketsphinx has stopped listening." // Show it in the status box.
    }
    
    // An optional delegate method of OEEventsObserver which informs that Pocketsphinx is still in its listening loop but it is not
    // Going to react to speech until listening is resumed.  This can happen as a result of Flite speech being
    // in progress on an audio route that doesn't support simultaneous Flite speech and Pocketsphinx recognition,
    // or as a result of the OEPocketsphinxController being told to suspend recognition via the suspendRecognition method.
    func pocketsphinxDidSuspendRecognition() {
        print("Local callback: Pocketsphinx has suspended recognition.") // Log it.
        //self.statusTextView.text = "Status: Pocketsphinx has suspended recognition." // Show it in the status box.
    }
    
    // An optional delegate method of OEEventsObserver which informs that Pocketsphinx is still in its listening loop and after recognition
    // having been suspended it is now resuming.  This can happen as a result of Flite speech completing
    // on an audio route that doesn't support simultaneous Flite speech and Pocketsphinx recognition,
    // or as a result of the OEPocketsphinxController being told to resume recognition via the resumeRecognition method.
    func pocketsphinxDidResumeRecognition() {
        print("Local callback: Pocketsphinx has resumed recognition.") // Log it.
        //self.statusTextView.text = "Status: Pocketsphinx has resumed recognition." // Show it in the status box.
    }
    
    // An optional delegate method which informs that Pocketsphinx switched over to a new language model at the given URL in the course of
    // recognition. This does not imply that it is a valid file or that recognition will be successful using the file.
    func pocketsphinxDidChangeLanguageModel(toFile newLanguageModelPathAsString: String!, andDictionary newDictionaryPathAsString: String!) {
        
        print("Local callback: Pocketsphinx is now using the following language model: \n\(newLanguageModelPathAsString!) and the following dictionary: \(newDictionaryPathAsString!)")
    }
    
    // An optional delegate method of OEEventsObserver which informs that Flite is speaking, most likely to be useful if debugging a
    // complex interaction between sound classes. You don't have to do anything yourself in order to prevent Pocketsphinx from listening to Flite talk and trying to recognize the speech.
    func fliteDidStartSpeaking() {
        print("Local callback: Flite has started speaking") // Log it.
        //self.statusTextView.text = "Status: Flite has started speaking." // Show it in the status box.
    }
    
    // An optional delegate method of OEEventsObserver which informs that Flite is finished speaking, most likely to be useful if debugging a
    // complex interaction between sound classes.
    func fliteDidFinishSpeaking() {
        print("Local callback: Flite has finished speaking") // Log it.
        //self.statusTextView.text = "Status: Flite has finished speaking." // Show it in the status box.
    }
    
    func pocketSphinxContinuousSetupDidFail(withReason reasonForFailure: String!) { // This can let you know that something went wrong with the recognition loop startup. Turn on [OELogging startOpenEarsLogging] to learn why.
        print("Local callback: Setting up the continuous recognition loop has failed for the reason \(reasonForFailure), please turn on OELogging.startOpenEarsLogging() to learn more.") // Log it.
        //self.statusTextView.text = "Status: Not possible to start recognition loop." // Show it in the status box.
    }
    
    func pocketSphinxContinuousTeardownDidFail(withReason reasonForFailure: String!) { // This can let you know that something went wrong with the recognition loop startup. Turn on [OELogging startOpenEarsLogging] to learn why.
        print("Local callback: Tearing down the continuous recognition loop has failed for the reason %, please turn on [OELogging startOpenEarsLogging] to learn more.", reasonForFailure) // Log it.
        //self.statusTextView.text = "Status: Not possible to cleanly end recognition loop." // Show it in the status box.
    }
    
    func testRecognitionCompleted() { // A test file which was submitted for direct recognition via the audio driver is done.
        print("Local callback: A test file which was submitted for direct recognition via the audio driver is done.") // Log it.
        if(OEPocketsphinxController.sharedInstance().isListening) { // If we're listening, stop listening.
            let stopListeningError: Error! = OEPocketsphinxController.sharedInstance().stopListening()
            if(stopListeningError != nil) {
                print("Error while stopping listening in testRecognitionCompleted: \(stopListeningError)")
            }
        }
        
    }
    
    /** Pocketsphinx couldn't start because it has no mic permissions (will only be returned on iOS7 or later).*/
    func pocketsphinxFailedNoMicPermissions() {
        print("Local callback: The user has never set mic permissions or denied permission to this app's mic, so listening will not start.")
        self.startupFailedDueToLackOfPermissions = true
        if(OEPocketsphinxController.sharedInstance().isListening){
            let stopListeningError: Error! = OEPocketsphinxController.sharedInstance().stopListening()
            if(stopListeningError != nil) {
                print("Error while stopping listening in pocketsphinxFailedNoMicPermissions: \(stopListeningError). Will try again in 10 seconds.")
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10), execute: {
            if(!OEPocketsphinxController.sharedInstance().isListening) {
                OEPocketsphinxController.sharedInstance().startListeningWithLanguageModel(atPath: self.pathToFirstDynamicallyGeneratedLanguageModel, dictionaryAtPath: self.pathToFirstDynamicallyGeneratedDictionary, acousticModelAtPath: OEAcousticModel.path(toModel: "AcousticModelEnglish"), languageModelIsJSGF: false) // Start speech recognition, but only if we aren't already listening.
            }
        })
    }
    
    
    /** The user prompt to get mic permissions, or a check of the mic permissions, has completed with a true or a false result  (will only be returned on iOS7 or later).*/
    
    func micPermissionCheckCompleted(withResult: Bool) {
        if(withResult) {
            
            self.restartAttemptsDueToPermissionRequests += 1
            if(self.restartAttemptsDueToPermissionRequests == 1 && self.startupFailedDueToLackOfPermissions) { // If we get here because there was an attempt to start which failed due to lack of permissions, and now permissions have been requested and they returned true, we restart exactly once with the new permissions.
                
                if(!OEPocketsphinxController.sharedInstance().isListening) {
                    OEPocketsphinxController.sharedInstance().startListeningWithLanguageModel(atPath: self.pathToFirstDynamicallyGeneratedLanguageModel, dictionaryAtPath: self.pathToFirstDynamicallyGeneratedDictionary, acousticModelAtPath: OEAcousticModel.path(toModel: "AcousticModelEnglish"), languageModelIsJSGF: false) // Start speech recognition, but only if we aren't already listening.
                }
                
                self.startupFailedDueToLackOfPermissions = false
            }
        }
        
    }

}
 */

