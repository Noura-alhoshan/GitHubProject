//
//  Spinner.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 05/01/2023.
//

import Foundation
import UIKit

private var aView : UIView?
extension UIViewController {
    
    func startSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let ui = UIActivityIndicatorView(style: .large)
        ui.center = aView!.center
        ui.startAnimating()
        aView?.addSubview(ui)
        self.view.addSubview(aView!)
    }
    
    func stopSpinner() {
        aView?.removeFromSuperview()
        aView = nil
    }
}
