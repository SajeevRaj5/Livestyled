//
//  AlertControllerTests.swift
//  LiveStyledTestTests
//
//  Created by Sajeev on 1/21/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import Quick
import Nimble
@testable import LiveStyledTest

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
    
    class MockAlertController : AlertController {
        override class func topMostViewController() -> UIViewController {
            let vc =  MockNavigationController().topViewController ?? UIViewController()
            _ = vc.view
            return vc
        }
    }
}

class MockNavigationController: UINavigationController {
    
    var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: true)
    }
    
    func getNavigationController(for viewController: UIViewController) -> MockNavigationController {
        UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.rootViewController = navigationController
        return MockNavigationController(rootViewController: viewController)
    }
}

