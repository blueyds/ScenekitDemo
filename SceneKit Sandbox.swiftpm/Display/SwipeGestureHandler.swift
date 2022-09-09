import SwiftUI

struct SwipeModifier: ViewModifier {
    enum Directions: Int {
        case up, down, left, right
    }
    
    enum Trigger {
        case onChanged, onEnded
    }
    //var trigger: Trigger
    var handler: ((Directions, Trigger) -> Void)?
    
    func body(content: Content) -> some View {
        content.gesture(
            DragGesture(
                minimumDistance: 24,
                coordinateSpace: .local)
            .onChanged { handle($0, .onChanged)}
                .onEnded { handle($0, .onEnded)}
        )
    }
    private func handle(_ value: _ChangedGesture<DragGesture>.Value, _ type: Trigger) {
        let hDelta = value.translation.width
        let vDelta = value.translation.height
        
        if abs(hDelta) > abs(vDelta) {
            handler?(hDelta < 0 ? .left : .right, type)
        } else {
            handler?(vDelta < 0 ? .up : .down, type)
        }
    }
}

extension View {
    func onSwiped(
    //trigger: SwipeModifier.Trigger = .onChanged,
        action: @escaping (SwipeModifier.Directions, SwipeModifier.Trigger) -> Void
    ) -> some View {
        let swipeModifier = SwipeModifier() {
            action($0, $1)
        }
        return self.modifier(swipeModifier)
    }
}
