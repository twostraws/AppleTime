import Foundation

struct JSONOutput: Decodable {
    let devices: [String: [Device]]
}

struct Device: Decodable {
    let udid: String
    let state: String
    let name: String
}

/// Handles running one command and sending back its output.
@discardableResult
func run(_ command: String, with arguments: [String]) -> Data {
    let task = Process()
    task.launchPath = command
    task.arguments = arguments

    let pipe = Pipe()
    task.standardOutput = pipe

    do {
        try task.run()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return data
    } catch {
        print("Running simctl failed; please ensure you have Xcode installed.")
        print("")
        print("Alternatively, run `xcode-select -p` and make sure it points to")
        print("your Xcode installation.")
        exit(1)
    }
}

/// Prints usage information for AppleTime.
func printHelp() {
    print("You can use AppleTime like this:")
    print("   appletime \t\t\t Sets all devices to 9:41")
    print("   appletime reset \t\t Resets all devices to default time")
    print("   appletime \"Custom String\" \t Sets a custom message for the time")
    print("")
    print("Note: Adjusting the simulator time is not supported on tvOS or watchOS.")
    exit(0)
}

// Start by fetching all simulator data.
let xcrun = "/usr/bin/xcrun"
let listArguments = ["simctl", "list", "devices", "-j"]
let jsonOutput = run(xcrun, with: listArguments)
let decoded = try JSONDecoder().decode(JSONOutput.self, from: jsonOutput)

// Now figure out which are actually booted.
var bootedDevices = [Device]()

for device in decoded.devices {
    if device.key.contains("watchOS") || device.key.contains("tvOS") { continue }
    bootedDevices += device.value.filter { $0.state == "Booted" }
}

// Assume 9:41 for the new time; we might overwrite this based on user input.
var newTime = "9:41"

switch CommandLine.arguments.count {
case 2:
    // If we're asked to clear, do it and exit.
    if CommandLine.arguments[1] == "reset" {
        for device in bootedDevices {
            let statusBarArguments = ["simctl", "status_bar", device.udid, "clear"]
            run(xcrun, with: statusBarArguments)
        }

        print("All devices set back to default time.")
    } else if CommandLine.arguments[1] == "help" || CommandLine.arguments[1] == "--help" {
        // For two special commands print out help then exit
        printHelp()
    } else {
        // Use their input as the new time, then proceed with the next case to update the status bar
        newTime = CommandLine.arguments[1]
        fallthrough
    }

case 1:
    // it's Apple Time, baby!
    for device in bootedDevices {
        let statusBarArguments = ["simctl", "status_bar", device.udid, "override", "--time", newTime]
        run(xcrun, with: statusBarArguments)
    }

    print("All devices set to \(newTime).")

default:
    // Ignore all other uses.
    printHelp()
}
