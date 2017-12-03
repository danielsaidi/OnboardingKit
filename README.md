# Tutti

[![Open Source Love](https://badges.frapsoft.com/os/mit/mit.svg?v=102)](https://github.com/ellerbrock/open-source-badge/)
[![GitHub version](https://badge.fury.io/gh/danielsaidi%2FTutti.svg)](http://badge.fury.io/gh/danielsaidi%2FTutti)
[![Build Status](https://api.travis-ci.org/danielsaidi/Tutti.svg)](https://travis-ci.org/danielsaidi/Tutti)


<p align="center">
    <img src ="Resources/device.gif" />
</p>

## About Tutti

Tutti is a Swift library that can be used to handle app tutorials and hints. You
can create multiscreen tutorials, hint callouts from views you want to highlight
as well as compose onboarding experiences for entire apps and/or single features.

Tutti will display a certain tutorial/hint once per app install. This means that
even if you tell Tutti to show a certain tutorial/hint every time the app starts,
it will only be shown once. You can also tell Tutti to show it once per user, to
ensure that every new user sees it.

Tutti will use `UserDefaults` to keep track of already displayed tutorials/hints.
This means that, by default, the list will reset if the app is re-installed. You
can tell Tutti to use `keychain` instead, to ensure that the list is never reset.


## Demo Application

The repository contains a demo application. Open the `Tutti` project and run the
`TuttiExample` target to try different types of tutorials and hints.


## Install

Tutti can be installed with `CocoaPods` and `Carthage`:

### CocoaPods

To install Tutti with CocoaPods, add this line to your `Podfile`:

```
pod 'Tutti'
```

then run `pod install`. For more info, visit the [CocoaPod website][CocoaPods].

### Carthage

To install Tutti with Carthage, add this line to your `Cartfile`:

```
github "danielsaidi/Tutti"
```

then run `carthage update`. For more information about library versions, install
options etc. visit [Carthage website][Carthage].


## Tutorials

TBD


## Hints

TBD



## Contact me

Feel free to reach out if you have any questions, or if you want to contribute:

* E-mail: [daniel.saidi@gmail.com](mailto:daniel.saidi@gmail.com)
* Twitter: [@danielsaidi](http://www.twitter.com/danielsaidi)
* Web site: [danielsaidi.com](http://www.danielsaidi.com)





[header-image]: SheeeeeeeeetExample/Assets/Images/title-image.png "Sheeeeeeeeeit"
[demo-gif]: Resources/device.gif "Example gif"

[Carthage]: https://github.com/Carthage/Carthage
[CocoaPods]: https://cocoapods.org/
