//https://stackoverflow.com/questions/44397680/how-can-we-use-assets-catalog-color-sets
//Used this to pass the cyan color from assets

import UIKit

enum AssetsColor: String {
    case dark
    case blue
    case transparent
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor? {
           switch name {
           case .blue:
               return UIColor(named: "SearchBar")
           case .dark:
               return UIColor(named: "Dark")
           case .transparent:
               return UIColor(named: "Transparent")
           default:
               return UIColor.white
               
           }
    }
}
