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
    var scoreLabel: SKLabelNode!
    var secondsLeftLabel: SKLabelNode!
    var ammoDisplay: SKSpriteNode!
    
    var waterInPeak = false
    var gameTimer: Timer!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var waterTexture: String {
        waterInPeak ? "water-bg" : "water-fg"
    }
    var secondsLeft = 60 {
        didSet {
            secondsLeftLabel.text = "\(secondsLeft)s left"
            if secondsLeft <= 0 {
                gameOver()
            }
        }
    }
    var ammoLeft = 3 {
        didSet {
            ammoDisplay.texture = SKTexture(imageNamed: "shots\(ammoLeft)")
            if ammoLeft <= 0 {
                reload()
            }
        }
    }
    
    var hud = [SKNode]()
    
    
    override func didMove(to view: SKView) {
        setupWorldPhysics()
        setupBackground()
        setupHud()
        setupGameTimer()
        print("Game Load Complete")
    }
    
    func setupWorldPhysics() {
        physicsWorld.gravity = .zero
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
        curtain.zPosition = 100
        curtain.name = "curtain"
        addChild(curtain)
    }
    
    func setupHud() {
        addScoreLabel()
        addSecondsLeftLabel()
        addAmmoDisplay()
        addObjectiveDisplay()
        toggleHud(true)
    }
    
    func addScoreLabel() {
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: 20, y: 720)
        scoreLabel.zPosition = 200
        score = 0
        hud.append(scoreLabel)
    }
    
    func addSecondsLeftLabel() {
        secondsLeftLabel = SKLabelNode(fontNamed: "Chalkduster")
        secondsLeftLabel.horizontalAlignmentMode = .right
        secondsLeftLabel.position = CGPoint(x: 1000, y: 720)
        secondsLeftLabel.zPosition = 200
        secondsLeft = 60
        hud.append(secondsLeftLabel)
    }
    
    func addAmmoDisplay() {
        ammoDisplay = SKSpriteNode(imageNamed: "shots\(ammoLeft)")
        ammoDisplay.position = CGPoint(x: 50, y: 50)
        ammoDisplay.zPosition = 200
        hud.append(ammoDisplay)
    }
    
    func addObjectiveDisplay() {
        let objective = SKLabelNode(fontNamed: "Chalkduster")
        objective.horizontalAlignmentMode = .right
        objective.text = "Don't shoot the yellow duck!"
        objective.position = CGPoint(x: 1000, y: 50)
        objective.zPosition = 200
        hud.append(objective)
    }
    
    func toggleHud(_ display: Bool) {
        for eachItem in hud {
            if display {
                addChild(eachItem)
            } else {
                eachItem.removeFromParent()
            }
        }
    }
    
    func setupGameTimer() {
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(createTarget), userInfo: nil, repeats: true)
    }
    
    func gameOver() {
        gameTimer?.invalidate()
        toggleHud(false)
        addGameOverText()
        addFinalScoreText()
    }
    
    func addGameOverText() {
        let gameOver = SKSpriteNode(imageNamed: "game-over")
        gameOver.position = CGPoint(x: 512, y: 384)
        gameOver.zPosition = 300
        addChild(gameOver)
    }
    
    func addFinalScoreText() {
        let finalScore = SKLabelNode(fontNamed: "Chalkduster")
        finalScore.text = "Final Score: \(score)"
        finalScore.position = CGPoint(x: 400, y: 384)
        finalScore.zPosition = 300
        addChild(finalScore)
    }
    
    func getRandomPositionForTarget(fromLeft: Bool) -> CGPoint {
        CGPoint(x: fromLeft ? -40 : 1064, y: CGFloat.random(in: 175...275))
    }
    
    func getRandomVelocityForTarget(fromLeft: Bool) -> CGVector {
        let dx = fromLeft ? CGFloat.random(in: 300...500) : CGFloat.random(in: -500 ... -300)
        return CGVector(dx: dx, dy: 0)
    }
    
    @objc func createTarget() {
        let isFromLeft = Bool.random()
        let target = Target()
        target.initialize(with: getRandomVelocityForTarget(fromLeft: isFromLeft))
        target.position = getRandomPositionForTarget(fromLeft: isFromLeft)
        target.target.physicsBody?.velocity = getRandomVelocityForTarget(fromLeft: isFromLeft)
        target.zPosition = 1
        addChild(target)
        secondsLeft -= 1
        print("\(target.target.name ?? "target") created")
    }
    
    
    /*
    func addWaterPlate() {
        waterPlate =
    }
    */
    
    func reload() {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // remove any target beyond bounds
        for node in children {
            let xPos = node.position.x
            if (xPos < -150 || xPos > 1174) {
                node.removeFromParent()
            }
        }
    }
}
