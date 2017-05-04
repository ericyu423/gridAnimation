//
//  ViewController.swift
//  gridAnimation
//
//  Created by eric yu on 5/2/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    var selectV: UIView?
    var cells = [String: UIView]()
    
    var width: CGFloat {
        get {
            return view.frame.width * 0.05
        }
        set
        {
            displayBlocks()// upon rotation redraw, this is probably not the best way to do fix it later
        }
    }
    var viewPerRow: Int {
        return Int(view.frame.width / width)
    }
    
    var viewPerCol: Int {
        return Int(view.frame.height / width)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayBlocks()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        DispatchQueue.main.async() {
            self.width = self.view.bounds.size.width
        }
    }
    
    func displayBlocks(){
        for j in 0...viewPerCol{
            for i in 0...viewPerRow{
                let v = UIView()
                view.addSubview(v)
                v.backgroundColor = self.randomColor()
                v.layer.borderColor = UIColor.black.cgColor
                v.layer.borderWidth = 0.5
                
                let key = "\(i)|\(j)"
               
                cells.updateValue(v, forKey: key)
                
                v.anchor(top:view.topAnchor, left: view.leftAnchor, bottom: nil,right: nil, paddingTop: CGFloat(j) * width, paddingLeft: CGFloat(i) * width, paddingBottom: 0, paddingRight: 0, width: width, height: width)
            }
        }
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
    }
    
    
    func handlePanGesture(gesture: UIPanGestureRecognizer){
        let loc:CGPoint = gesture.location(in: view)
        
        let i = Int(loc.x / width)
        let j = Int(loc.y / width)
        
        let key = "\(i)|\(j)"
        guard let cellV = cells[key] else {return}
        
        if selectV != cellV {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectV?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }

        selectV = cellV
        view.bringSubview(toFront: cellV)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            cellV.layer.transform = CATransform3DMakeScale(3, 3, 3)
        },completion: nil)
        
        if gesture.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectV?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
        
    }
}



extension ViewController {
   
    fileprivate func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
}

