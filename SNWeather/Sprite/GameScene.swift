//
//  GameScene.swift
//  LightningGenerator
//

import SpriteKit
import GameplayKit
import Cocoa

class GameScene: SKScene {
    private let darkBackgroundColor = NSColor.systemGray.withAlphaComponent(0.5)
    private let litUpBackgroundColor = NSColor.clear
    private let lightningStrikeColor = NSColor(red: 255/255, green: 212/255, blue: 251/255, alpha: 0.4)
    private let flickerInterval = TimeInterval(0.04)
    private var timer: Timer?
    
    internal func configure(size: CGSize) {
        self.backgroundColor = .clear
        self.scaleMode = .aspectFill
        self.size = size
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    private func createLine(pointA: CGPoint, pointB: CGPoint) -> SKShapeNode {
        let pathToDraw = CGMutablePath()
        pathToDraw.move(to: pointA)
        pathToDraw.addLine(to: pointB)
        
        let line = SKShapeNode()
        line.path = pathToDraw
        line.glowWidth = 1
        line.strokeColor = lightningStrikeColor
        
        return line
    }

    private func genrateLightningPath(startingFrom: CGPoint, angle: CGFloat, isBranch: Bool) -> [SKShapeNode] {
        var strikePath: [SKShapeNode] = []
        
        var startPoint = startingFrom
        var endPoint = CGPoint(x: startingFrom.x, y: startingFrom.y)

        let numberOfLines = isBranch ? 50 : 120
        
        var idx = 0
        while idx < numberOfLines {
            strikePath.append(createLine(pointA: startPoint, pointB: endPoint))
            startPoint = endPoint
            
            let r = CGFloat(10)
            endPoint.y -= r * cos(angle) + CGFloat.random(in: -10 ... 10)
            endPoint.x += r * sin(angle) + CGFloat.random(in: -10 ... 10)

            if Int.random(in: 0 ... 100) == 1 {
                let branchingStartPoint = endPoint
                let branchingAngle = CGFloat.random(in: -CGFloat.pi / 4 ... CGFloat.pi / 4)
                
                strikePath.append(contentsOf: genrateLightningPath(startingFrom: branchingStartPoint, angle: branchingAngle, isBranch: true))
            }
            idx += 1
        }
        
        return strikePath
    }

    private func lightningStrike(throughPath: [SKShapeNode], maxFlickeringTimes: Int) {
        let fadeTime = TimeInterval(CGFloat.random(in: 0.005 ... 0.03))
        let waitAction = SKAction.wait(forDuration: flickerInterval)
        
        let reduceAlphaAction = SKAction.fadeAlpha(to: 0.0, duration: fadeTime)
        let increaseAlphaAction = SKAction.fadeAlpha(to: 1.0, duration: fadeTime)
        let flickerSeq = [waitAction, reduceAlphaAction, increaseAlphaAction]

        var seq: [SKAction] = []
        
        let numberOfFlashes = Int.random(in: 1 ... maxFlickeringTimes)

        for _ in 1 ... numberOfFlashes {
            seq.append(contentsOf: flickerSeq)
        }
        
        for line in throughPath {
            seq.append(SKAction.fadeAlpha(to: 0, duration: 0.25))
            seq.append(SKAction.removeFromParent())
            
            line.run(SKAction.sequence(seq))
            self.addChild(line)
        }
        
        flashTheScreen(nTimes: numberOfFlashes)
    }
    
    private func flashTheScreen(nTimes: Int) {
        let lightUpScreenAction = SKAction.run { self.backgroundColor = self.litUpBackgroundColor }
        let waitAction = SKAction.wait(forDuration: flickerInterval)
        let dimScreenAction = SKAction.run { self.backgroundColor = self.darkBackgroundColor }
        let clearScreenAction = SKAction.run { self.backgroundColor = .clear }

        var flashActionSeq: [SKAction] = []
        for _ in 1 ... nTimes + 1 {
            flashActionSeq.append(contentsOf: [lightUpScreenAction, waitAction, dimScreenAction, waitAction, clearScreenAction])
        }
        
        self.run(SKAction.sequence(flashActionSeq))
    }

    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
    }
}

extension GameScene {
    internal func addThunderAnimation(starting: CGPoint, weight: WeatherWeight?) {
        var range: (min: CGFloat, max: CGFloat) {
            switch weight {
            case .light:
                return (min: 15, max: 30)
            case .heavy:
                return (min: 3, max: 8)
            default:
                return (min: 5, max: 15)
            }
        }
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
            DispatchQueue.main.asyncAfter(deadline: .now() + CGFloat.random(in: range.min...range.max)) {
                let strikeStartingPoint = starting
                let lightningPath = self.genrateLightningPath(startingFrom: strikeStartingPoint, angle: 0, isBranch: false)
                
                self.lightningStrike(throughPath: lightningPath, maxFlickeringTimes: 5)
            }
        }
    }
    
    internal func stopThunderAnimation() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    internal func addCloudAnimation(emmiter: SKEmitterNode?) {
        guard let emmiter = emmiter else { return }
        emmiter.position.y = self.frame.maxY + 10
        emmiter.particlePositionRange.dx = self.frame.width
    }
    
    internal func addRainAnimation(emmiter: SKEmitterNode?) {
        guard let emmiter = emmiter else { return }
        emmiter.position.x = self.frame.midX
        emmiter.position.y = self.frame.maxY
        emmiter.particlePositionRange.dx = self.frame.width
    }
    
    internal func addSnowAnimation(emmiter: SKEmitterNode?) {
        guard let emmiter = emmiter else { return }
        emmiter.position.x = self.frame.midX
        emmiter.position.y = self.frame.maxY
        emmiter.particlePositionRange.dx = self.frame.width
    }
    
    internal func addWindAnimation(emmiter: SKEmitterNode?) {
        guard let emmiter = emmiter else { return }
        emmiter.position.x = self.frame.minX
        emmiter.particlePositionRange.dy = self.frame.height
        emmiter.particleColor = .brown
    }
    
    internal func addSmokeAnimation(emmiter: SKEmitterNode?) {
        guard let emmiter = emmiter else { return }
        emmiter.position.y = self.frame.minY - 300
        emmiter.particlePositionRange.dx = self.frame.width
    }
    
    internal func addAshesAnimation(emmiter: SKEmitterNode?) {
        guard let emmiter = emmiter else { return }
        emmiter.position.y = self.frame.minY - 300
        emmiter.particlePositionRange.dx = self.frame.width
    }
    
    internal func addDustAnimation(emmiter: SKEmitterNode?) {
        guard let emmiter = emmiter else { return }
        emmiter.position.y = self.frame.minY - 300
        emmiter.particlePositionRange.dx = self.frame.width
    }
}
