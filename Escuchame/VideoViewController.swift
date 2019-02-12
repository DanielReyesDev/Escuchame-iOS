//
//  VideoViewController.swift
//  Escuchame
//
//  Created by Daniel Reyes Sánchez on 22/02/17.
//  Copyright © 2017 Daniel Reyes Sánchez. All rights reserved.
//

import UIKit
import AVFoundation

class VideoViewController: UIViewController {

    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var playButton: BFPaperButton!
    @IBOutlet weak var progressView: UIProgressView!
    
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var videoName:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController!.navigationBar.tintColor = UIColor(red:0.14, green:0.82, blue:0.78, alpha:1.00)
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        //self.navigationController?.navigationBar.backItem?.title = " "
        self.navigationController?.navigationBar.topItem?.title = ""
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //self.navigationItem.leftBarButtonItem?.title = ""
        
        
        self.progressView.isHidden = true
        self.playButton.isHidden = true
        
        let URL = Bundle.main.url(forResource: videoName!, withExtension: "mov")
        player = AVPlayer.init(url: URL!)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        player.actionAtItemEnd = AVPlayerActionAtItemEnd.none
        player.play()
        videoView.layer.insertSublayer(playerLayer, at: 0)
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = videoView.layer.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
