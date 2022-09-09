import SwiftUI
import SceneKit


struct ContentView: View {
    @ObservedObject private var scenes:  SceneManager = SceneManager.shared 
    
    var body: some View {
        ZStack(alignment: .bottom){
            SceneKitView(
                scene: scenes.currentScene, 
                allowsCameraControl: false, 
                renderDelegate: scenes, 
                onTouch: {scenes.touchMe(location: $0)}, 
                onHitTest: { scenes.hitTest($0)}
            )
//            SceneView(scene: scenes.currentScene)
            .onSwiped(){
                scenes.swiped(direction: $0, $1)
                
            }
            Button("SwitchScene"){
                scenes.switchScenes()
//                scenes.set(scene: .Other)
            }
        }
//        .background(GameEventHandler())
        
    }
}

