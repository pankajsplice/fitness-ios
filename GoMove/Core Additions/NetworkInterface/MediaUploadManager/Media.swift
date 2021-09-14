
import Foundation
protocol MediaFormat {
    var mime: String { get }
    var fileName: String { get }
}

extension MediaFormat {
    var timeInterval: String {
        return "\(Date().timeIntervalSince1970)".replacingOccurrences(of: ".", with: "")
    }
}

struct Media {
    var format: MediaFormat?
    var key: String?
    var data: Data?
    
    init() {}
    
    init(format:MediaFormat,key:String,data:Data) {
        self.format = format
        self.key = key
        self.data = data
    }
    
}
