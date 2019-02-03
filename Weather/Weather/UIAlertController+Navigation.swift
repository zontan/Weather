//
//  UIAlertController+Navigation.swift
//  Weather
//
//  Created by Jonathan  Fotland on 2/3/19.
//  Copyright © 2019 Jonathan Fotland. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    //If you don't do this, the alert is pushed onto the navigation stack, which is just plain wrong.
    func presentInOwnWindow(animated: Bool, completion: (() -> Void)?) {
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(self, animated: animated, completion: completion)
    }
    
}
