# DecisionMaker

DecisionMaker (name and app icon TBD) is an app that uses weighted average decision making, but hides all of the math from you so you can focus on the vibes of the decision itself.

## Current status

The app is in beta through TestFlight, and seems to work properly on phones, pads, and macs (built for iPad).

Other things to consider before go-live:
- iCloud storage for sharing decisions across devices (need to decide on final app name before implementation due to the importance of having a final bundle ID)
- Localization into other languages than English

## Coding Philosophy

This codebase is an experiment in coding with chatGPT. The data layer has been written by me, but the UI has been written mostly by chatGPT 4, based on the data layer and my written specs. For the most part this has worked well. Major complaints:
- chatGPT was only trained up until 2021, and iOS 16 was only released in 2022. iOS 16 made some improvements to SwiftUI that turned out to be necessary for iPad support.
- chatGPT 4 gets confused about optionals and bindings pretty frequently.
- chatGPT hallucinates sometimes, but pretty rarely (using GPT 4) in my experience with this project.

The big takeaway for me for developing with the assistance of chatGPT is that it's still an _assistant_, requiring at least an experienced engineer to evaluate, adjust, and integrate its work. But it has been a huge help as an assistant, and has greatly, greatly reduced the time this project has taken to implement.

Probably the most helpful thing it has been able to do is generate Localizable.strings files, including the translations, just based on the Strings struct. That required zero revisions and was work that would have been both tedious and beyond my skill set (for the translations), and was of course lightning fast. So that was particularly great.

## AI Coding Statistics

As of the previous commit:

ChatGPT has contributed 1465 lines of change to this branch.
Overall, there have been 5111 lines of change to this branch.

ChatGPT has contributed 28% of the lines of change to this branch. Thanks chatGPT!

