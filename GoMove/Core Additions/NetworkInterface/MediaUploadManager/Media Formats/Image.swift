
import Foundation

extension Media {
    enum Image: MediaFormat {
        case jpeg, png, pdf, mov, m4a
        
        var mime: String {
            switch self {
            case .jpeg: return "image/jpeg"
            case .png: return "image/png"
            case .pdf: return "image/pdf"
            case .mov: return "video"
            case .m4a: return "audio"
            }
        }
        
        var fileName: String {
            switch self {
            case .jpeg: return "image\(timeInterval).jpeg"
            case .png: return "image\(timeInterval).png"
            case .pdf: return "image\(timeInterval).pdf"
            case .mov: return "video\(timeInterval).MP4"
            case .m4a: return "audio\(timeInterval).m4a"
            }
        }
    }
    
}
