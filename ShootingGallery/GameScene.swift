//
//  GameScene.swift
//  ShootingGallery
//
//  Created by Atin Agnihotri on 05/08/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var waterPlate: SKSpriteNode!
    var waterInPeak = false
    var waterTexture: String {
        waterInPeak ? "water-bg" : "water-fg"
    }
    
    override func didMove(to view: SKView) {
        setupBackground()
    }
    
    func setupBackground() {
        backgroundColor = .clear
        addWoodPlate()
        addForrestPlate()
        addCurtainPlate()
    }
    
    func addWoodPlate() {
        let wood = SKSpriteNode(imageNamed: "wood-background")
        wood.blendMode = .replace
        wood.position = CGPoint(x: 512, y: 384)
        wood.xScale = 1.5
        wood.yScale = 1.5
        wood.zPosition = -3
        addChild(wood)
    }
    
    func addForrestPlate() {
        let forrest = SKSpriteNode(imageNamed: "grass-trees")
        forrest.position = CGPoint(x: 512, y: 384)
        forrest.xScale = 1.5
        forrest.yScale = 1.5
        forrest.zPosition = -2
        addChild(forrest)
    }
    
    func addCurtainPlate() {
        let curtain = SKSpriteNode(imageNamed: "curtains")
        curtain.position = CGPoint(x: 512, y: 384)
        curtain.xScale = 1.5
        curtain.yScale = 1.5
        curtain.zPosition = 2
        curtain.name = "curtain"
        addChild(curtain)
    }
    
    /*
    func addWaterPlate() {
        waterPlate =
    }
    */
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
