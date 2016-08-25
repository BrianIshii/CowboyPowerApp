//
//  GameViewController.swift
//  CowboyPower
//
//  Created by Brian Ishii on 8/11/16.
//  Copyright (c) 2016 Brian Ishii. All rights reserved.
//

import UIKit
import SpriteKit
import CoreData

class GameViewController: UIViewController {
    let moc = DataController().managedObjectContext

    var scoreView = Int()
    let scene = GameScene(fileNamed:"GameScene")

    @IBOutlet weak var SportsScheduleButton: UIButton!
    @IBOutlet weak var SettingsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
            getScore()
            // Configure the view.
    }
    override func viewDidAppear(animated: Bool) {

        let skView = self.view as! SKView
        
        //            skView.showsFPS = false
        //            skView.showsNodeCount = false
        scene!.score = scoreView
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        //skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene!.scaleMode = .AspectFill
        skView.presentScene(scene)
    }
    override func shouldAutorotate() -> Bool {
        return true
    }
    func getScore() {
        let entityFetch = NSFetchRequest(entityName:"SettingsEntity")
        do{
            let fetchedEntity = try moc.executeFetchRequest(entityFetch) as! [SettingsEntity]
            scoreView = fetchedEntity.last!.totalScoreAttribute! as Int
        }catch{
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    @IBAction func TweetsButtonIsPressed(sender: AnyObject) {
        scene!.pauseSounds()
        scoreView = scene!.score
        saveItem(scoreView)
        performSegueWithIdentifier("scheduleScene", sender: self)
    }
    @IBAction func SettingsButtonIsPressed(sender: UIButton) {
        scene!.pauseSounds()
        scoreView = scene!.score
        saveItem(scoreView)
        performSegueWithIdentifier("settingsScene", sender: self)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "settingsScene") {
            let DestViewController : SettingsViewController = segue.destinationViewController as! SettingsViewController
            DestViewController.totalScore = scoreView
        } else {
            let DestViewController : ScheduleViewController = segue.destinationViewController as! ScheduleViewController
        }
    }
    func saveItem (itemToSave:Int) {
        
        let entity = NSEntityDescription.insertNewObjectForEntityForName("SettingsEntity", inManagedObjectContext: moc) as! SettingsEntity
        entity.setValue(itemToSave, forKey: "totalScoreAttribute")
        do {
            try moc.save()
        }
        catch{
            NSLog("error")
        }
    }


}
