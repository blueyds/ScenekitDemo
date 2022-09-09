import SceneKit

extension SCNNode{
    func moveX(_ delta: Float){ self.position.x += delta}
    func moveY(_ delta: Float){ self.position.y += delta}
    func moveZ(_ delta: Float){ self.position.z += delta }
}

