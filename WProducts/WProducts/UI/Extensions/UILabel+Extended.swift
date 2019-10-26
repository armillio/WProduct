
import UIKit

extension UILabel {
    func adjustHeightOfLabel(){
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
        let labelHeight:CGFloat = determineLabelHeight(withWidth: self.frame.size.width, withFont:self.font, withText:self.text)
        self .sizeThatFits(CGSize(width: self.frame.size.width, height: labelHeight))
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: labelHeight)
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
