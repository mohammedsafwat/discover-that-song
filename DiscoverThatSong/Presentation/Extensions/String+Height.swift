import Foundation
import UIKit

extension String {
    func height(withFont font: UIFont, maxWidth: CGFloat, maxLines: Int) -> CGFloat {
        guard !isEmpty else { return 0 }
        guard maxLines != 1 else { return font.lineHeight}
        let height = (self as NSString).boundingRect(
            with: .init(width: maxWidth, height: .infinity),
            options: [.usesLineFragmentOrigin],
            attributes: [.font: font],
            context: nil
        ).height
        return maxLines == 0 ? height : min(height, CGFloat(maxLines) * font.lineHeight)
    }
}
