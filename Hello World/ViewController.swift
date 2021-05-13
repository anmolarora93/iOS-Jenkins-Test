//
//  ViewController.swift
//  Hello World
//
//  Created by Anmol Arora on 03/05/18.
//  Copyright © 2018 Anmol Arora. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBAction func clearClipboard(_ sender: Any) {
        print("Button Clicked")
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

