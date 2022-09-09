import SceneKit

class Ground: SCNNode {
    init(color: UIColor){
        super.init()
        let groundGeometry = SCNFloor()
        groundGeometry.reflectivity = 0
        let groundMaterial = SCNMaterial()
        groundMaterial.diffuse.contents = color
        groundGeometry.materials = [groundMaterial]
        geometry = groundGeometry
        let groundShape = SCNPhysicsShape(geometry: groundGeometry, options: nil)
        let groundBody = SCNPhysicsBody(type: .kinematic, shape: groundShape)
        physicsBody = groundBody
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

