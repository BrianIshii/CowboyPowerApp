//
//  GameScene.swift
//  CowboyPower
//
//  Created by Brian Ishii on 8/11/16.
//  Copyright (c) 2016 Brian Ishii. All rights reserved.
//

import SpriteKit
import CoreMotion
import AVFoundation
import AudioToolbox
class GameScene: SKScene {
    var b = 0
    var soundURL: NSURL?
    var soundID:SystemSoundID = 0
    var y = 1
    let manager = CMMotionManager()
    override func didMoveToView(view: SKView) {
        self.backgroundColor = SKColor.purpleColor()
        let filePath = NSBundle.mainBundle().pathForResource("cowbell_tip (1)", ofType: "wav")
        soundURL = NSURL(fileURLWithPath: filePath!)
        AudioServicesCreateSystemSoundID(soundURL!, &soundID)
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()){
            (data, error) in
            print((data?.acceleration.x)!)
            if ((data?.acceleration.x)! > 0){
                self.backgroundColor = SKColor.purpleColor()
                self.b = 1
            }
            else if ((data?.acceleration.x)! < 0)  {
                self.backgroundColor = SKColor.yellowColor()
                self.b = 2
            }
            else{
                self.backgroundColor = SKColor.yellowColor()
            }
            if (self.b == 1){
                if (self.y != 1){
                    AudioServicesPlaySystemSound(self.soundID)
                    self.y = 1
                }
            }
            else if (self.b == 2) {
                if (self.y != 2) {
                    AudioServicesPlaySystemSound(self.soundID)
                    self.y = 2
                }
            }
        }
    }
}
