//
//  SimpleNewsAppSwift2Tests.swift
//  SimpleNewsAppSwift2Tests
//
//  Created by Ilya Doroshkevitch on 26.08.2021.
//

import XCTest
@testable import SimpleNewsAppSwift2

class SimpleNewsAppSwift2Tests: XCTestCase {

    var sut: MainTableViewController!

    override func setUpWithError() throws {
        sut = MainTableViewController()
    }

    override func tearDownWithError() throws {
       sut = nil
    }

    func testViewsLoading() throws {
        XCTAssertNotNil(sut?.view, "View not initiated properly")
    }

    func testParentViewHasTableViewSubview() throws {
        let subviews = sut?.view.subviews
        XCTAssertTrue(((subviews?.contains((sut?.tableView)!)) != nil), "")
    }

    func testThatTableViewLoads() throws {
        XCTAssertNotNil(sut?.tableView, "TableView not initiated");
    }

    func testThatViewConformsToUITableViewDataSource() throws {
        XCTAssertTrue(((sut?.conforms(to: UITableViewDataSource.self)) != nil), "")
    }

    func testThatViewConformsToUITableViewDelegate() throws {
        XCTAssertTrue(((sut?.conforms(to: UITableViewDelegate.self)) != nil), "")
    }

    func testTableViewIsConnectedToDelegate() throws {
        XCTAssertNotNil(sut?.tableView.delegate, "Table delegate cannot be nil");
    }

    func testTableViewIsConnectedToDataSource() throws {
        XCTAssertNotNil(sut?.tableView.dataSource, "Table dataSource cannot be nil");
    }

    func testTableViewNumberOfRowsInSection() throws {
        let expectedRows = 0
        XCTAssertTrue(sut?.tableView.numberOfRows(inSection: 0) == expectedRows, "Table has \(String(describing: sut?.tableView.numberOfRows(inSection: 0))) but it should have \(expectedRows)")
    }

    func testTableViewHeightForRowAtIndexPath() throws {
        let expectedHeight = CGFloat(100)
        let actualHeight = sut?.tableView.rowHeight
        XCTAssertEqual(expectedHeight, actualHeight, "Cell should have \(expectedHeight) height but it has \(String(describing: actualHeight))")
    }

//    func testTableViewCellCreateCellsWithReuseIdentifier() throws {
//        sut?.loadViewIfNeeded()
//        let cell = sut?.tableView((sut?.tableView)!, cellForRowAt: IndexPath(row: 0, section: 0)) as? NewsTableViewCell
//        let actualReuseIdentifer = cell?.reuseIdentifier
//        let expectedReuseIdentifier = "newsCell"
//        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
//    }
//
//    func testCellForRowAtIndexPathReturnsNewsCell() throws {
//        sut.loadViewIfNeeded()
//        sut.tableView.reloadData()
//
//        let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
//        XCTAssertTrue(cell is NewsTableViewCell)
//    }

    func testTableViewViewModelIsNotNilWhenLoaded() throws {
        sut?.loadViewIfNeeded()
        XCTAssertNotNil(sut?.viewModel, "viewModel is not loaded")
    }
}
