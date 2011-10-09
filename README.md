Learning to Dance
=================

A tutorial at YAPC::EU 2011 on using Dancer.

In this lesson you'll be implementing a website for accessing an airport search engine based on Dancer.

Doing the exercises you'll learn how Dancer is used, and how the code should be structured to make a site easy to change and maintain. 

<b>Teacher:</b> Andrew Solomon <b>Teaching Assistants:</b> Adam Taylor, Liz Goldstein


What's Dancer?
--------------

Dancer is a micro 'web framework' - a toolkit for developing a dynamic web application.  It is inspired by the Ruby framework, Sinatra.

Prerequisites
-------------

* Basic Perl knowledge
* Basic HTML/HTTP knowledge

Preparation
-----------

* Bring a laptop with Perl installed
* Install ```Task::Dancer``` (somewhat large) or install ```Dancer``` and ```Dancer::Template::TemplateToolkit```
* Install ```Data::Types```
* *Either* checkout a copy of this talk ```git clone git://github.com/andrewsolomon/YAPC2011DancingLesson.git``` 
* *Or* download and untar/unzip from the 'Downloads' button https://github.com/andrewsolomon/YAPC2011DancingLesson
* Open the slides with your browser:
  README.www/README.md.html
  README.www/part1.md.html
  README.www/part2.md.html
 
* Check that everything works:

```
$ cd YAPC2011DancingLesson/solutions/part2/airport-toolkit
$ ./bin/search_airports --matching syd
```

If it doesn't run, install any prerequisites we forgot!

Instructions
------------
Do your exercises in the directories

```
YAPC2011DancingLesson/exercises/part1/ex1 
YAPC2011DancingLesson/exercises/part1/ex2
...
```
and if you get stuck, you'll find solutions in 

```
YAPC2011DancingLesson/solutions/part1/ex1 
YAPC2011DancingLesson/solutions/part1/ex2
...
```

Paths to take
-------------
The lesson is divided into two sections:

* Part 1: https://github.com/andrewsolomon/YAPC2011DancingLesson/blob/master/slides/part1.md 

This provides you with the basic toolkit of skills for implementing a web site. 

* Part 2: https://github.com/andrewsolomon/YAPC2011DancingLesson/blob/master/slides/part2.md

This is where the interface to the search engine is implemented. If you just want to cut to the chase, you can skip some of the exercises as follows:

<b>(Quick and) Dirty Dancing</b>

- Part 1: Ex 1 - 4, 6, 8
- Part 2: Ex 1 - 4
