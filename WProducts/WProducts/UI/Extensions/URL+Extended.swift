
import UIKit

extension URL {
    func verifyUrl (url: URL?) -> Bool {
        guard let url = url else{ return false }
        if UIApplication.shared.canOpenURL(url) {
            return true
        }
        return false
    }
}
