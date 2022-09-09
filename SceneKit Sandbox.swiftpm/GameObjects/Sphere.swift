import SceneKit

class Sphere: SCNNode, SelectableNode {
    private var hasGravity: Bool = false
    init(radius: Float, x: Float, y: Float, z: Float, color: UIColor){
        super.init()
        let sphereGeometry = SCNSphere(radius: CGFloat(radius))
        let sphereMaterial = SCNMaterial()
        sphereMaterial.diffuse.contents = color
        sphereGeometry.materials = [sphereMaterial]
        self.geometry = sphereGeometry
        self.position = SCNVector3(x: x , y: y, z: z)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addPhysics(hasGravity: Bool = false){
        let shape = SCNPhysicsShape(geometry: geometry!)
        if hasGravity {
            let gravityField = SCNPhysicsField.radialGravity()
            gravityField.strength = 0
            physicsField = gravityField
            
            let spherebody = SCNPhysicsBody(type: .kinematic, shape: shape)
            physicsBody = spherebody
            
        }else {
            let spherebody = SCNPhysicsBody(type: .dynamic, shape: shape)
            physicsBody = spherebody
        }
        
        
    }
    func hitMe() {
        self.removeFromParentNode()
    }
    
    
}

