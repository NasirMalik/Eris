//
//  Created by Nasir Mahmood on 07.03.21.
//

import Foundation
import UIKit

extension UIViewController {
    
    static func instantiate(from storyboardName: UIStoryboard.StoryboardName) -> Self {
        return instantiateFromStoryboardHelper(storyboardName: storyboardName)
    }
    
    private static func instantiateFromStoryboardHelper<T>(storyboardName: UIStoryboard.StoryboardName) -> T {
        let identifier = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}
