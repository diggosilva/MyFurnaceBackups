//
//  FurnaceBackupViewModelTests.swift
//  MyFurnaceBackupsTests
//
//  Created by Diggo Silva on 11/05/25.
//

import XCTest
@testable import MyFurnaceBackups

class MockFurnaceManager: FurnaceBackupManagerProtocol {
    
    var didCallExport = false
    var didCallImport = false
    var didCallZip = false
    var didCallReveal = false
    
    func exportBackups(to destinationFolder: URL, progress: ((Int, Int) -> Void)?) throws -> (copied: Int, skipped: Int, total: Int) {
        didCallExport = true
        progress?(1, 2)
        return (1, 1, 2)
    }
    
    func importBackups(from sourceFolder: URL, progress: ((Int, Int) -> Void)?) throws -> (imported: Int, skipped: Int, total: Int) {
        didCallImport = true
        progress?(1, 2)
        return (1, 1, 2)
    }
    
    func zipExportedBackups(at folder: URL) throws -> URL {
        didCallZip = true
        return folder.appendingPathExtension("zip")
    }
    
    func revealInFinder(url: URL) {
        didCallReveal = true
    }
}

// MARK: - Testes da ViewModel
final class MyFurnaceBackupsTests: XCTestCase {
    
    var mockManager: MockFurnaceManager!
    var sut: FurnaceBackupViewModel!
    
    override func setUp() {
        super.setUp()
        mockManager = MockFurnaceManager()
        sut = FurnaceBackupViewModel(manager: mockManager)
    }
    
    func testExportBackupsCallManager() throws {
        let url = URL(fileURLWithPath: "/tmp")
        let result = try sut.exportBackups(to: url)
        XCTAssertTrue(mockManager.didCallExport)
        XCTAssertEqual(result.copied, 1)
        XCTAssertEqual(result.skipped, 1)
        XCTAssertEqual(result.total, 2)
    }
    
    func testImportBackupsCallManager() throws {
        let url = URL(fileURLWithPath: "/tmp")
        let result = try sut.importBackups(from: url)
        XCTAssertTrue(mockManager.didCallImport)
        XCTAssertEqual(result.imported, 1)
        XCTAssertEqual(result.skipped, 1)
        XCTAssertEqual(result.total, 2)
    }
    
    func testZipExportedBackupsCallManager() throws {
        let url = URL(fileURLWithPath: "/tmp/FurnaceBackups")
        let result = try sut.zipExportedBackups(at: url)
        XCTAssertTrue(mockManager.didCallZip)
        XCTAssertEqual(result.lastPathComponent, "FurnaceBackups.zip")
    }
    
    func testRevealInFinderCallManager() {
        let url = URL(fileURLWithPath: "/tmp/file")
        sut.revealInFinder(url: url)
        XCTAssertTrue(mockManager.didCallReveal)
    }
    
    override func tearDown() {
        sut = nil
        mockManager = nil
        super.tearDown()
    }
}
