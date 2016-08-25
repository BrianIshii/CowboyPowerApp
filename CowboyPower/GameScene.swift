//
//  GameScene.swift
//  CowboyPower
//
//  Created by Brian Ishii on 8/11/16.
//  Copyright (c) 2016 Brian Ishii. All rights reserved.
//

import SpriteKit
import CoreMotion
import AudioToolbox
class GameScene: SKScene {
    let scoreLabel = SKLabelNode()
    var score = Int()
    var cowboyP = SKSpriteNode()
    var cowboyY = SKSpriteNode()
    var b = 0
    var soundURL: NSURL?
    var soundID:SystemSoundID = 0
    var y = 1
    let manager = CMMotionManager()
    var stopSounds = Bool()
    override func didMoveToView(view: SKView) {
        self.backgroundColor = SKColor.purpleColor()
        scoreLabel.position = CGPoint(x: (self.frame.width / 2), y: (self.frame.height * 2 / 3))
        scoreLabel.text = "\(score)"
        addChild(scoreLabel)
        cowboyY = SKSpriteNode(imageNamed: "cowboyP")
        cowboyY.size = CGSize(width: 150, height: 150)
        cowboyY.position = CGPoint(x: (self.frame.width / 2), y: (self.frame.height/2))
        addChild(cowboyY)
        self.cowboyY.hidden = false
        cowboyP = SKSpriteNode(imageNamed: "cowboyY")
        cowboyP.size = CGSize(width: 150, height: 150)
        cowboyP.position = CGPoint(x: (self.frame.width / 2), y: (self.frame.height/2))
        addChild(cowboyP)
        self.cowboyP.hidden = true
        let filePath = NSBundle.mainBundle().pathForResource("cowbell_tip (1)", ofType: "wav")
        soundURL = NSURL(fileURLWithPath: filePath!)
        AudioServicesCreateSystemSoundID(soundURL!, &soundID)
        self.manager.stopAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        NSOperationQueue.mainQueue().cancelAllOperations()
        manager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!){
            [unowned self] data, error in
            if ((data?.acceleration.x)! > 0){
                if self.b != 1{
                    self.backgroundColor = SKColor.purpleColor()
                    self.cowboyY.hidden = false
                    self.cowboyP.hidden = true
                    self.playSounds()
                    self.b = 1
                }
            }
            else if ((data?.acceleration.x)! < 0)  {
                if self.b != 2{
                    self.backgroundColor = SKColor.yellowColor()
                    self.cowboyY.hidden = true
                    self.cowboyP.hidden = false
                    self.playSounds()
                    self.b = 2
                }
            }
            else{
                self.backgroundColor = SKColor.yellowColor()
            }
        }
    }
    func pauseSounds() {
        self.manager.stopAccelerometerUpdates()
        NSOperationQueue.mainQueue().waitUntilAllOperationsAreFinished()
    }
    func playSounds() {
        AudioServicesPlaySystemSound(self.soundID)
        self.score += 1
        self.scoreLabel.text = "\(self.score)"
    }
    
    override func willMoveFromView(view: SKView) {
        manager.stopAccelerometerUpdates()
    }
    deinit {
        print("The GameScene has been removed from memory")
    }
}
