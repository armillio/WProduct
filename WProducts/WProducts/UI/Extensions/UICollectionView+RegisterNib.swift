
import UIKit

protocol UICollectionViewCellStaticProtocol {
    static func cellIdentifier() -> String
}

extension UICollectionViewCellStaticProtocol {
    static func cellIdentifier() -> String {
        return String(describing: type(of: self))
    }
}

extension UICollectionView {
    func registerNib<T:UICollectionViewCell>(_ classValue: T.Type) where T:UICollectionViewCellStaticProtocol {
        register(UINib(nibName: String(describing: classValue), bundle: nil), forCellWithReuseIdentifier: classValue.cellIdentifier())
    }
    
    func registerHeaderNib<T:UICollectionViewCell>(_ classValue: T.Type) where T:UICollectionViewCellStaticProtocol {
        register(UINib(nibName: String(describing: classValue), bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: classValue.cellIdentifier())
    }
}
