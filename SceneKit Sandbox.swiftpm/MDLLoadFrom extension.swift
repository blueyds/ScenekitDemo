import SceneKit
import ModelIO
import SceneKit.ModelIO

extension SCNNode {
    func MDLLoad(resource name: String, withExtension ext: String){
        if let url = Bundle.main.url(forResource: name, withExtension: ext){
            let asset = MDLAsset(url: url)
            print(asset)
            let object = asset.object(at: 0)
            let tempNode = SCNNode(mdlObject: object)
            print(url)
            if tempNode.geometry == nil {
                fatalError("Geometry did not load for resource \(name)")
            } 
            geometry = tempNode.geometry
            light = tempNode.light 
        } else {
            fatalError("Coulb not find resource \(name)\(ext)")
        }
        
    }
    func MDLLoad(from url: URL) {
        Task(){
        do{
            let (location, _) = try await URLSession.shared.download(from: url)
            let asset = MDLAsset(url: url)
            print(url)
            print(asset)
            let object = asset.object(at: 0)
            let tempNode = SCNNode(mdlObject: object)
            print(url)
            if tempNode.geometry == nil {
                fatalError("Geometry did not load for resource \(name ?? "")")
            } 
            geometry = tempNode.geometry
            light = tempNode.light
        } catch {
            fatalError("Could not load object at \(url)")
        }
        }
    }
}
