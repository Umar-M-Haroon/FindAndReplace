import SPMUtility
import Foundation

let parser = ArgumentParser(usage: "<options>", overview: "A Swift command-line tool to add 2 script tags to some eloka sites")


let arguments = ProcessInfo.processInfo.arguments.dropFirst()

let folderArgument = parser.add(option: "--folder", shortName: "-f", kind: String.self, usage: "The folder to add the tags")
let findArgument = parser.add(option: "--find_text", shortName: "-ft", kind: String.self, usage: "The text you wish to find")
let replaceArgument = parser.add(option: "--replace", shortName: "-r", kind: String.self, usage: "The text you want it to be replaced with")
let extensionArgument = parser.add(option: "--extension", shortName: "-e", kind: String.self, usage: "File extension to recursively search")


let fileManager = FileManager.default


do {
    let parsedArguments = try parser.parse(Array(arguments))
    let folder = parsedArguments.get(folderArgument) ?? fileManager.currentDirectoryPath



    let defaultFindText =
    """
    <div id="skip-link">
    """
    let defaultReplaceText =
    """
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://ciresgroups.colorado.edu/eloka-menu/collections-menu.js"></script>
    <div id="skip-link">
    """

    let findText = parsedArguments.get(findArgument) ?? defaultFindText
    let replaceText = parsedArguments.get(replaceArgument) ?? defaultReplaceText
    let elementExtension = parsedArguments.get(extensionArgument) ?? "html"
    let enumerator = fileManager.enumerator(atPath: folder)

    while let element = enumerator?.nextObject() as? String{
        if element.hasSuffix(elementExtension){
            let path = folder + "/" + element
            let scrapedHTML = try! String(contentsOfFile: path)
            let addedScriptHTML = scrapedHTML.replacingOccurrences(of: findText, with: replaceText)
            try addedScriptHTML.write(toFile: path, atomically: false, encoding: .utf8)
        }
    }
} catch {
    print("Folder Finder failed with \(error)")
}


