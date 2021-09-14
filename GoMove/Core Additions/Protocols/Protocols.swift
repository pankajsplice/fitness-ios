

import Foundation
import UIKit

//MARK:- UIDelegate
protocol UIDelegate: class {
	func success(_ message: AlertMessages)
	func success(with endpoint: UserEndpoint)
	func success(_ message: AlertMessages, with endpoint: UserEndpoint)
	func success()
    func successTwo()
	func show(message: AlertMessages)
}

extension UIDelegate {
	func success(_ message: AlertMessages) {}
	func success(with endpoint: UserEndpoint) {}
	func success(_ message: AlertMessages, with endpoint: UserEndpoint) {}
	func success() {}
    func successTwo() {}
	func show(message: AlertMessages) {}
}


//MARK:-
protocol DataPassable: class {
    func pass<T>(_ data: T)
}

extension DataPassable {
    func pass<T>(_ data: T) {}
}

protocol ButtonTouchable: class {
	func buttonPressed(_ sender: UIButton)
}
