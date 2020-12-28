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

Tutti helps you create onboarding expericences like hints and single- or multi-screen tutorials. 

<p align="center">
    <img src ="Resources/Demo.gif" />
</p>

Tutti has different onboarding types. Standard hints and tutorials are shown right away and only once, while other types require multiple presentation attempts, a certain number of "incorrect" actions etc. You can combine various types to create new ones.

You can reset the display state of any onboarding if you want to display it again. Tutti also supports multiple users, so that each onboarding is unique to each user.


## Install

### <a name="spm"></a>Swift Package Manager

```
https://github.com/danielsaidi/Tutti.git
```

### CocoaPods

```ruby
pod 'Tutti'
```


## Onboarding

In Tutti, the `Onboarding` class is at the core of the onboarding logic. It can be used to apply different onboarding rules and is what determines whether or not a hint or tutorial should be presented.

Check out [this onboarding guide][Onboarding] for more information on how to work with onboarding.


## Hints

Tutti comes with a set of built-in hint types that can be used for different purposes.

Check out [this hint guide][Hints] for more information on how to create and present hints.


## Tutorials

Tutti comes with a set of built-in tutorial types that can be used for different purposes.

Check out [this tutorial guide][Tutorials] for more information on how to create and present tutorials.


## Demo App

This repository contains a demo app that demonstrates different types of hints and tutorials. To try it out, open and run the `TuttiDemo.xcodeproj` project.


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

[Onboarding]: https://github.com/danielsaidi/Tutti/blob/master/Readmes/Onboarding.md
[Hints]: https://github.com/danielsaidi/Tutti/blob/master/Readmes/Hints.md
[Tutorials]: https://github.com/danielsaidi/Tutti/blob/master/Readmes/Tutorials.md
