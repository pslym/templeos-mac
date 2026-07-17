// Paints the DMG window background: DOS-blue field, gold arrow from the app
// icon slot to the Applications slot, titles top and bottom.
// Usage: swift make_dmg_background.swift <output.png>
import AppKit

let W = 600.0, H = 400.0
let img = NSImage(size: NSSize(width: W, height: H))
img.lockFocus()

let blue = NSColor(calibratedRed: 0, green: 0, blue: 170 / 255, alpha: 1)
let gold = NSColor(calibratedRed: 1, green: 1, blue: 85 / 255, alpha: 1)
blue.setFill()
NSRect(x: 0, y: 0, width: W, height: H).fill()

// arrow between the icon slots (icon centers sit at x=150 and x=450, y=200)
gold.setFill()
NSRect(x: 235, y: 193, width: 95, height: 14).fill()
let tri = NSBezierPath()
tri.move(to: NSPoint(x: 330, y: 224))
tri.line(to: NSPoint(x: 368, y: 200))
tri.line(to: NSPoint(x: 330, y: 176))
tri.close()
tri.fill()

func draw(_ s: String, _ size: CGFloat, _ y: CGFloat, _ color: NSColor, bold: Bool = false) {
    let font = bold ? NSFont.boldSystemFont(ofSize: size) : NSFont.systemFont(ofSize: size)
    let a = NSAttributedString(string: s, attributes: [.font: font, .foregroundColor: color])
    a.draw(at: NSPoint(x: (W - a.size().width) / 2, y: y))
}

draw("TempleOS", 30, H - 68, .white, bold: true)
draw("drag the temple into Applications", 13, H - 92, gold)
draw("courtesy of real nice™ and the Xenophora Corporation 2027.5", 12, 26, .white)

img.unlockFocus()
let rep = NSBitmapImageRep(data: img.tiffRepresentation!)!
let png = rep.representation(using: .png, properties: [:])!
try! png.write(to: URL(fileURLWithPath: CommandLine.arguments[1]))
