//
//  OnCallView.swift
//  Companion
//
//  Created by Ambu Sangoli on 11/21/22.
//

import Foundation
import UIKit
import JitsiMeetSDK

public class OnCallView: UIView {
    
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    

    
    @IBAction func actionBtn(sender : UIButton) {
        let appDelegate = OnCallHelper.shared
        print("return to call")
        if let controller = appDelegate.voiceCallVC {
            OnCallHelper.shared.removeOnCallView()
            if let nav = UIApplication.getTopViewControllerNav() as? UINavigationController {
                nav.pushViewController(controller, animated: true)
            } else {
                UIApplication.getTopViewControllerNav()?.present(controller, animated: true, completion: nil)
            }
        }

    }
    
}

public class OnCallHelper : NSObject {
    
    static let shared = OnCallHelper()
    
    var callView : OnCallView?
    var voiceCallVC : JitsiMeetViewController?

    
    func loadCallView() {
        if self.callView == nil {
            self.callView = Bundle.main.loadNibNamed("OnCallView", owner:
            self, options: nil)?.first as? OnCallView
            self.callView?.tag = 100
            self.callView?.frame = CGRect(x: UIScreen.main.bounds.maxX - 140, y: UIScreen.main.bounds.midY, width: 120, height: 160)
            self.callView?.layer.cornerRadius = 20
            self.callView?.imageView.layer.cornerRadius = 20
            let origImage = UIImage(named: "icCallFilled")
            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
            self.callView?.callBtn.setImage(tintedImage, for: .normal)
            self.callView?.callBtn.tintColor = .white
            var panGesture       = UIPanGestureRecognizer()
            panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedView(_:)))
            self.callView?.isUserInteractionEnabled = true
            self.callView?.addGestureRecognizer(panGesture)
        }
    }
    
    func updateCallTimer(time: String) {
//        let appDelegate = OnCallHelper.shared
//        if let callView = appDelegate.callView {
//            callView.callLabel.text = time
//        }
    }
    
    func updateSnapshot(image: UIImage) {
        let appDelegate = OnCallHelper.shared
        if let callView = appDelegate.callView {
            callView.imageView.image = image
        }
    }
    
    func showOnCallView(image: UIImage){
        let window = UIApplication.shared.windows.last!
        let appDelegate = OnCallHelper.shared
        if let callView = appDelegate.callView {
            callView.imageView.image = image
            window.addSubview(callView)
        }
    }
    
    func removeOnCallView(){
        let appDelegate = OnCallHelper.shared
        appDelegate.callView?.removeFromSuperview()
    }
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        let windoww = UIApplication.shared.windows.last!
        let location = sender.location(in: windoww)
                let draggedView = sender.view
                draggedView?.center = location
                if sender.state == .ended {
                    if draggedView!.frame.minY < windoww.layer.frame.minY + 80 {
                        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                            draggedView!.center.y = 100
                        }, completion: nil)
                    } else if draggedView!.frame.maxY > windoww.layer.frame.maxY - 80 {
                        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                            draggedView!.center.y = windoww.layer.frame.height - 100
                        }, completion: nil)
                    }
                    
                    if draggedView!.frame.midX >= windoww.layer.frame.width / 2 {
                        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                            draggedView!.center.x = windoww.layer.frame.width - 80
                        }, completion: nil)
                    }else{
                        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                            draggedView!.center.x = 80
                        }, completion: nil)
                    }
                }
    }
}

extension UIApplication {

    class func getTopViewControllerNav(base: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return nav

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewControllerNav(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewControllerNav(base: presented)
        }
        return base
    }
}

extension UIView {

    func takeScreenshot() -> UIImage {

        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)

        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if (image != nil)
        {
            return image!
        }
        return UIImage()
    }
}
