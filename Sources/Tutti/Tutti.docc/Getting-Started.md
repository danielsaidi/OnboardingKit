#  Getting Started

This article describes how to get started with Tutti.



## Installation

Tutti can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/Tutti.git
``` 

or with CocoaPods:

```
pod Tutti
```


## How does it work

In Tutti, an ``Onboarding`` is at the core of the onboarding experience and is what determines whether or not a hint or tutorial should be presented.

There are different types of onboardings, that can help you craft a suitable experience for e.g. a first app onboarding, instructions, games etc.  

A ``Hint`` is a short onboarding message that is intended to be displayed briefly, e.g. in a toast, callout bubble etc. while a ``Tutorial`` is a longer onboarding experience, e.g. a multi-page onboarding.

Hints and tutorials are presented using a ``HintPresenter`` and a ``TutorialPresenter``. Tutti just comes with a few presenters and encourages you to write presenters that are specific to your app.
