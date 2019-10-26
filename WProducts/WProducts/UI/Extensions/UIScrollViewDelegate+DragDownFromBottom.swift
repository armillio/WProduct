
import UIKit

extension UIScrollViewDelegate {
    func scrollViewDidDragDownFromBottom(_ scrollView: UIScrollView, delta: CGFloat = 0.0) -> Bool {
        let currentOffset = scrollView.contentOffset.y - delta
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height - delta
        return (currentOffset - maximumOffset) > 0 && maximumOffset > 0
    }
}
