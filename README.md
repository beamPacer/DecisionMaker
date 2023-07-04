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

The big takeaway for me for developing with the assistance of chatGPT is that it's still an _assistant_, requiring at least an experienced engineer to evaluate, adjust, and integrate its work. But it has been a huge help as an assistant, and has greatly, greatly reduced the time this project has taken to implement.

Probably the most helpful thing it has been able to do is generate Localizable.strings files, including the translations, just based on the Strings struct. That required zero revisions and was work that would have been both tedious and beyond my skill set (for the translations), and was of course lightning fast. So that was particularly great.

Through the course of working on this project, I saw exactly one basic generation mistake: a missed closing brace. I think that it's incredibly impressive that out of 2194 lines of change, I saw only one basic error like this. There were plenty of high-level mistakes, but chatGPT was able to resolve 99% of those, after the compiler error or missing functionality was pointed out to it.

## AI Coding Statistics

As of the previous commit:

ChatGPT has contributed 2194 lines of change to this branch.
Overall, there have been 6553 lines of change to this branch.

ChatGPT has contributed 33% of the lines of change to this branch. Thanks chatGPT!

> A note about this number: I did specifically account for the ~800 lines of change in the initial commit, which was non-GPT; but many types of changes affect this number in various ways. For example, it went down 5% just because I added the GNU GPL 3 license, which was many lines of non-GPT change. And it's also artificially low because I moved all of the code out of a single file, which were commits that weren't tagged GPT. Etc. A good rule of thumb with this project is that about 90% of the total lines in the UI layer was written by chatGPT, and about 50% of the total lines in the data layer were written by me (because the UI changes necessaitated changes to the data layer, mostly Hashable, Equatable, etc. conformance and also additions of @State and @Binding decorators).
