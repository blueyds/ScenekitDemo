import SwiftUI
import SceneKit
import UIKit

struct SceneKitView: UIViewRepresentable {
    var scene: SCNScene
    var allowsCameraControl: Bool?
    var renderDelegate: SCNSceneRendererDelegate?
    //var view = SceneViewClass()
    var onTouch: ((CGPoint)-> Void)?
    var onHitTest: (([SCNHitTestResult])-> Void)?
//    var onKeyDown: ((UIKey)-> Void)?
//    var onKeyUp: ((UIKey)-> Void)?
    
    func makeUIView(context: Context) -> SceneViewClass {
        let view = SceneViewClass()
        view.scene = scene
        if allowsCameraControl != nil {
            view.allowsCameraControl = allowsCameraControl!
        }
        if renderDelegate != nil {
            view.delegate = renderDelegate!
        }
        view.becomeFirstResponder()
        view.onHitTest = self.onHitTest
        view.onTouch = self.onTouch
//        view.onKeyDown = self.onKeyDown
//        view.onKeyUp = self.onKeyUp
        return view
    }
    
    
    func updateUIView(_ uiView: SceneViewClass, context: Context) {
        uiView.scene = self.scene
        uiView.becomeFirstResponder()
    }
    
    
    class SceneViewClass: SCNView {
        
//        var renderDelegate: SCNSceneRendererDelegate?
        var onTouch: ((CGPoint)-> Void)?
        var onHitTest: (([SCNHitTestResult])-> Void)?
//        var onKeyDown: ((UIKey)-> Void)?
//        var onKeyUp: ((UIKey)-> Void)?
        
        override var canBecomeFirstResponder: Bool { true }
        
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            for touch in touches {
                let location = touch.location(in: self)
                if onHitTest != nil {
                    onHitTest!(hitTest(location))
                }
                if onTouch != nil {
                    onTouch!(location)
                }
            }
        }
    }
    
    
    
}
