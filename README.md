# DecisionMaker

DecisionMaker (name and app icon TBD) is an app that uses weighted average decision making, but hides all of the math from you so you can focus on the vibes of the decision itself.

## Current status

The app is in beta through TestFlight, and is currently feature-complete according to original project specs.

## Coding Philosophy

This codebase is an experiment in coding with chatGPT. The data layer has been written by me, but the UI has been written mostly by chatGPT 4, based on the data layer and my written specs. For the most part this has worked well. Major complaints:
- chatGPT was only trained up until 2021, and iOS 16 was only released in 2022. iOS 16 made some improvements to SwiftUI that turned out to be necessary for iPad support.
- chatGPT 4 gets confused about optionals and bindings pretty frequently.

The big takeaway for me for developing with the assistance of chatGPT is that it's still an _assistant_, requiring at least an experienced engineer to evaluate, adjust, and integrate its work. But it has been a huge help as an assistant, and has greatly, greatly reduced the time this project has taken to implement.

Probably the most helpful thing it has been able to do is generate Localizable.strings files, including the translations, just based on the Strings struct. That required zero revisions and was work that would have been both tedious and beyond my skill set (for the translations), and was of course lightning fast. So that was particularly great.

Through the course of working on this project, I saw exactly one basic generation mistake: a missed closing brace. I think that it's incredibly impressive that out of all of its work (see statistics below), I saw only one basic error like this. There were plenty of high-level mistakes, but chatGPT was able to resolve 99% of those, after the compiler error or missing functionality was pointed out to it.

## AI Coding Statistics

As of the previous commit, and only considering .swift and .strings files:

ChatGPT has contributed 2449 lines of change to this branch.
Overall, there have been 5093 lines of change to this branch.
So, chatGPT has contributed 48% of the lines of change to this branch.

Additionally, ChatGPT has contributed 34 out of 131 commits to this branch, or 25%.

Thanks chatGPT!

|   | Total | chatGPT 4 | Portion thereof |
|---|-------|-----------|-----------------|
|Lines of change|5093|2449|48%|
|Commits|131|34|25%|

## Code File Statistics

Language|files|blank|comment|code
:-------|-------:|-------:|-------:|-------:
Swift|26|328|200|1705
Markdown|2|126|0|517
XML|6|0|0|162
Python|3|18|1|81
JSON|3|0|0|31
--------|--------|--------|--------|--------
SUM:|40|472|201|2496
