//
//  FurnaceBackupView.swift
//  My Furnace Backups
//
//  Created by Diggo Silva on 29/04/25.
//

import Cocoa

protocol FurnaceBackupViewDelegate: AnyObject {
    func exportTapped()
    func importTapped()
}

class FurnaceBackupView: NSView {
    
    // Ícone de documento
    private lazy var iconImageView: NSImageView = {
        let config = NSImage.SymbolConfiguration(pointSize: 32, weight: .regular)
        let image = NSImage(named: "icon")?.withSymbolConfiguration(config)
        let imageView = NSImageView(image: image ?? NSImage())
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentTintColor = .labelColor
        return imageView
    }()
    
    // Título
    private lazy var titleLabel: NSTextField = {
        let label = NSTextField(labelWithString: NSLocalizedString("view_title", comment: "Título da tela principal"))
        label.font = NSFont.systemFont(ofSize: 20, weight: .semibold)
        label.alignment = .center
        label.textColor = .labelColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Version
    private lazy var versionLabel: NSTextField = {
        let label = NSTextField(labelWithString: NSLocalizedString("version_title", comment: "Título da versão do app"))
        label.font = NSFont.preferredFont(forTextStyle: .body)
        label.alignment = .center
        label.textColor = .labelColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Checkbox para exportar como .zip
    lazy var zipCheckbox: NSButton = {
        let title = NSLocalizedString("zip_checkbox", comment: "Título do checkbox para exportar como .zip")
        let button = NSButton(checkboxWithTitle: title, target: nil, action: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // Botão de exportação
    lazy var exportButton: HighlightButton = {
        let title = NSLocalizedString("export_button", comment: "Título do botão Exportar")
        let btn = HighlightButton(title: title, target: self, action: #selector(exportTapped))
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isBordered = false
        btn.bezelStyle = .regularSquare
        btn.contentTintColor = .white
        btn.font = NSFont.systemFont(ofSize: 14, weight: .medium)
        btn.setBackgroundColor(.controlAccentColor)
        return btn
    }()

    // Botão de importação
    lazy var importButton: NSButton = {
        let title = NSLocalizedString("import_button", comment: "Título do botão Importar")
        let btn = HighlightButton(title: title, target: self, action: #selector(importTapped))
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isBordered = false
        btn.bezelStyle = .regularSquare
        btn.contentTintColor = .white
        btn.font = NSFont.systemFont(ofSize: 14, weight: .medium)
        btn.setBackgroundColor(.controlAccentColor)
        return btn
    }()
    
    // Label Copyright
    private lazy var copyrightLabel: NSTextField = {
        let label = NSTextField(labelWithString: "Copyright © 2025 Diggo Silva")
        label.alignment = .center
        label.textColor = .labelColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Verifica se o checkbox está ativado
    var shouldExportZip: Bool {
        return zipCheckbox.state == .on
    }
    
    // Delegate
    weak var delegate: FurnaceBackupViewDelegate?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        [iconImageView, titleLabel, versionLabel, exportButton, zipCheckbox, importButton, copyrightLabel].forEach { addSubview($0) }

        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            iconImageView.widthAnchor.constraint(equalToConstant: 100),
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            versionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            versionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            exportButton.topAnchor.constraint(equalTo: versionLabel.bottomAnchor, constant: 24),
            exportButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            exportButton.widthAnchor.constraint(equalToConstant: 180),
            exportButton.heightAnchor.constraint(equalToConstant: 24),
            
            zipCheckbox.topAnchor.constraint(equalTo: exportButton.bottomAnchor, constant: 12),
            zipCheckbox.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            importButton.topAnchor.constraint(equalTo: zipCheckbox.bottomAnchor, constant: 24),
            importButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            importButton.widthAnchor.constraint(equalTo: exportButton.widthAnchor),
            importButton.heightAnchor.constraint(equalTo: exportButton.heightAnchor),
            
            copyrightLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            copyrightLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
        ])
    }
    
    @objc private func exportTapped() {
        delegate?.exportTapped()
    }
    
    @objc private func importTapped() {
        delegate?.importTapped()
    }
}
