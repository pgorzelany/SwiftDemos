//
//  CurtainView.swift
//  SwiftDemos
//
//  Created by PiotrGorzelanyMac on 05/07/16.
//  Copyright © 2016 Piotr Gorzelany. All rights reserved.
//

import UIKit

protocol CurtainViewDelegate: class {
    
    func curtainViewInitialView(view: CurtainView) -> UIView
    func curtainView(view: CurtainView, viewAfterView: UIView) -> UIView?
    func curtainView(view: CurtainView, viewBeforeView: UIView) -> UIView?
}

enum Direction {
    
    case Right, Left
}

class CurtainView: UIView {
    
    
    // MARK: Properties
    
    weak var delegate: CurtainViewDelegate? {
        didSet {
            self.getInitialView()
        }
    }
    
    var topView = UIView()
    var bottomView: UIView?
    
    var initialDirection = Direction.Right
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.configureView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.topView = delegate?.curtainViewInitialView(self) ?? UIView()
        self.addSubviewFullscreen(self.topView)
        
    }
    
    // MARK: Actions
    
    func panGestureRecognized(recognizer: UIPanGestureRecognizer) {
        
        let xTranslation = recognizer.translationInView(self).x
        print(xTranslation)
        
        switch recognizer.state {
            
        case .Began:
            
            self.initialDirection = (xTranslation >= 0 ? Direction.Right : Direction.Left)
            self.bottomView = UIView()
            
        case .Changed:
            
            guard let bottomView = bottomView else {return}
            
        case .Ended:
            
            break
            
        default: break
            
        }
        
        for constraint in self.constraints {
            if constraint.firstAttribute == NSLayoutAttribute.Leading && (constraint.firstItem as? UIView) == self.topView {
                constraint.constant = xTranslation
            }
        }
    }
    
    // MARK: Methods
    
    private func configureView() {
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        self.addGestureRecognizer(panRecognizer)
    }
    
    private func getInitialView() {
        
        self.topView = delegate?.curtainViewInitialView(self) ?? UIView()
        self.addSubviewFullscreen(self.topView)
    }
}