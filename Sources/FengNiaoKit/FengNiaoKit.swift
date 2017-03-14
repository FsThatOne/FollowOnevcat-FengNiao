import Foundation
import PathKit

public struct FengNiao {
    let projectPath: Path
    let excludedPaths: [Path]
    let resourceExtensions: [Path]
    let fileExtensions: [String]
    
    public struct FileInfo {
        let path: String
        
    }
    
    public init(projectPath: String, excludedPaths: [String], resourceExtensions: [String], fileExtensions: [String]) {
        let path = Path(projectPath).absolute()
        self.projectPath = path
        self.excludedPaths = excludedPaths.map { path + Path($0) }
        self.resourceExtensions = resourceExtensions.map { path + Path($0) }
        self.fileExtensions = fileExtensions
    }
    
    public func unusedResource() -> [FileInfo] {
        fatalError()
    }
    
    func stringsInUse() -> [String] {
        fatalError()
    }
    
    func resourcesInUse() -> [String: String] {
        fatalError()
    }
    
    public func delete() -> () {
        
    }
    
}
