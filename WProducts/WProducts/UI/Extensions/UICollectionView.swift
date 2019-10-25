
import UIKit

extension UICollectionView {
    
    // MARK: Determine width of the cell
    
    func itemSize(withView view: UIView, withFlowLayout flowLayout: UICollectionViewFlowLayout, withCount count: Int){
        let safeWidth = view.safeAreaLayoutGuide.layoutFrame.size.width
        var width = safeWidth
        
        if  safeWidth == 0 {
            width = view.frame.size.width
        }
        
        flowLayout.itemSize = CGSize(width: widthOfCell(withSafeArea: width, withList: count), height: (view.frame.size.height) / 2)
    }
    
    func widthOfCell(withSafeArea safeArea: CGFloat, withList list: Int?) -> CGFloat{
        var numberColumns: Int
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return 0 }
        if UIDevice.current.userInterfaceIdiom == .pad {
            if windowScene.interfaceOrientation == .portrait {
                numberColumns = 2
            }else{
                numberColumns = 3
            }
        }else {
            if windowScene.interfaceOrientation == .portrait {
                numberColumns = 1
            }else{
                if(list == 1){
                    numberColumns = 1
                }else{
                    numberColumns = 2
                }
            }
        }
        let width = Int(safeArea) / numberColumns
        return CGFloat(width)
    }
}
