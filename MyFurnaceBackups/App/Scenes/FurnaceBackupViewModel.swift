//
//  FurnaceBackupViewModel.swift
//  My Furnace Backups
//
//  Created by Diggo Silva on 29/04/25.
//

import Cocoa

protocol FurnaceBackupViewModelProtocol {
    func exportBackups(to destinationFolder: URL, progress: ((Int, Int) -> Void)?) throws -> (copied: Int, skipped: Int, total: Int)
    func importBackups(from sourceFolder: URL, progress: ((Int, Int) -> Void)?) throws -> (imported: Int, skipped: Int, total: Int)
    func zipExportedBackups(at folder: URL) throws -> URL
    func revealInFinder(url: URL)
}

class FurnaceBackupViewModel: FurnaceBackupViewModelProtocol {
    private var manager: FurnaceBackupManagerProtocol
    
    init(manager: FurnaceBackupManagerProtocol = FurnaceBackupManager()) {
        self.manager = manager
    }

    func exportBackups(to destinationFolder: URL, progress: ((Int, Int) -> Void)? = nil) throws -> (copied: Int, skipped: Int, total: Int) {
        return try manager.exportBackups(to: destinationFolder, progress: progress)
    }

    func importBackups(from sourceFolder: URL, progress: ((Int, Int) -> Void)? = nil) throws -> (imported: Int, skipped: Int, total: Int) {
        return try manager.importBackups(from: sourceFolder, progress: progress)
    }

    func zipExportedBackups(at folder: URL) throws -> URL {
        return try manager.zipExportedBackups(at: folder)
    }

    func revealInFinder(url: URL) {
        manager.revealInFinder(url: url)
    }
}
