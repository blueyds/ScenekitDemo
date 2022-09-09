import SceneKit

class Sun: Sphere {
    private var isOn = true
    {
        didSet {
            if isOn { light?.intensity = 1000}
            else { light?.intensity = 0.0 }
        }
    }
    override init(radius: Float, x: Float, y: Float, z: Float, color: UIColor) {
        super.init(radius: radius, x: x, y: y, z: z, color: color)
        let omniLight = SCNLight()
        omniLight.type = SCNLight.LightType.omni
        omniLight.castsShadow = true
        omniLight.color = color
        omniLight.intensity = 1000
        light = omniLight
        //addPhysics(hasGravity: false)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func hitMe() {
        print("touched sun intensity \(light?.intensity ?? 9999)")
        
        isOn.toggle()
    }
}

