//
//  ViewController.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 23/06/22.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    @IBOutlet weak var card: UIVisualEffectView!
    let emitterNode = SKEmitterNode(fileNamed: "Snow.sks")!
    let emitterNode2 = SKEmitterNode(fileNamed: "Cloud.sks")!
    var scene: GameScene!
    var skView: WeatherSKView!

    override func viewDidLoad() {
        super.viewDidLoad()
        addSmoke()
        // Do any additional setup after loading the view.
    }
        
    private func addSmoke() {
//        skView.backgroundColor = .clear
        
        scene = GameScene()
        skView = WeatherSKView(frame: view.frame, scene: scene)

            // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        scene.size = view.frame.size
        // Present the scene
//        skView.ignoresSiblingOrder = true
//
//        skView.showsFPS = false
//        skView.showsNodeCount = false
//        skView.presentScene(scene)
        

//        let scene = SKScene(size: view.frame.size)
        
//        scene.backgroundColor = .clear
//        skView.presentScene(scene)
//        skView.isUserInteractionEnabled = false
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.addChild(emitterNode)
        

        scene.addChild(emitterNode2)
        
        // thunder
        scene.addThunderAnimation(starting: CGPoint(x: 0, y: scene.frame.height / 2))
        
        // rain
        emitterNode.position.x = scene.frame.midX
        emitterNode.position.y = scene.frame.maxY
        emitterNode.particlePositionRange.dx = scene.frame.width
        
        // Wind
//        emitterNode.position.x = scene.frame.minX
//        emitterNode.particlePositionRange.dy = scene.frame.height
//        emitterNode.particleColor = .brown

        // harzy
//        emitterNode.position.y = scene.frame.minY - 300
//        emitterNode.particlePositionRange.dx = scene.frame.width

        
        // cloud
        emitterNode2.position.y = scene.frame.maxY + 10
        emitterNode2.particlePositionRange.dx = scene.frame.width
        
        view.addSubview(skView)
        view.bringSubviewToFront(card)

    }
}

