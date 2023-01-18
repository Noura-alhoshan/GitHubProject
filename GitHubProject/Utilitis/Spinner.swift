//
//  Spinner.swift
//  GitHubProject
//
//  Created by Noura Alhoshan on 05/01/2023.
//

import Foundation
import UIKit

class Spinner {
     var UiView : UIView? // difffrent place
}

private var UiView : UIView? // difffrent place

extension UIViewController{
   // static var UiView : UIView?
    
    func startSpinner() {
        UiView = UIView(frame: self.view.bounds)
        UiView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let ui = UIActivityIndicatorView(style: .large)
        ui.center = UiView!.center
        ui.startAnimating()
        UiView?.addSubview(ui)
        self.view.addSubview(UiView!)
    }
    
    func stopSpinner() {
        UiView?.removeFromSuperview()
        UiView = nil
    }
}
