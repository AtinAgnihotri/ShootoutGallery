//
//  BaseTarget.swift
//  ShootingGallery
//
//  Created by Atin Agnihotri on 05/08/21.
//

import SpriteKit

class Target: SKNode {
    
    var target: SKSpriteNode!
    
    func initialize(with velocity: CGVector) {
        addTarget()
        addStickBehindTarget()
        addPhysicsBody(with: velocity)
    }
    
    func getRandomStick() -> String {
        ["stick0", "stick1", "stick2"].randomElement() ?? "stick0"
    }
    
    func addStickBehindTarget() {
        let stick = SKSpriteNode(imageNamed: getRandomStick())
        stick.position = CGPoint(x: 0, y: -100)
        stick.zPosition = -1
        addChild(stick)
    }
    
    func getRandomTarget() -> String {
        ["target0", "target1", "target2", "target3"].randomElement() ?? "target0"
    }
    
    func addTarget() {
        let targetName = getRandomTarget()
        target = SKSpriteNode(imageNamed: targetName)
        target.zPosition = 1
        name = targetName != "target3" ? "targetGood" : "targetBad"
        addChild(target)
    }
    
    func addPhysicsBody(with velocity: CGVector) {
        physicsBody = SKPhysicsBody(rectangleOf: target.size)
        physicsBody?.linearDamping = 0
        physicsBody?.angularDamping = 100
        physicsBody?.velocity = velocity
        physicsBody?.collisionBitMask = 0 // So that the targets pass through each other instead of colliding
    }
    
    func targetHit() {
        target.alpha = 0
    }
    
//    func scaleDownTarget() {
//        target.xScale = 0.8
//        target.yScale = 0.8
//    }
    
//    func explosionAtTarget() {
//        guard let explosion = SKEmitterNode(fileNamed: "explosion") else { return }
//        addChild(explosion)
//    }
}
