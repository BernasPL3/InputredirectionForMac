import Cocoa

let app = NSApplication.shared
let delegate = AppDelegate()

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    func applicationDidFinishLaunching(_ notification: Notification) {

        let screenRect = NSMakeRect(0, 0, 500, 300)

        window = NSWindow(
            contentRect: screenRect,
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )

        window.center()
        window.title = "InputredirectionForMac"
        window.makeKeyAndOrderFront(nil)

        let label = NSTextField(labelWithString: "Inputredirection funcionando!")
        label.frame = NSRect(x: 120, y: 130, width: 300, height: 40)

        window.contentView?.addSubview(label)
    }
}

app.delegate = delegate
app.run()
