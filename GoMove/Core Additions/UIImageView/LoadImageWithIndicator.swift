import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    func loadWithIndicator(fromUrlString string: String) {
        sd_imageIndicator = SDWebImageActivityIndicator.gray
        sd_setImage(with: URL(string: string), placeholderImage: #imageLiteral(resourceName: "avtarPlaceholder"))
    }
}
