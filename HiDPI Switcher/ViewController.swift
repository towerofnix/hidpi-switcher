//
//  ViewController.swift
//  HiDPI Switcher
//
//  Created by Liam on 2016-09-05.
//  Copyright © 2016 towerofnix. All rights reserved.
//

import Cocoa

func openURL(string: String) {
    NSWorkspace.sharedWorkspace().openURL(NSURL(string: string)!)
}

class ViewController: NSViewController {
    @IBOutlet var toggle: NSButton!

    override func viewDidLoad() {
        if let dict = NSDictionary(contentsOfFile: "/Library/Preferences/com.apple.windowserver.plist") {
            if dict["DisplayResolutionEnabled"] != nil {
                toggle.state = 1
            } else {
                toggle.state = 0
            }
        }
    }
    
    @IBAction func toggleHiDPI(sender: NSButton) {
        var script:String
        if sender.state == 1 {
            script = "do shell script \"defaults write /Library/Preferences/com.apple.windowserver.plist DisplayResolutionEnabled -bool true\" with administrator privileges"
        } else {
            script = "do shell script \"sudo defaults delete /Library/Preferences/com.apple.windowserver.plist DisplayResolutionEnabled\" with administrator privileges"
        }
        let appleScript = NSAppleScript(source: script)
        appleScript?.executeAndReturnError(nil)
    }
}

class ViewControllerAbout: NSViewController {
    @IBAction func viewGitHub(sender: NSButton) {
        openURL("https://github.com/liam4")
    }

    @IBAction func viewBlogPost(sender: NSButton) {
        openURL("https://www.tekrevue.com/tip/hidpi-mode-os-x/")
    }
}
