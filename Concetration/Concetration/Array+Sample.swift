import Foundation

extension Array {
    func choice() -> Element {
        return self[Int(self.count).arc4random]
    }
}
