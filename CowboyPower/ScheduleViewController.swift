//
//  ScheduleViewController.swift
//  CowboyPower
//
//  Created by Brian Ishii on 8/22/16.
//  Copyright © 2016 Brian Ishii. All rights reserved.
//

import UIKit
import TwitterKit

class ScheduleViewController: TWTRTimelineViewController {
    @IBOutlet weak var exitButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let client = TWTRAPIClient()
        self.dataSource = TWTRUserTimelineDataSource(screenName: "realDonaldTrump", APIClient: client)
        //self.dataSource = TWTRSearchTimelineDataSource(searchQuery: "#Trump", APIClient: client)
        TWTRTweetView.appearance().primaryTextColor = UIColor.yellowColor()
        TWTRTweetView.appearance().backgroundColor = UIColor.purpleColor()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return false; //do not show keyboard nor cursor
    }
    
    @IBAction func exitButtonIsPressed(sender: AnyObject) {
        performSegueWithIdentifier("fromScheduleToGameScene", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "fromScheduleToGameScene") {
        let DestViewController : GameViewController = segue.destinationViewController as! GameViewController
        }
    }
}

