# Tutti

[![Open Source Love](https://badges.frapsoft.com/os/mit/mit.svg?v=102)](https://github.com/ellerbrock/open-source-badge/)
[![GitHub version](https://badge.fury.io/gh/danielsaidi%2FTutti.svg)](http://badge.fury.io/gh/danielsaidi%2FTutti)
[![Build Status](https://api.travis-ci.org/danielsaidi/Tutti.svg)](https://travis-ci.org/danielsaidi/Tutti)


## About Tutti

Tutti is a Swift library that can be used to handle user onboarding expericences.
It lets you create single or multi screen tutorials as well as hints that points
at views or features that you want to highlight.

Tutti will display a certain tutorial/hint once per app install. This means that
even if you tell Tutti to show a certain tutorial/hint every time the app starts,
it will only be shown once. You can also tell Tutti to show a tutorial/hint once
per user.

Tutti will use `UserDefaults` to keep track of already displayed tutorials/hints.
This means that this list will reset if the app is re-installed.


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


## Contact me

Feel free to reach out if you have any questions, or if you want to contribute:

* E-mail: [daniel.saidi@gmail.com](mailto:daniel.saidi@gmail.com)
* Twitter: [@danielsaidi](http://www.twitter.com/danielsaidi)
* Web site: [danielsaidi.com](http://www.danielsaidi.com)


## License

Tutti is available under the MIT license. See LICENSE file for more info.



[Carthage]: https://github.com/Carthage/Carthage
[CocoaPods]: https://cocoapods.org/
