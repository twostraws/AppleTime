# AppleTime

<p>
    <img src="https://img.shields.io/badge/Swift-5.3-brightgreen.svg" />
    <a href="https://twitter.com/twostraws">
        <img src="https://img.shields.io/badge/Contact-@twostraws-lightgrey.svg?style=flat" alt="Twitter: @twostraws" />
    </a>
</p>

A tiny program that sets the clock in your iOS and iPadOS simulators to be 9:41, which is the time Apple usually uses in its device screenshots. For more information on the back story behind 9:41, [check out this Engadget article](https://www.engadget.com/2014-04-14-why-9-41-am-is-the-always-the-time-displayed-on-iphones-and-ipad.html).

**Note:** Setting the simulator time is not supported on either tvOS or watchOS.


## Installation

If you want to install AppleTime, you have three options: [Homebrew](https://brew.sh), [Mint](https://github.com/yonaskolb/Mint), or building it from the command line yourself. 

**Regardless of which installation approach you choose, you must have Xcode installed in order to adjust the simulator time.**

Use this command for Homebrew:

```bash
brew install twostraws/brew/appletime
```

Using Homebrew allows you to run `appletime` directly from the command line.

For Mint, install and run AppleTime with these command:

```bash
mint install twostraws/AppleTime@main
mint run appletime@main
```

And finally, to build and install the command line tool yourself, clone the repository and run `make install`:

```bash
git clone https://github.com/twostraws/AppleTime
cd AppleTime
make install
```

As with the Homebrew option, building the command line tool yourself allows you to use the `appletime` command directly from the command line.


## Usage

Once installed, you can use AppleTime like this:

* `appletime` sets all running simulator devices to 9:41.
* `appletime reset` resets all simulator devices to default time.
* `appletime "Custom String"` sets a custom message for the time.

If you need more power – if you want to control the WiFi bars, set a virtual map location, simulate push notifications, and more – you should use my free app [Control Room](https://github.com/twostraws/ControlRoom) instead.


## Credits

AppleTime was built by Paul Hudson, and is copyright © Paul Hudson 2021.

AppleTime is licensed under the MIT license; for the full license please see the [LICENSE file](LICENSE). AppleTime is built on top of Apple’s **simctl** command – the team who built that deserve the real credit here.

Swift, the Swift logo, and Xcode are trademarks of Apple Inc., registered in the U.S. and other countries. For the avoidance of doubt, this repository is not affiliated with or sponsored by Apple.

If you find AppleTime useful, you might find my website full of Swift tutorials equally useful: [Hacking with Swift](https://www.hackingwithswift.com).
