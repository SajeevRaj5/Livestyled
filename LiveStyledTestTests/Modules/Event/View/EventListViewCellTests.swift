//
//  EventListViewCellTests.swift
//  LiveStyledTestTests
//
//  Created by Sajeev on 1/21/20.
//  Copyright © 2020 LiveStyled. All rights reserved.
//

import Quick
import Nimble
@testable import LiveStyledTestTests

class EventListViewCellTest: QuickSpec {
    
    override func spec() {
        
        describe("event list cell configuration") {
            
            var cell : EventListViewCell!
            
            beforeEach() {
                let tableView = UITableView()
                tableView.register(UINib(nibName: EventListViewCell.identifier, bundle: nil), forCellReuseIdentifier: EventListViewCell.identifier)
                cell = tableView.dequeueReusableCell(withIdentifier: EventListViewCell.identifier) as? EventListViewCell
            }
            
            context("did display values") {
                beforeEach {
                    cell.configureView(event: MockEvent.events.first!)
                }
                
                it("should display details") {
                    expect(cell.titleLabel?.text).toNot(beEmpty())
                    expect(cell.dateLabel?.text).toNot(beEmpty())
                }
            }
        }
    }
}
