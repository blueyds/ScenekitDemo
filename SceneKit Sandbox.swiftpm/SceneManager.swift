import SwiftUI
import SceneKit

class SceneManager: NSObject, ObservableObject {
    enum Types{
        case Sandbox, Other
    }
    static var shared: SceneManager = SceneManager()
    var pov: SCNNode? {
        // pov will be assumed to be the first node in the hierarchy
        currentScene.rootNode.childNodes.first 
    }
    private override init(){}
    @Published private(set) var currentScene: SCNScene =  SandboxScene() 
    private(set) var currentType: Types = .Sandbox 
    
    func set(scene: Types){
        switch scene {
        case .Sandbox:
            currentScene = SandboxScene()
        case .Other:
            currentScene = OtherScene()
        }
        currentType = scene
    }
    
    func hitTest(_ results: [SCNHitTestResult]){
        if results.count > 0 {
            if let node = results.first?.node as? SelectableNode {
                node.hitMe()
            }
        }
    }
    func touchMe(location: CGPoint){
        print(location)
    }
    func swiped(direction: SwipeModifier.Directions, _ type: SwipeModifier.Trigger){
        if let scene = currentScene as? Swipeable {
            scene.swiped(direction: direction, type)
        }
    }
    // MARK: Intents
    func switchScenes(){
        switch currentType {
        case .Other:
            set(scene: .Sandbox)
        case .Sandbox:
            set(scene: .Other)
        }
    }
}

extension SceneManager: SCNSceneRendererDelegate{
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if let scene = currentScene as? Updateable {
            scene.doUpdate(renderer, updateAtTime: time)
        }
    }
}


