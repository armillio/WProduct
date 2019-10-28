
import UIKit

extension UIImageView {
    
    // MARK: Download images
    
    func download(fromURL url: URL, withContentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    error == nil,
                    let image = UIImage(data: data)
                    else {
                        DispatchQueue.main.async {
                            self.image = UIImage.init(named: "no_image")
                        }
                        return
                }
                DispatchQueue.main.async() {
                    self.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.image = UIImage.init(named: "no_image")
                }
            }
        }.resume()
    }
}
