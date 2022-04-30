# Tutorials

In Tutti, a ``Tutorial`` is a single- or multi-page guide that is intended to tell users about important (or non-important) features in your app.

The `Tutorial` base class is a simple data carrier that specifies a set of `pages`. You can create your own custom tutorial types by inheriting the `Tutorial` base class.


## Creating a tutorial

This is the most basic way to create a tutorial:

```swift
let page1 = TutorialPage(title: "Page 1", text: "Text 1", imageName: "image1")
let page2 = TutorialPage(title: "Page 2", text: "Text 2", imageName: "image2")
let page3 = TutorialPage(title: "Page 3", text: "Text 3", imageName: "image3")
let tutorial = Tutorial(pages: [page1, page2, page3])
```

As you can see, ``Tutorial`` has very basic data and just consists of a set of ``TutorialPage``s. Subclass it if you need it to carry more data.


## Localized tutorials

You can use a ``LocalizedTutorial`` to automatically setup a tutorial based on localized strings.

```swift
let tutorial = LocalizedTutorial(id: "welcome")
```

You can then add pages in `Localizable.strings`:

```
"tutorial.welcome.0.title" = "Localized tutorials";
"tutorial.welcome.0.text" = "Localized tutorials resolve their own page count by looking at the available localized strings.\n\nYou can navigate through this tutorial by swiping left/right or by using the next/previous buttons.";
"tutorial.welcome.1.title" = "Automatic page count";
"tutorial.welcome.1.text" = "If you add or remove pages in Localizable.strings, this tutorial will automatically adjust its page count to the available translations.\n\nBy the way, did you notice that the buttons and page indicator changed as you switched page?";
"tutorial.welcome.2.title" = "That's it";
"tutorial.welcome.2.text" = "You have now seen all pages in this tutorial. Try adding more pages in the demo app to see how this tutorial changes. Remember to add new title images and translations.\n\nTap the close button to close this tutorial. It can not be shown again.";
```

This will cause the tutorial to resolve pages based on a bunch of parameters.

Localized tutorials are really powerful and can save you a lot of work. Check out the docs for more information and the demo to see it in practice.


## Presenting a tutorial

To present a tutorial, you can use a ``TutorialPresenter``.

Tutti doesn't come with any built-in presenters and encourages you to write presenters that are specific to your app.

You can create your own presenters by implementing the ``TutorialPresenter`` protocol. Have a look at the demo for examples.


## Connecting a tutorial to an onboarding

In Tutti, tutorials are data carriers while presenters are responsible for presenting tutorials. 

To determine the behavior of a tutorial, you need an onboarding of some kind. Tutti comes with various onboarding types.

If you're not using a ``TutorialPresenter`` (you don't have to), first create an onboarding and check whether or not it should be presented:

```swift
let onboarding = Onboarding(id: "welcome")
guard onboarding.shoulBePresented else { return }
```

If so, you can create a tutorial, present it in any way then register the presentation:

```swift
let tutorial = Tutorial(pages: ...)
// Present the tutorial
onboarding.registerPresentation()
```

If you use a ``TutorialPresenter``, you just have to use `tryPresent` to avoid having to do all these manual steps:

```swift
let onboarding = Onboarding(id: "welcome")
let presenter = MyPresenter()
presenter.tryPresent(onboarding) { 
   // Present the tutorial
}
```

`tryPresent` checks whether or not the onboarding should be presented. If so, the presentation block will be triggered and the presentation will be registered.
