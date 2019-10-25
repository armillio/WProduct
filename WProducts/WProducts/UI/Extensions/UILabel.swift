
import UIKit

extension UILabel {
    func adjustHeightOfLabel( withLabel label:UILabel) -> CGSize{
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        let labelHeight:CGFloat = determineLabelHeight(withWidth: label.frame.size.width, withFont:label.font, withText:label.text)
        label .sizeThatFits(CGSize(width: label.frame.size.width, height: labelHeight))
        return CGSize(width: label.frame.size.width, height: labelHeight)
    }
    
    func determineLabelHeight(withWidth width: CGFloat?, withFont font: UIFont?, withText text: String?) -> CGFloat{
        guard let guardWidth = width else{ return 18.0 }
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: guardWidth, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}
