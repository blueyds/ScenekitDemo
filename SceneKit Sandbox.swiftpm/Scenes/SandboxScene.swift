import SceneKit
import Foundation
import CoreGraphics
import UIKit

class SandboxScene: SCNScene, Swipeable, Updateable  {
    //var sceneView: SCNView!
    var camera: SCNNode!
    var ground: Ground!
    var light: SCNNode!
    var button: SButton!
    var sphere1: Sphere!
    var sphere2: Sphere!
    var sun: Sun!
    var directionX: Float = 0
    var directionY: Float = 0
    let speed: Float = 0.1
    override init() {
        super.init()
        
        //        sceneView = SCNView(frame: self.view.frame)
        //        sceneView.scene = SCNScene()
        //        self.view.addSubview(sceneView)
        //        
        ground = Ground(color: UIColor.green)
        
        let camera = SCNCamera()
        camera.zFar = 10000
        self.camera = SCNNode()
        self.camera.camera = camera
        self.camera.position = SCNVector3(x: -20, y: 15, z: 20)
        let constraint = SCNLookAtConstraint(target: ground)
        constraint.isGimbalLockEnabled = true
        self.camera.constraints = [constraint]
        
        let ambientLight = SCNLight()
        ambientLight.color = UIColor.gray
        ambientLight.type = SCNLight.LightType.ambient
        self.camera.light = ambientLight
        
        let spotLight = SCNLight()
        spotLight.type = SCNLight.LightType.spot
        spotLight.castsShadow = true
        spotLight.spotInnerAngle = 70.0
        spotLight.spotOuterAngle = 90.0
        spotLight.zFar = 500
        light = SCNNode()
        light.light = spotLight
        light.position = SCNVector3(x: 0, y: 25, z: 25)
        light.constraints = [constraint]
        
        sphere1 = Sphere(radius: 1.5, x: -15, y: 1.5, z: 0, color: UIColor.yellow)
        sphere1.addPhysics(hasGravity: true)
        sphere2 = Sphere(radius: 1.5, x: 15, y: 1.5, z: 0, color: UIColor.brown)
        sphere2.addPhysics()
        
        button = SButton(affectedNode: sphere1)
        sun = Sun(radius: 2, x: 0, y: 6, z: 0, color: UIColor.red)
        // physics
        
        rootNode.addChildNode(self.camera)
        rootNode.addChildNode(ground)
        rootNode.addChildNode(light)
        rootNode.addChildNode(button)
        rootNode.addChildNode(sphere1)
        rootNode.addChildNode(sphere2)
        rootNode.addChildNode(sun)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func swiped(direction: SwipeModifier.Directions, _ type: SwipeModifier.Trigger) {
        print("ddd")
        if type == .onEnded {
            directionX = 0
            directionY = 0
        } else {
            switch direction {
                case .left:
                directionX = -1
            case .right:
                directionX = 1
            case .up:
                directionY = 1
            case .down:
                directionY = -1
            }
        }
    }
    func doUpdate(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        sun.moveX(directionX * speed)
        sun.moveY(directionY * speed)
    }
}

