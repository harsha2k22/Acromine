//
//  AcromineViewModelTests.swift
//  AcromineAppTests
//
//  Created by Harsha Vemula on 01/30/22.
//

import UIKit
import XCTest
@testable import AcromineApp

class AcromineViewModelTests: XCTestCase {
    
    var viewModel = AcromineViewModel(manager: APIManagerMock.shared)
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewController() {
        XCTAssertNil(AcrominesListVC(coder: NSCoder()))
        
        let vc = AcrominesListVC(viewModel)
        XCTAssertNotNil(vc)
        XCTAssertNotNil(vc.addSearchBar())
        
        vc.acrominesView.layoutSubviews()
        XCTAssertNotNil(vc.acrominesView.layoutSubviews())
        XCTAssertNotNil(vc.acrominesView)
        XCTAssertNotNil(vc.acrominesView.viewModel)
        XCTAssertNotNil(vc.acrominesView.configureView())
        
        viewModel.fetchAcromines(query: "FBI", type: viewModel.acromineType)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            XCTAssertGreaterThanOrEqual((vc.viewModel?.acromines.value.count ?? 0), 0)
            let cell:AcrominesTableViewCell = vc.acrominesView.tableView(vc.acrominesView.tableview, cellForRowAt: IndexPath(row: 0, section: 0)) as! AcrominesTableViewCell
            XCTAssertNotNil(cell)
            let firstItem = self.viewModel.acromines.value.first?.lfs?[0]
            cell.configureCell(lfs: firstItem)
            XCTAssertEqual(cell.lfsTitle.text, firstItem?.lf)
            //XCTAssertEqual(cell.freqLabel.text, firstItem?.freq)
            //XCTAssertEqual(cell.sinceLabel.text, firstItem?.since)

        })

//        let numberOfRwos = vc.acrominesView.tableView(vc.acrominesView.tableview, numberOfRowsInSection: 0)
//        XCTAssertEqual(vc.viewModel., numberOfRwos)

        
    }
    
    func testViewModelFunctions() {
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel.acromines.value.count, 0)
        
        viewModel.fetchAcromines(query: "FBI", type: viewModel.acromineType)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            XCTAssertGreaterThanOrEqual(self.viewModel.acromines.value.count, 0)
        })
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
