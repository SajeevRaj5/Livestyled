//
//  AlertControllerTests.swift
//  LiveStyledTestTests
//
//  Created by Sajeev on 1/21/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import Quick
import Nimble
@testable import LiveStyledTestTests

class AlertControllerTests: QuickSpec {
    override func spec() {
        
        context("did show alert") {
            beforeEach {
                MockAlertController.show(type: .serviceError)
            }
            
            it("check to show alert") {
                print(MockAlertController.topMostViewController())
            }
        }
    }
    
    class  MockAlertController : AlertController {
        override class func topMostViewController() -> UIViewController {
            let vc =  MockNavigationController().topViewController ?? UIViewController()
            _ = vc.view
            return vc
        }

    }
}
