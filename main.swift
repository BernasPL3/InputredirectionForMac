import Cocoa
import GameController

class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    var ipField: NSTextField!
    var statusLabel: NSTextField!
    var connectButton: NSButton!

    func applicationDidFinishLaunching(_ notification: Notification) {

        createWindow()
        setupControllerSupport()
    }

    func createWindow() {

        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 700, height: 450),
            styleMask: [
                .titled,
                .closable,
                .miniaturizable,
                .resizable
            ],
            backing: .buffered,
            defer: false
        )

        window.center()
        window.title = "InputredirectionForMac"

        // Título
        let title = NSTextField(labelWithString: "InputRedirection For Mac")
        title.frame = NSRect(x: 20, y: 380, width: 400, height: 40)
        title.font = NSFont.boldSystemFont(ofSize: 28)

        // Texto do IP
        let ipLabel = NSTextField(labelWithString: "Número IP do 3DS:")
        ipLabel.frame = NSRect(x: 20, y: 300, width: 200, height: 30)
        ipLabel.font = NSFont.systemFont(ofSize: 18)

        // Caixa de IP
        ipField = NSTextField(frame: NSRect(x: 20, y: 260, width: 300, height: 35))
        ipField.placeholderString = "Exemplo: 192.168.0.15"

        // Botão conectar
        connectButton = NSButton(
            title: "Conectar",
            target: self,
            action: #selector(connectTo3DS)
        )

        connectButton.frame = NSRect(x: 20, y: 200, width: 150, height: 40)

        // Status
        statusLabel = NSTextField(labelWithString: "Status: Desconectado")
        statusLabel.frame = NSRect(x: 20, y: 150, width: 500, height: 30)
        statusLabel.font = NSFont.systemFont(ofSize: 16)

        // Adiciona elementos
        window.contentView?.addSubview(title)
        window.contentView?.addSubview(ipLabel)
        window.contentView?.addSubview(ipField)
        window.contentView?.addSubview(connectButton)
        window.contentView?.addSubview(statusLabel)

        window.makeKeyAndOrderFront(nil)
    }

    @objc func connectTo3DS() {

        let ip = ipField.stringValue

        if ip.isEmpty {
            statusLabel.stringValue = "Status: Digite um IP"
            return
        }

        statusLabel.stringValue = "Conectando ao 3DS em \(ip)..."

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.statusLabel.stringValue = "Conectado ao 3DS!"
        }
    }

    func setupControllerSupport() {

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(controllerConnected),
            name: .GCControllerDidConnect,
            object: nil
        )

        GCController.startWirelessControllerDiscovery {}
    }

    @objc func controllerConnected(notification: Notification) {

        guard let controller = notification.object as? GCController else {
            return
        }

        statusLabel.stringValue =
        "Controle conectado: \(controller.vendorName ?? "Desconhecido")"
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()

app.delegate = delegate
app.run()
