Learning website development using Dancer
========================================

A hands-on training session at LPW 2011 to develop a website with dynamic content.

From doing the exercises you will:

 * learn to use the Dancer framework
 * learn to use Template Toolkit 
 * understand the concept of Model-View-Controller
 * experience structuring code for maintainability
 * experience using object oriented Perl modules


What's Dancer?
--------------

Dancer is a micro 'web framework' - a toolkit for developing a dynamic web application.  It is inspired by the Ruby framework, Sinatra.

Prerequisites
-------------
Basic knowledge of:

* Perl (no need for OO Perl)
* Bash/Linux command line interface
* HTML/HTTP 
* A text editor like vi/emacs/pico

Preparation
-----------

* Bring a laptop with an ssh client (e.g. PuTTY or MINGW/MSYS if it's Windows)

Getting Started
---------------
* Login to lpw.illywhacker.net as per the printout received on arrival
* Checkout the learning materials

```
git clone git://github.com/andrewsolomon/training.dancer.lpw.2011.git
```

* When you've done an exercise, view the result at http://lpw.illywhacker.net:[Your Port Number]


Instructions
------------
Do your exercises in the directories

```
training.dancer.lpw.2011/exercises/part1/ex1 
training.dancer.lpw.2011/exercises/part1/ex2
...
```
and if you get stuck, you'll find solutions in 

```
training.dancer.lpw.2011/solutions/part1/ex1 
training.dancer.lpw.2011/solutions/part1/ex2
...
```

Paths to take
-------------
The lesson is divided into two sections:

* Part 1: https://github.com/andrewsolomon/training.dancer.lpw.2011/blob/master/slides/part1.md

This provides you with the basic toolkit of skills for implementing a web site. 

* Part 2: https://github.com/andrewsolomon/training.dancer.lpw.2011/blob/master/slides/part2.md

This is where the interface to the search engine is implemented. If you just want to cut to the chase, you can skip some of the exercises as follows:

<b>Quick (and Dirty) Dancing</b>

- Part 1: Ex 1 - 4, 6, 8
- Part 2: Ex 1 - 4

Further Reading
----------------
* Homepage of Dancer http://perldancer.org/
* Dancer Tutorial http://search.cpan.org/~xsawyerx/Dancer-1.3072/lib/Dancer/Tutorial.pod
* Dancer Plugins http://search.cpan.org/~sukria/Dancer/lib/Dancer/Plugins.pod
* Dancer Advent Calendar 2010 http://advent.perldancer.org/2010
