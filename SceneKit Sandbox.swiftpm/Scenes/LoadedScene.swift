import Foundation
import SceneKit

final class LoadedScene: SCNScene{
    private enum RootCoding: String, CodingKey{
        case name = "sceneName"
        case geometries = "geometries"
        case colors = "colors"
        case materials = "materials"
    }
    private struct Geometry: Codable {
        var name: String
        var type: GeometryType
        var width: CGFloat
        var height: CGFloat
        var length: CGFloat
        var radius: CGFloat
    }
    private struct Color: Codable {
        var name: String
        var red: CGFloat
        var green: CGFloat
        var blue: CGFloat
        var alpha: CGFloat
    }
    var name: String = ""
    var geometries: [String: SCNGeometry] = [:]
    var colors: [String: UIColor] = [:]
}
extension LoadedScene: Decodable{
    convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: RootCoding.self)
        name = try values.decode(String.self, forKey: .name)
        let geometryArray = try values.decode([Geometry].self, forKey: .geometries)
        loadGeometries(geometryArray)
        let coloarArray = try values.decode([Color].self, forKey: .colors)
        print(name)
        
    }
}

extension LoadedScene: Encodable{
    func encode(to encoder: Encoder) throws {
        
    }
}
// for loading geometry objectse
extension LoadedScene {
    private enum GeometryType: Codable {
        case sphere
        case box
    }
    private func loadGeometries(_ array: [Geometry]){
        array.forEach{ geometry in
            var object: SCNGeometry
            switch geometry.type{
            case .sphere:
                object = SCNSphere(radius: geometry.radius)
            case .box:
                object = SCNBox(width: geometry.width, height: geometry.height, length: geometry.length, chamferRadius: geometry.radius)
            }
            geometries.updateValue(object, forKey: geometry.name)
        }
    }
}
