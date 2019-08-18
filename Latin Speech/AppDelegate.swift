import Cocoa
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var textview: NSScrollView!
    @IBOutlet var textvii: NSTextView!
    var synth = NSSpeechSynthesizer()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
    }

    @IBAction func speak(_ sender: NSButton) {
        let outputs = textvii.string
       // print(outputs)
        let outputts = outputs.replacingOccurrences(of: "[\\s\n]+", with: " ", options: .regularExpression, range: nil)
        let newStringoutput = outputts.replacingOccurrences(of: " ", with: "_")
        let newStringoutput1 = newStringoutput.replacingOccurrences(of: "-", with: "_")
       // print(newStringoutput1)
       // print(newStringoutput)
        let pipe = Pipe()
        let echo = Process()
        echo.launchPath = Bundle.main.path(forResource: "transliterator", ofType: "sh")
        echo.arguments = [newStringoutput1]
        echo.standardOutput = pipe
        echo.launch()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let put: String = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
       // print(put)
        synth.startSpeaking(put)

    }
    @IBAction func Save(_ sender: NSButton) {
        let outputs = textvii.string
        // print(outputs)
        let outputts = outputs.replacingOccurrences(of: "[\\s\n]+", with: " ", options: .regularExpression, range: nil)
        let newStringoutput = outputts.replacingOccurrences(of: " ", with: "_")
        let newStringoutput1 = newStringoutput.replacingOccurrences(of: "-", with: "_")
        // print(newStringoutput)
        let pipe = Pipe()
        let echo = Process()
        echo.launchPath = Bundle.main.path(forResource: "transliterator", ofType: "sh")
        echo.arguments = [newStringoutput1]
        echo.standardOutput = pipe
        echo.launch()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let put: String = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
        let savePanel = NSSavePanel()
        savePanel.canCreateDirectories = true
        savePanel.showsTagField = false
        savePanel.allowedFileTypes = ["aiff"]
        savePanel.nameFieldStringValue = "audio.aiff"
        savePanel.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.modalPanelWindow)))
        savePanel.begin { (result) in
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                print(NSApplication.ModalResponse.OK.rawValue)
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                let filename = savePanel.url
                    
                do {
                    print(filename)
                    self.synth.startSpeaking(put, to: filename!)
                    //let fileExists : Bool = FileManager.default.fileExists(atPath:try String(contentsOf: filename!))
                    
                } catch {
                    // failed to write file (bad permissions, bad filename etc.)
                    print("fail")
                }
            } else {
                __NSBeep()
                print("fail")
            }
                
            }
        }
      //  print(put)
        //synth.startSpeaking(put)
    }
    @IBAction func stop(_ sender: Any) {
        synth.stopSpeaking()
    }
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

