//
//  FurnaceErrors.swift
//  My Furnace Backups
//
//  Created by Diggo Silva on 28/04/25.
//

import Foundation

enum ExportError: LocalizedError {
    case exportCancelled
    case furnaceBackupsFolderMissing
    case noBackupsAvailable
    
    var errorDescription: String? {
        switch self {
        case .exportCancelled: return NSLocalizedString("export_cancelled_desc", comment: "")
        case .furnaceBackupsFolderMissing: return NSLocalizedString("furnace_folder_missing", comment: "")
        case .noBackupsAvailable: return NSLocalizedString("no_backups_available", comment: "")
        }
    }
}

enum ImportError: LocalizedError {
    case importCancelled
    case noBackupsFound
    case missingCriticalDirectory(path: String)
    case backupsIsFile
    
    var errorDescription: String? {
        switch self {
        case .importCancelled: return NSLocalizedString("import_cancelled_desc", comment: "")
        case .noBackupsFound: return NSLocalizedString("no_backups_found_desc", comment: "")
        case .missingCriticalDirectory(let path): return NSLocalizedString("missing_critical_dir", comment: "") + " \(path)"
        case .backupsIsFile: return NSLocalizedString("backups_is_file", comment: "")
        }
    }
}
