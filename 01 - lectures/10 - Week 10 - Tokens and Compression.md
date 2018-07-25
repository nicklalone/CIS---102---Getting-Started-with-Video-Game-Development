**By the end of this week you should be able to:**
1. Edit your code to save space, tokens, and ease compression.
1. Get started on optimization.
1. Understand what those tokens and characters mean at the bottom of the PICO-8 Code Editor
---
Generally, two things are true with computers. 
1. They get faster.
1. They can store more stuff.

This has lead to a very specific issue: *[Code Bloat](https://en.wikipedia.org/wiki/Code_bloat).*

Programs are ridiculously long, often needlessly so. This forces game companies to hire more people, spend way too much money on their game development, and over time has made the gaming market fragile. 

This bloat is what makes it so hard to understand how programming works. We see these games with their giant number of pixels, polygons, procedures, levels, and content and think: "oh, I guess this is a video game." It deflates the sails of just about anyone interested in getting in to games. 

But the fantasy console world of places like PICO-8 allow us to re-engage programming and game making in the modern realm using the limitations that forced us to keep our code trim, neat, and tidy. This week is all about that process.

Now, you guys (or most of you) are very new to programming. I'm not going to absolutely force this stuff on you so this week is mostly readings about concepts that you can dig in to on your own time. However, you will still have to make ...at least an edit or two. 
---
### Tokens and Optimizations
This might mean nothing to you now but PICO-8 is a purposefully limited environment. It is limited in an effort to get programmers and designers to think outside the box, outside normal processes. The results are a machine that can help teach programming or for experienced programmers - hone their craft. 

The limitations of each cart are as such that: 
* each cart can hold 15,360 bytes of compressed code.
* the maximum character length of a cart is 65,536 characters.
* 8,192 tokens 

Each cart has a number of pieces of memory reserved. 
* 12,544 bytes for graphics.
* 4,608 bytes for sound. 

When the cart is booted, it is sent to RAM where it can be accessed quickly and changed as needed. The map and pixel-based sprites are restriced to: 
* 8x8 pixel sprites of which there can be 256 of them.
* The map consists of 128 x 32 sprites though it can be doubled if you have half the sprites. 

There are also 32 note locations for sound of which each can exist in 8 different ways.

Each of these limitations result in something that - as you expand your game's complexity - you will begin to run in to these. There's no real way that is *correct* to edit and compress your code, but these readings should help get you acquainted with some ideas.

### readings
1. [PICO-8 Token Optimizations](https://github.com/seleb/PICO-8-Token-Optimizations)
1. [A TweetJam Summary of Optimization Methods](https://gist.github.com/kometbomb/7ab11b8383d3ac94cbfe1be5fb859785)
1. [A PICO-8 Space Shooter in 16 GIFS](https://www.lexaloffle.com/bbs/?tid=3948)
1. [A Post-Mortem on a Game Called Under-Construction](https://eev.ee/release/2016/05/25/under-construction-our-pico-8-game/#the-pico-8s-limits)



