import SceneKit

class SButton: SCNNode, SelectableNode {
    var selected: Bool = false
    private var affectedNode: SCNNode?
    init(affectedNode: SCNNode? = nil){
        super.init()
        let buttonGeometry = SCNBox(width: 4, height: 1, length: 4, chamferRadius: 0)
        let buttonMaterial = SCNMaterial()
        buttonMaterial.diffuse.contents = UIColor.red
        buttonGeometry.materials = [buttonMaterial]
        self.geometry = buttonGeometry
        self.affectedNode = affectedNode
        self.position = SCNVector3(x: 0, y: 0.5, z: 15)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func hitMe(){
        affectedNode?.physicsField?.strength = 750
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5
        if let material = self.geometry?.materials[0] {
            material.diffuse.contents = UIColor.white
        }
        SCNTransaction.commit()
        
        let action = SCNAction.moveBy(x: 0 , y: -0.8, z: 0, duration: 0.5)
        self.runAction(action)
    }
    
}
