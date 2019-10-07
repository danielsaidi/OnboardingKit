<p align="center">
    <img src ="Resources/Logo.png" width="400" />
</p>

<p align="center">
    <a href="https://github.com/danielsaidi/Tutti">
        <img src="https://badge.fury.io/gh/danielsaidi%2FTutti.svg?style=flat" alt="Version" />
    </a>
    <img src="https://img.shields.io/cocoapods/p/Tutti.svg?style=flat" alt="Platform" />
    <img src="https://img.shields.io/badge/Swift-5.1-orange.svg" alt="Swift 5.1" />
    <img src="https://badges.frapsoft.com/os/mit/mit.svg?style=flat&v=102" alt="License" />
    <a href="https://twitter.com/danielsaidi">
        <img src="https://img.shields.io/badge/contact-@danielsaidi-blue.svg?style=flat" alt="Twitter: @danielsaidi" />
    </a>
</p>


## About Tutti

Tutti is a Swift library that helps you create onboarding expericences, like quick hints and single- or multi-screen tutorials.

<p align="center">
    <img src ="Resources/Demo.gif" />
</p>

Tutti will only display a hint/tutorial once by default. You can reset the display state of a hint/tutorial if you want to display it multiple times.

Tutti also supports user-specific hints/tutorials. Just set the `userId` parameter and Tutti will display the hint/tutorial once for every new user.


## Install

### <a name="spm"></a>Swift Package Manager

The easiest way to add Tutti to your project is to use Swift Package Manager:

```swift
https://github.com/danielsaidi/Tutti.git
```

### CocoaPods

```ruby
pod 'Tutti'
```

### Carthage

```ruby
github "danielsaidi/Tutti"
```

### Manual

To manually add `Tutti` to your app without a dependency manager, clone this repository, add `Tutti.xcodeproj` to your project and `Tutti.framework` as an embedded app binary and target dependency.


## Demo App

This repository contains a demo app that demonstrates different types of hints and tutorials. To try it out, open and run the `Tutti.xcodeproj` project.


## Hints

Tutti comes with a set of built-in hint types that can be used for different purposes. 

* `StandardHint` - A basic hint with no specific behavior.
* `DeferredHint` - Requires a certain number of presentation attempts before it is presented.
* `CorrectBehaviorHint` - Can be used to show a hint when a user is not behaving as intended.

You can also create your own custom hint types by implementing the `Hint` protocol.

Check out [this guide][Hints] for more information on how to create and present hints.


## Tutorials

Tutti comes with a set of built-in tutorial types that can be used for different purposes. 

* `StandardTutorial` - A basic tutorial with no specific behavior.
* `DeferredTutorial` - Requires a certain number of presentation attempts before it is presented.
* `CorrectBehaviorTutorial` - Can be used to show a tutorial when a user is not behaving as intended.

You can also create your own custom tutorial types by implementing the `Tutorial` protocol.

Check out [this guide][Tutorials] for more information on how to create and present tutorials.


## Contact me

I hope you like this library. Feel free to reach out if you have questions or if you want to contribute in any way:

* E-mail: [daniel.saidi@gmail.com][Email]
* Twitter: [@danielsaidi][Twitter]
* Web site: [danielsaidi.com][Website]


## License

Tutti is available under the MIT license. See LICENSE file for more info.

[Email]: mailto:daniel.saidi@gmail.com
[Twitter]: http://www.twitter.com/danielsaidi
[Website]: http://www.danielsaidi.com

[Carthage]: https://github.com/Carthage/Carthage
[CocoaPods]: https://cocoapods.org/

[Hints]: https://github.com/danielsaidi/Tutti/blob/master/Readmes/Hints.md
[Tutorials]: https://github.com/danielsaidi/Tutti/blob/master/Readmes/Tutorials.md
