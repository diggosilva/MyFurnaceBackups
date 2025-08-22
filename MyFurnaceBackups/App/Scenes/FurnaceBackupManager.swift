//
//  FurnaceBackupManager.swift
//  MyFurnaceBackups
//
//  Created by Diggo Silva on 29/04/25.
//

import Cocoa

protocol FurnaceBackupManagerProtocol {
    func exportBackups(to destinationFolder: URL, progress: ((Int, Int) -> Void)?) throws -> (copied: Int, skipped: Int, total: Int)
    func importBackups(from sourceFolder: URL, progress: ((Int, Int) -> Void)?) throws -> (imported: Int, skipped: Int, total: Int)
    func zipExportedBackups(at folder: URL) throws -> URL
    func revealInFinder(url: URL)
}

class FurnaceBackupManager: FurnaceBackupManagerProtocol {
    let fileManager = FileManager.default
    
    // Caminho para os backups do Furnace
    let furnaceBackupsFolderURL: URL = {
        let path = ("~/Library/Application Support/Furnace/backups" as NSString).expandingTildeInPath
        return URL(fileURLWithPath: path, isDirectory: true)
    }()

    // Busca todos os arquivos .fur na pasta de backups
    func getAllSystemBackups() throws -> [URL] {
        guard fileManager.fileExists(atPath: furnaceBackupsFolderURL.path) else { return [] }

        let contents = try fileManager.contentsOfDirectory(at: furnaceBackupsFolderURL, includingPropertiesForKeys: nil)
        return contents.filter { $0.pathExtension == "fur" }
    }

    // Exporta backups do Furnace para o destino escolhido
    func exportBackups(to destinationFolder: URL, progress: ((Int, Int) -> Void)? = nil) throws -> (copied: Int, skipped: Int, total: Int) {
        try fileManager.createDirectory(at: destinationFolder, withIntermediateDirectories: true, attributes: nil)

        guard fileManager.fileExists(atPath: furnaceBackupsFolderURL.path) else {
            throw ExportError.furnaceBackupsFolderMissing
        }

        let backups = try getAllSystemBackups()
        guard !backups.isEmpty else {
            throw ExportError.noBackupsAvailable
        }

        var copied = 0
        var skipped = 0

        for (index, backup) in backups.enumerated() {
            let destinationFile = destinationFolder.appendingPathComponent(backup.lastPathComponent)
            if fileManager.fileExists(atPath: destinationFile.path) {
                skipped += 1
            } else {
                try fileManager.copyItem(at: backup, to: destinationFile)
                copied += 1
            }
            progress?(index + 1, backups.count)
        }
        return (copied, skipped, backups.count)
    }

    // Importa backups para a pasta do Furnace
    func importBackups(from sourceFolder: URL, progress: ((Int, Int) -> Void)? = nil) throws -> (imported: Int, skipped: Int, total: Int) {
        let contents = try fileManager.contentsOfDirectory(at: sourceFolder, includingPropertiesForKeys: nil)
        let backups = contents.filter { $0.pathExtension == "fur" }

        guard !backups.isEmpty else {
            throw ImportError.noBackupsFound
        }
        
        let applicationSupportPath = ("~/Library/Application Support" as NSString).expandingTildeInPath
        let furnacePath = (applicationSupportPath as NSString).appendingPathComponent("Furnace")
        let backupsPath = (furnacePath as NSString).appendingPathComponent("backups")

        let criticalFolders = [URL(fileURLWithPath: applicationSupportPath), URL(fileURLWithPath: furnacePath)]
        for folder in criticalFolders {
            if !fileManager.fileExists(atPath: folder.path) {
                try fileManager.createDirectory(at: folder, withIntermediateDirectories: false, attributes: nil)
            }
        }
        
        var isDirectory: ObjCBool = false
        if fileManager.fileExists(atPath: backupsPath, isDirectory: &isDirectory) {
            if !isDirectory.boolValue {
                throw ImportError.backupsIsFile
            }
        } else {
            try fileManager.createDirectory(at: URL(fileURLWithPath: backupsPath), withIntermediateDirectories: false, attributes: nil)
        }

        var imported = 0
        var skipped = 0
        var logEntries: [String] = []

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = .current
        let timestamp = dateFormatter.string(from: Date())

        logEntries.append("🚀 Iniciando importação de backups do Furnace em \(timestamp)")
        logEntries.append("📁 Pasta de origem: \(sourceFolder.path)")
        logEntries.append("📁 Pasta de destino: \(furnaceBackupsFolderURL.path)")

        for (index, backup) in backups.enumerated() {
            let destinationFile = furnaceBackupsFolderURL.appendingPathComponent(backup.lastPathComponent)
            if fileManager.fileExists(atPath: destinationFile.path) {
                skipped += 1
                logEntries.append("🔁 Ignorado: \(backup.lastPathComponent) (já existia)")
            } else {
                try fileManager.copyItem(at: backup, to: destinationFile)
                imported += 1
                logEntries.append("✅ Importado: \(backup.lastPathComponent)")
            }
            progress?(index + 1, backups.count)
        }

        logEntries.append("📊 Total: \(backups.count) encontrados, \(imported) importados, \(skipped) ignorados")
        logEntries.append("✅ Importação finalizada em \(dateFormatter.string(from: Date()))")

        let documentsFolder = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let logFolder = documentsFolder.appendingPathComponent("FurnaceBackupApp")
        let logURL = logFolder.appendingPathComponent("import-log.txt")

        try fileManager.createDirectory(at: logFolder, withIntermediateDirectories: true, attributes: nil)
        writeImportLog(to: logURL, entries: logEntries)

        return (imported, skipped, backups.count)
    }
    
    func writeImportLog(to logURL: URL, entries: [String]) {
        let fullLog = entries.joined(separator: "\n")
        do {
            try fullLog.write(to: logURL, atomically: true, encoding: .utf8)
            print("📄 Log de importação salvo em: \(logURL.path)")
        } catch {
            print("❌ Falha ao gravar o log de importação: \(error)")
        }
    }
    
    // Compacta os backups exportados
    func zipExportedBackups(at folder: URL) throws -> URL {
        let zipPath = folder.appendingPathExtension("zip")
        let task = Process()
        task.launchPath = "/usr/bin/zip"
        task.arguments = ["-r", zipPath.path, folder.lastPathComponent]
        task.currentDirectoryURL = folder.deletingLastPathComponent()
        try task.run()
        task.waitUntilExit()

        return zipPath
    }

    // Abre o Finder mostrando o arquivo ou pasta
    func revealInFinder(url: URL) {
        NSWorkspace.shared.activateFileViewerSelecting([url])
    }
}
