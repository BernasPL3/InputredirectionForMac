import Cocoa
import GameController
import AVFoundation
import ScreenCaptureKit

class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    var statusLabel: NSTextField!

    func applicationDidFinishLaunching(_ notification: Notification) {

        setupWindow()
        setupControllerSupport()
        startScreenCapture()
    }

    func setupWindow() {

        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 900, height: 600),
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

        statusLabel = NSTextField(labelWithString: "Iniciando...")
        statusLabel.frame = NSRect(x: 20, y: 540, width: 400, height: 40)

        window.contentView?.addSubview(statusLabel)

        window.makeKeyAndOrderFront(nil)
    }

    func setupControllerSupport() {

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(controllerConnected),
            name: .GCControllerDidConnect,
            object: nil
        )

        GCController.startWirelessControllerDiscovery {
            print("Busca de controles finalizada")
        }
    }

    @objc func controllerConnected(notification: Notification) {

        guard let controller = notification.object as? GCController else {
            return
        }

        statusLabel.stringValue = "Controle conectado: \(controller.vendorName ?? "Desconhecido")"

        controller.extendedGamepad?.buttonA.pressedChangedHandler = {
            button, value, pressed in

            if pressed {
                print("Botão A pressionado")
            }
        }
    }

    func startScreenCapture() {

        statusLabel.stringValue = "Screen Stream iniciado"

        // Aqui depois você pode adicionar:
        // ScreenCaptureKit real
        // transmissão websocket
        // captura de áudio
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()

app.delegate = delegate
app.run()
