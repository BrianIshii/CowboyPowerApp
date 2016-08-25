//
//  SettingsViewController.swift
//  CowboyPower
//
//  Created by Brian Ishii on 8/23/16.
//  Copyright © 2016 Brian Ishii. All rights reserved.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {
    var totalScore = Int()
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var TotalScoreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        TotalScoreLabel.text = "\(totalScore)"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backButtonIsPressed(sender: AnyObject) {
        performSegueWithIdentifier("fromSettingsToGameScene", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
