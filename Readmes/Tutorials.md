# Tutorials

Tutti comes with a set of built-in tutorial types that can be used for different purposes. 

* `StandardTutorial` - A basic tutorial with no specific behavior.
* `DeferredTutorial` - Requires a certain number of presentation attempts before it is presented.
* `CorrectBehaviorTutorial` - Can be used to show a tutorial when a user is not behaving as intended.

You can also create your own custom tutorial types by implementing the `Tutorial` protocol.


## Creating a tutorial

This is the most basic way to create a tutorial:

```swift
func createTutorial(for userId: String?) -> Tutorial {
    return StandardTutorial(
        identifier: "standard", 
        pageCount: 2,
        userId: userId)
}
```

You can then use the tutorial's `resourceName(for key: String, at pageIndex: Int)` function to get a suggested name for any kind of resource at any page. 

For instance, adding the following localized strings to your app would provide a title and a text for two pages in a tutorial with the id `standard`:

```swift
/* 
In Localizable.strings, add this to support the standard tutorial:
    "tutorial_standard_0_title" = "Page 1 title";
    "tutorial_standard_0_text" = "Page 1 text";
    "tutorial_standard_1_title" = "Page 2 title";
    "tutorial_standard_1_text" = "Page 2 text";
*/
```

You can also use the `fromLocalizationWithPageIndicationKey` initializer to automatically resolve the correct number of pages. For instance, using `title` as indication key would resolve two pages for the strings above.


## Presenting a tutorial

Tutorials are just data carriers. They don't know anything about how they are to be presented. To present a tutorial, you'll use a `tutorial presenter`, for instance:

```swift
self.presenter = TutorialViewController(nibName: nil, bundle: nil)   // You must keep a strong reference!
presenter.present(tutorial: tutorial, in: self, from: view)
```

This will only have an effect if the tutorial can actually be presented. This means that you don't have to keep track of if a certain tutorial has been presented or not. Tutti handles this for you.


## Tutorial presenters

Tutti only comes with a single built-in tutorial presenter: `TutorialViewController`.

This presenter presents tutorials in a modal view controller that takes over the entire screen. To use it, just add a `TutorialViewController.xib` and a `TutorialViewControllerCell.xib` file to your app, then connect your subviews to any outlets provided by `TutorialViewController`. You can also subclass `TutorialViewController` and add as many outlets and triggers as you want.

Creating your own xibs require a bit of work, but you can always copy the xibs from the demo app and configure them to look the way you want them to look. I don't want to add them to the library, since they are pretty rough and would not provide a nice user experience.