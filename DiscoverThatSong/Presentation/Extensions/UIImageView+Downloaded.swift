import Foundation
import UIKit

extension UIImageView {
    func downloaded(fromURL url: URL?, withContentMode contentMode: UIImageView.ContentMode = .scaleAspectFit) {
        guard let url = url else { return }
        self.contentMode = contentMode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse,
                  httpURLResponse.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else { return }
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
