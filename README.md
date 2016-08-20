# Tutti

[![CI Status](http://img.shields.io/travis/danielsaidi/Tutti.svg?style=flat)](https://travis-ci.org/danielsaidi/Tutti)
[![Version](https://img.shields.io/cocoapods/v/Tutti.svg?style=flat)](http://cocoapods.org/pods/Tutti)
[![License](https://img.shields.io/cocoapods/l/Tutti.svg?style=flat)](http://cocoapods.org/pods/Tutti)
[![Platform](https://img.shields.io/cocoapods/p/Tutti.svg?style=flat)](http://cocoapods.org/pods/Tutti)


Tutti is a Swift library that can be used to create tutorials and onboarding in
iOS. It is currently limited to the functionality I need in my own apps. I will
extend it as those apps become more sophisticated over time.



## Getting started

I have currently not had time to setup a demo that shows how you build a custom
tutorial on top of this library. For now, have a look at the code.

Feel free to create a demo project for this project, that demonstrates how this
library can be used to create great tutorials and onboarding experiences.



## Creating tutorials

When you create tutorials with Tutti, every new tutorial must be given a unique
identifier. Tutti will remember if a tutorial has been previously displayed, so
that users sees a tutorial only once (using the `hasBeenDisplayed` property).

The `Tutorial` protocol can be used to create custom tutorials. It handles page
information and has a function for retrieving the name of tutorial resources. A
resource can be anything you need, such as localization keys, images etc.

The `TutorialBase` class provides you with basic tutorial logic. It gets you up
and running quickly. Override the functions that do not behave the way you like.
The default resource name convention scheme in a TutorialBase-based tutorial is
`tutorial_[identifier]_[index]_[resourceName]`. This means that the name of the
title of the "welcome" tutorial's third page is `tutorial_welcome_2_title`. Use
the `getResourceName()` function to resolve the name of any resource.

The `LocalizationBasedTutorial` class inherits TutorialBase and provides a more
automated way to create multi-page tutorials. It uses the `Localizable.strings`
file and uses language keys to setup pages in a tutorial. As long as `title` or
`text` keys exists for a tutorial page, it creates a new page and increment the
page count. So, if a "tutorial_welcome_0_title" and a "tutorial_welcome_1_text"
key exists in the language file, the welcome tutorial will have two pages.



## Displaying tutorials

For now, Tutti only comes with one view controller, that can display multi-page
tutorials. A future improvement will be to create ways of showing a simple hint
popover over a button, tutorial sequences etc. Feel free to contribute!


### TutorialViewController

The `TutorialViewController` class can be used to show a tutorial anywhere. Use
`showTutorial(...)` to show a tutorial, then bind the various IBActions to your
view. `next`, `proceed` and `previous` navigate through the pages of a tutorial.
While `next` does not go past the last page, `proceed` automatically closes the
tutorial after the last page. `close` automatically marks a tutorial as already
displayed. TutorialViewController will never show that tutorial again.

TutorialViewController provides you with several outlets, e.g. a next, previous,
proceed and close button, a page control that displays dots for available pages,
an image view as well as a title and text label. The outlets will automatically
refresh when the current page changes. The image view will automatically use an
image with the same name as the current page's unique id.

TutorialViewController has a `swipeable` boolean property. If true (it is false
by default), users will be able to swipe left and right to navigate through the
tutorial. Set the `swipeRightMode` property to .Next or .Proceed to set whether
or not a user can swipe to close the last page.

By default, the TutorialViewController class uses a fade animation when opening
and closing an animation as well as a slide animation when moving between pages.
For now, you can override the four `animateOpen`, `animateClose`, `animateNext`,
and `animatePrevious` functions to customize these animations.



## Example

To run the demo project, clone the repo, and run `pod install` from the Example
directory before running the app.

For now, the demo project is empty and is only used to verify that the pod will
compile properly.



## Requirements

Tutti requires iOS 8 or later.



## CocoaPods

Tutti is available through [CocoaPods](http://cocoapods.org). To add it to your
project, simply add the following line to your Podfile:

```ruby
pod "Tutti"
```



## Author

Daniel Saidi, daniel.saidi@gmail.com



## License

Tutti is available under the MIT license. See the LICENSE file for more info.
