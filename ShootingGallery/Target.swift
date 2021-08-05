//
//  BaseTarget.swift
//  ShootingGallery
//
//  Created by Atin Agnihotri on 05/08/21.
//

import SpriteKit

class Target: SKNode {
    
    var target: SKSpriteNode!
    
    func initialize() {
        addStick()
        addTarget()
    }
    
    func getRandomStick() -> String {
        ["stick0", "stick1", "stick2"].randomElement() ?? "stick0"
    }
    
    func addStick() {
        let stick = SKSpriteNode(imageNamed: getRandomStick())
        stick.position = CGPoint(x: 0, y: -100)
        stick.zPosition = 0
        addChild(stick)
    }
    
    func getRandomTarget() -> String {
        ["target0", "target1", "target2", "target3"].randomElement() ?? "target0"
    }
    
    func addTarget() {
        let targetName = getRandomTarget()
        target = SKSpriteNode(imageNamed: targetName)
        target.zPosition = 1
        target.name = targetName != "target3" ? "targetGood" : "targetBad"
        addChild(target)
    }
    
    func targetHit() {
        scaleDownTarget()
        explosionAtTarget()
    }
    
    func scaleDownTarget() {
        target.xScale = 0.8
        target.yScale = 0.8
    }
    
    func explosionAtTarget() {
        guard let explosion = SKEmitterNode(fileNamed: "explosion") else { return }
        addChild(explosion)
    }
}
