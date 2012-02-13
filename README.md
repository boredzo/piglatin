# piglatin
## A command-line Pig Latin filter for Mac OS X

I wrote this app mainly to demonstrate the `enumerateSubstringsInRange:options:usingBlock:` method in Cocoa.

Usage looks like this:

<pre>% <kbd>piglatin</kbd>
<kbd>Please give me an apple</kbd>
Easeplay ivegay emay anway appleway.</pre>

### A couple of notes for developers

- The program works in-place on a single NSMutableString. This is explicitly allowed by the aforementioned method.
- Punctuation is handled correctly with no additional work. Think of all the edge and corner cases you used to have to nail down when searching for words in a string—now, you send one message, your block gets called with every word, and everything else remains undisturbed.
