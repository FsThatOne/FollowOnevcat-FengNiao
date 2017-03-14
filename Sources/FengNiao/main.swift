import Foundation
import CommandLineKit
import Rainbow

let cli = CommandLineKit.CommandLine()

let projectOption = StringOption(shortFlag: "p", longFlag: "project",
                            helpMessage: "Path to the project.")
let resourceExtensionOption = MultiStringOption(shortFlag: "r", longFlag: "resource-extensions",
                                                helpMessage: "Extensions to search.")
let excludedPathsOption = MultiStringOption(shortFlag: "e", longFlag: "excluded-paths",
                          helpMessage: "Excluded paths not to search in.")

let fileExtension = MultiStringOption(shortFlag: "f", longFlag: "file-extensions", helpMessage: "File extensions to search with")

let help = BoolOption(shortFlag: "h", longFlag: "help",
                      helpMessage: "Prints a help message.")

cli.addOptions(projectOption, resourceExtensionOption, fileExtension, help)

do {
    try cli.parse()
} catch {
    cli.printUsage(error)
    exit(EX_USAGE)
}

cli.formatOutput = { s, type in
    var str: String
    switch(type) {
    case .error:
        str = s.red.bold
    case .optionFlag:
        str = s.green
    case .optionHelp:
        str = s.blue
    default:
        str = s
    }
    
    return cli.defaultFormat(s: str, type: type)
}

if help.value {
    cli.printUsage()
    exit(EX_OK)
}

let project = projectOption.value ?? "."
let resourceExtensions = resourceExtensionOption.value ?? ["png", "jpg", "imageset"]
let fileExtensions = fileExtension.value ?? ["swift", "m", "mm", "xib", "storyboard"]
let excludedPath = excludedPathsOption.value ?? []
