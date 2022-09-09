import SceneKit 

protocol SelectableNode {
    func hitMe()
}

protocol Swipeable {
    func swiped(direction: SwipeModifier.Directions, _ type: SwipeModifier.Trigger)
}
protocol Updateable {
    func doUpdate(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval)
}

