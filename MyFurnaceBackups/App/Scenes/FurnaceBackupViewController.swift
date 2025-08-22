//
//  FurnaceBackupViewController.swift
//  MyFurnaceBackups
//
//  Created by Diggo Silva on 29/04/25.
//

import Cocoa

class FurnaceBackupViewController: NSViewController {
    
    private var backupView: FurnaceBackupView!
    private var viewModel: FurnaceBackupViewModel!
    
    override func loadView() {
        super.loadView()
        backupView = FurnaceBackupView(frame: view.bounds)
        self.view = backupView
        self.view.wantsLayer = true
        backupView.delegate = self
        viewModel = FurnaceBackupViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainMenu()
    }
    
    private func configureMainMenu() {
        let mainMenu = NSMenu()
        let appMenuItem = NSMenuItem()
        mainMenu.addItem(appMenuItem)
        
        let appMenu = NSMenu()
        appMenuItem.submenu = appMenu
        
        appMenu.addItem(NSMenuItem(title: NSLocalizedString("about_menu", comment: ""), action: #selector(showAbout), keyEquivalent: ""))
        appMenu.addItem(NSMenuItem.separator())
        appMenu.addItem(NSMenuItem(title: NSLocalizedString("quit_menu", comment: ""), action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        NSApplication.shared.mainMenu = mainMenu
    }
    
    @objc private func showAbout() {
        let alert = NSAlert()
        alert.messageText = NSLocalizedString("about_title", comment: "")
        alert.informativeText = NSLocalizedString("about_description", comment: "")
        alert.alertStyle = .informational

        alert.addButton(withTitle: NSLocalizedString("view_on_github", comment: ""))
        alert.addButton(withTitle: NSLocalizedString("close_button", comment: ""))

        NSApp.activate(ignoringOtherApps: true)

        if let window = self.view.window {
            alert.beginSheetModal(for: window) { response in
                if response == .alertFirstButtonReturn {
                    if let url = URL(string: Constants.urlGitHub) {
                        NSWorkspace.shared.open(url)
                    }
                }
            }
        } else {
            let response = alert.runModal()
            if response == .alertFirstButtonReturn {
                if let url = URL(string: Constants.urlGitHub) {
                    NSWorkspace.shared.open(url)
                }
            }
        }
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        if let window = view.window {
            window.title = NSLocalizedString("window_title", comment: "")
            window.styleMask.remove(.resizable)
            let fixedSize = NSSize(width: 440, height: 330)
            window.setContentSize(fixedSize)
            window.minSize = fixedSize
            window.maxSize = fixedSize
            window.center()
        }
    }
}

extension FurnaceBackupViewController: FurnaceBackupViewDelegate {
    
    func exportTapped() {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canCreateDirectories = true
        panel.canChooseFiles = false
        panel.allowsMultipleSelection = false
        panel.message = NSLocalizedString("export_window_title", comment: "")

        if let window = self.view.window {
            panel.beginSheetModal(for: window) { [weak self] response in
                guard let self = self, response == .OK, let url = panel.url else {
                    SystemSoundPlayer.playError()
                    self?.showAlert(title: NSLocalizedString("export_cancelled", comment: ""), message: ExportError.exportCancelled.localizedDescription)
                    return
                }
                self.handleExport(to: url)
            }
        } else {
            panel.begin { [weak self] response in
                guard let self = self, response == .OK, let url = panel.url else {
                    SystemSoundPlayer.playError()
                    self?.showAlert(title: NSLocalizedString("export_cancelled", comment: ""), message: ExportError.exportCancelled.localizedDescription)
                    return
                }
                self.handleExport(to: url)
            }
        }
    }
    
    func importTapped() {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canCreateDirectories = false
        panel.canChooseFiles = false
        panel.allowsMultipleSelection = false
        panel.message = NSLocalizedString("import_window_title", comment: "")

        if let window = self.view.window {
            panel.beginSheetModal(for: window) { [weak self] response in
                guard let self = self, response == .OK, let url = panel.url else {
                    SystemSoundPlayer.playError()
                    self?.showAlert(title: NSLocalizedString("import_cancelled", comment: ""), message: ImportError.importCancelled.localizedDescription)
                    return
                }
                self.handleImport(from: url)
            }
        } else {
            panel.begin { [weak self] response in
                guard let self = self, response == .OK, let url = panel.url else {
                    SystemSoundPlayer.playError()
                    self?.showAlert(title: NSLocalizedString("import_cancelled", comment: ""), message: ImportError.importCancelled.localizedDescription)
                    return
                }
                self.handleImport(from: url)
            }
        }
    }
    
    private func handleExport(to url: URL) {
        let backupsFolderURL = url.appendingPathComponent("FurnaceBackups")
        
        do {
            let (copied, skipped, total) = try viewModel.exportBackups(to: backupsFolderURL) { current, total in
                print("Exportando arquivo \(current) de \(total)...")
            }
            
            var message = String(format: NSLocalizedString("export_summary", comment: ""), total, copied, skipped)
            
            if backupView.shouldExportZip {
                let zipURL = try viewModel.zipExportedBackups(at: backupsFolderURL)
                message += "\n\n" + String(format: NSLocalizedString("zip_success", comment: ""), zipURL.lastPathComponent)
                viewModel.revealInFinder(url: zipURL)
            } else {
                viewModel.revealInFinder(url: backupsFolderURL)
            }
            
            SystemSoundPlayer.playSuccess()
            showAlert(title: NSLocalizedString("export_done", comment: ""), message: message)
            
        } catch let error as ExportError {
            SystemSoundPlayer.playError()
            showAlert(title: NSLocalizedString("nothing_to_export", comment: ""), message: error.localizedDescription)
        } catch {
            SystemSoundPlayer.playError()
            showAlert(title: NSLocalizedString("export_error", comment: ""), message: error.localizedDescription)
        }
    }
    
    private func handleImport(from selectedFolder: URL) {
        do {
            let (imported, skipped, total) = try viewModel.importBackups(from: selectedFolder) { current, total in
                print("Importando arquivo \(current) de \(total)...")
            }
            
            let message = String(format: NSLocalizedString("import_summary", comment: ""), total, imported, skipped)
            SystemSoundPlayer.playSuccess()
            showAlert(title: NSLocalizedString("import_done", comment: ""), message: message)
            
        } catch let error as ImportError {
            SystemSoundPlayer.playError()
            showAlert(title: NSLocalizedString("nothing_to_import", comment: ""), message: error.localizedDescription)
        } catch {
            SystemSoundPlayer.playError()
            showAlert(title: NSLocalizedString("import_error", comment: ""), message: error.localizedDescription)
        }
    }
    
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = NSAlert()
            alert.messageText = title
            alert.informativeText = message
            alert.alertStyle = .informational
            alert.addButton(withTitle: NSLocalizedString("ok_button", comment: "OK"))

            NSApp.activate(ignoringOtherApps: true)

            if let window = self.view.window {
                alert.beginSheetModal(for: window, completionHandler: nil)
            } else {
                alert.runModal()
            }
        }
    }
}
