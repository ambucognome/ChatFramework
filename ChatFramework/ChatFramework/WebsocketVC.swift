//
//  WebsocketVC.swift
//  Companion
//
//  Created by Ambu Sangoli on 27/09/22.
//

import UIKit

class WebsocketVC: UIViewController {
    
    @IBOutlet weak var connectionLabel : UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    
    @IBAction func connectBtn(_ sender: Any) {
    }

    @IBAction func disconnectBtn(_ sender: Any) {
    }
    
    @IBAction func sendDataBtn(_ sender: Any) {
        let jsonString = "{\"ezid\":\"Phyllis Fagnani\",\"username\":\"Phyllis Fagnani\",\"userType\":\"SAFECHECK\",\"type\":\"login-webrtc\"}"

    }
}
