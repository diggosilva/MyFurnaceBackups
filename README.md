# MyFurnaceBackups

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.9.1-orange.svg" />
    <img src="https://img.shields.io/badge/Xcode-15.2.X-orange.svg" />
    <img src="https://img.shields.io/badge/platforms-iOS-brightgreen.svg?style=flat" alt="iOS" />
    <a href="https://www.linkedin.com/in/rodrigo-silva-6a53ba300/" target="_blank">
        <img src="https://img.shields.io/badge/LinkedIn-@RodrigoSilva-blue.svg?style=flat" alt="LinkedIn: @RodrigoSilva" />
    </a>
</p>

# 💾 My Furnace Backup App for macOS 11.5 or later 🇺🇸

The **My Furnace Backup App** is a simple and essential tool for users of the **Furnace** Tracker application on macOS. It was created with the goal of protecting your data, allowing you to easily **back up and restore** your Furnace save files (`.fur`), ensuring you never lose your creations, even when you switch or format your Mac.

## ✨ Features

* **Quick Export:** Back up all your `.fur` files at once to any folder you choose.
* **Simple Import:** Restore your backups to the Furnace folder with a single click.
* **ZIP Compression:** Option to compress backups into a single `.zip` file for easy transport and storage.
* **Native macOS Interface:** A familiar and integrated system experience.

## ⚠️ System Warnings and Permissions

To function correctly, the application needs to access the Furnace data folder, which is located in a protected macOS directory (`~/Library/Application Support/`).

The first time you use the app, macOS may ask for your permission to access this folder. **It is crucial that you grant this permission** so the app can read and copy the backup files. If you do not grant permission, the application will not be able to perform export or import operations and will display an error message.

## 📥 How to Use

1.  **Download the App:** Download the `.zip` file of the latest version from the [Releases page](https://github.com/YOUR_USERNAME/YOUR_REPOSITORY/releases/latest).
2.  **Move to the Applications Folder:** Unzip the file and drag the **My Furnace Backup.app** to your **Applications** folder.
3.  **Open the App:** Double-click the app icon. The first time, you might need to right-click and choose "Open" to bypass Gatekeeper protection.
4.  **Grant Permission:** If the system prompts you, grant access to the `~/Library/Application Support/Furnace/backups` folder.

### ➡️ Exporting (Saving) Your Backups

1.  Open the app and click the **"Export"** button.
2.  Select the destination folder where you want to save your backups (e.g., on a flash drive or your iCloud Drive).
3.  The app will copy all `.fur` files from your Furnace installation to the folder you chose.
4.  If the **"Compress to .zip"** option is checked, a compressed file will also be created.

### ➡️ Importing (Restoring) Your Backups

1.  Open the app and click the **"Import"** button.
2.  Select the folder where your backups are stored.
3.  The app will copy the files back to the Furnace backups folder, restoring your data.
4.  If there are files with the same name, the app will skip them to avoid overwriting existing data.

## 🛠️ Technologies Used

The project was developed in **Swift** and **Xcode**, using native **macOS** APIs to ensure maximum compatibility and performance.

## 🤝 Contributions

Contributions are welcome! If you find a bug, have a suggestion for an improvement, or want to add a new feature, feel free to open an *issue* or submit a *pull request*.

## 📄 License

- This project is licensed under the MIT License. See the `LICENSE` file for more details.
- MIT License © Diggo Silva

---

# 💾 My Furnace Backup App para macOS 11.5 ou posterior 🇧🇷

O **My Furnace Backup App** é uma ferramenta simples e essencial para usuários do aplicativo Tracker **Furnace** no macOS. Ele foi criado com o objetivo de proteger seus dados, permitindo que você **faça backup e restaure facilmente** os arquivos de salvamento do Furnace (`.fur`), garantindo que você nunca perca suas criações, mesmo ao trocar ou formatar o seu Mac.

## ✨ Recursos

* **Exportação Rápida:** Faça backup de todos os seus arquivos `.fur` de uma só vez para qualquer pasta que você escolher.
* **Importação Simples:** Restaure seus backups para a pasta do Furnace com um clique.
* **Compressão em ZIP:** Opção para compactar os backups em um único arquivo `.zip` para facilitar o transporte e o armazenamento.
* **Interface Nativa do macOS:** Uma experiência familiar e integrada ao sistema.

## ⚠️ Avisos e Permissões de Sistema

Para funcionar corretamente, o aplicativo precisa acessar a pasta de dados do Furnace, localizada em um diretório protegido do macOS (`~/Library/Application Support/`).

Na primeira vez que você usar o aplicativo, o macOS pode solicitar sua permissão para acessar esta pasta. **É crucial que você conceda essa permissão** para que o app consiga ler e copiar os arquivos de backup. Se você não conceder a permissão, o aplicativo não conseguirá realizar as operações de exportação ou importação e exibirá uma mensagem de erro.

## 📥 Como Usar

1.  **Baixe o Aplicativo:** Faça o download do arquivo `.zip` da última versão na [página de Releases](https://github.com/diggosilva/MyFurnaceBackups/releases/latest).
2.  **Mova para a Pasta de Aplicativos:** Descompacte o arquivo e arraste o **My Furnace Backup.app** para a sua pasta **Aplicativos**.
3.  **Abra o Aplicativo:** Clique duas vezes no ícone do aplicativo. Na primeira vez, você pode precisar clicar com o botão direito e escolher "Abrir" para ignorar a proteção do Gatekeeper.
4.  **Conceda a Permissão:** Se o sistema solicitar, conceda acesso à pasta `~/Library/Application Support/Furnace/backups`.

### ➡️ Exportando (Salvando) seus Backups

1.  Abra o aplicativo e clique no botão **"Exportar"**.
2.  Selecione a pasta de destino onde você deseja salvar seus backups (por exemplo, em um pendrive ou no seu iCloud Drive).
3.  O aplicativo irá copiar todos os arquivos `.fur` da sua instalação do Furnace para a pasta que você escolheu.
4.  Se a opção **"Compactar em .zip"** estiver marcada, um arquivo compactado será criado.

### ➡️ Importando (Restaurando) seus Backups

1.  Abra o aplicativo e clique no botão **"Importar"**.
2.  Selecione a pasta onde seus backups estão armazenados.
3.  O aplicativo irá copiar os arquivos de volta para a pasta de backups do Furnace, restaurando seus dados.
4.  Se houver arquivos com o mesmo nome, o aplicativo irá ignorá-los para evitar sobrescrever dados.

## 🛠️ Tecnologias Utilizadas

O projeto foi desenvolvido em **Swift** e **Xcode**, usando APIs nativas do **macOS** para garantir a máxima compatibilidade e desempenho.

## 🤝 Contribuições

Contribuições são bem-vindas! Se você encontrar um bug, tiver uma sugestão de melhoria ou quiser adicionar um novo recurso, sinta-se à vontade para abrir uma *issue* ou enviar um *pull request*.

## 📄 Licença

- Este projeto está licenciado sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.
- MIT License © Diggo Silva
