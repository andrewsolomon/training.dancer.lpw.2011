Elementary Web Application
===========================

Concepts
--------

* <b>Route handler</b> - the mapping of a url to a subroutine
* <b>Route types</b>:
    1. ```http://example.com/link/:like/:this``` where all the data is in the url but not a GET
    2. GET query ```http://example.com/more?like=this&orlike=that```
    3. POST query ```http://example.com/justthis```
* <b>Static Web Page</b> - basically just some hard coded HTML
* <b>Web Application</b> - a website where clicking on a button will do some data mining and generate new HTML on the fly.
* <b>Template</b> - HTML files embedded with ```[% directives %]``` containing data generated on the fly


<b>&raquo;Note</b> In case you're an a hurry to implement the search engine in part2, the exercises in part1 which you *must* do first are preceeded by a &raquo;raquo.

&raquo; Exercise 1 - An index route
==============================
Create a directory

```
$ mkdir YAPC2011DancingLesson/exercises/part1/ex1
```

Create the script ```part1/ex1/step1.pl```

```perl
#!/usr/bin/perl

use Dancer;

set logger  => 'console';
set log     => 'debug';
set show_errors => 1;

get '/' => sub {
    return "Hello World!";
};

Dancer->dance;
```


Running it at the command line you should get something like:

```
$ ./step1.pl
>> Dancer server 11757 listening on http://0.0.0.0:3000
```

See what happens when you visit the url with your browser. Replace '0.0.0.0' with the IP address of the machine you're working on.


Things to note about the code:

* ```'use Dancer'``` brings along ```'use strict'``` and ```'use warnings'``` so  we don't need to type them.
* The three settings

```
  set logger    => 'console';
  set log       => 'debug';
  set show_errors => 1;
```

are telling it to keep you informed of what the problem is when
things go wrong to make sure you get as much information as possible.
You'll want to log errors to a file once it's a public website.

* ```get '/' => sub {} ```
says, on an HTTP GET request, call the subroutine on the right 
of the arrow to generate the content of the page to be displayed.

*  ``` Dancer->dance; ``` This is an example of a method call on an object. To use Moose we don't
need to understand how to develop Perl objects - we just need to get a
feel for how to use them.

Now the following commands would have looked a bit suspicious to the Perl newbie:

```
set logger    => 'console';
get '/' => sub {
    return "Hello World!";
};
```

This is just a bit of Perl cosmetics to change the focus of the reader from the subroutine being called, to its arguments. The first of these could just as well have been written

```set('logger', 'console');```

Rewrite the whole script in this way, save it as ``` part1/ex1/step1-back.pl ```

and run it to see that it behaves exactly the same as ``` step1.pl ```

<b>HINT:</b> to understand the ``` get ``` 's second argument set

```
my $hwsub = sub {
    return "Hello World!";
};
```

before calling '```get```' on `$hwsub`.


Finally,

```
$ cp part1/ex1/step1.pl part1/ex1/step2-forward.pl
```

and change the output to be a bit prettier using HTML tags:

```<h1>Hello World!</h1>```


&raquo; Exercise 2: A non-index route
==============================

```
$ cp part1/ex1/step2-forward.pl part1/ex2/step1.pl
```

and create another route handler for the URL

```
    http://0.0.0.0:3000/hello
```

which returns ``` <h1>Turn it all around people!</h1> ```

<b>HINT</b>: Instead of ``` get ```'s first argument as ``` '/' ``` it should be ``` '/hello' ```



&raquo; Exercise 3: Non-static pages 
============================

We've shown how to write static pages, but that's no better than plain HTML. First, 

```
$ cp part1/ex1/step2-forward.pl part1/ex3/step1.pl
```

and then add a new route handler 'time' which shows not just 'Hello World', but also
the time.

That is:

```
http://0.0.0.0:3000/time
```

Displays a page containing: 

```
Hello world, the time is now 2002-12-06 14:02:29
```

<b>HINTS</b>: 

 * Calculate the time using the ```DateTime``` module, its ```now``` creation method, and  its ```ymd``` and ```hms``` methods.

 * ``` $ perldoc DateTime ```

 * Calculate the string to display in the in the route handler


```
my $dt = DateTime->now(time_zone => 'Europe/Riga'); #### FIXME $time should be $dt in the answers
my $s_date = $dt->ymd; my $s_time = $dt->hms;
```


&raquo; Exercise 4: Template Toolkit 
=============================

Now from the previous exercise you are generating HTML from 
within a script. For a small and simple HTML file that's ok, but
if it gets any bigger it will be very difficult to read the 
script picking out the HTML from the Perl or vice versa.

This is what a Template is for - you can separate out the 
HTML into a different file with <i>directives</i> ``` [% date %] ``` and ``` [% time %] ```
which will be filled in by the variables in the Perl script.

Now,

```
$ cp part1/ex3/step1.pl part1/ex4/step1.pl
```

and we'll now change the  

```
    get '/time' 
```

route handler. Instead of returning an HTML string, return

```
    template 'date_time' => { time => $dt->hms, date => $dt->ymd };
```
(or 
```
    template('date_time', { time => $dt->hms, date => $dt->ymd });
```
if it makes you feel safer :)


At the top of the file, add these configuration parameters telling
Dancer you'll be using a template file.

```
 set engines => {
     template_toolkit => 
     {
         start_tag => '[%',
         stop_tag  => '%]'
     }
 };
 set template  => 'template_toolkit';

```


Now, running the script and pointing your browser at ``` http://0.0.0.0:3000/time ```
will give you runtime errors saying that it's looking for the file

``` part1/ex4/views/date_time.tt ```

To fix this, create the file with any HTML content you like, 
and making use of the strings ``` [% date %] ``` and ``` [% time %] ```
which will be filled in by ``` Dancer::Template ```

Run it and make sure it works. The things to note about this:

* ``` template 'date_time' ``` means "look for ``` views/date_time.tt ``` in the ``` views ``` directory
* the hash ref ``` { time => $dt->hms, date => $dt->ymd }  ``` says
"Whenever you see ``` [% time %] ``` replace it with ``` $dt->hms ``` and
whenever you see ``` [% date %] ``` replace it with ``` $dt->ymd ```

For further information about Template Toolkit directives visit this page http://template-toolkit.org/docs/manual/Directives.html


Exercise 4': Dancer bug
-----------------------

<img src="https://github.com/andrewsolomon/YAPC2011DancingLesson/raw/master/slides/images/cybergedeon_warning_banana_skin.jpg" alt="Banana skin" width="200" />


```
$ cp part1/ex4/step1.pl part1/ex4/step2-back.pl
```

and swap the order of the ``` set template ``` and ``` set engines ``` calls. 

<b> What happens? </b>

... It's a Dancer 1.3 bug - no-one's perfect!



Exercise 5:  Route Type 1 - parameterised base URL
==================================================

First, 

```
$ cp part1/ex2/step1.pl part1/ex5/step1.pl
```

then modify the ``` /hello ``` route handler to take another parameter. That is, instead of writing 

```
get '/hello' => sub {};
```

we write 

```
get '/hello/:adjective' => sub {};
```

Then within the associated subroutine, the variable
``` params->{adjective} ``` will be the string in the URL after 
``` /hello/ ```
 

Therefore, we can change 
```
  return "<h1>Turn it all around people!</h1>";
```

to 
```    
  return "<h1>Turn it all around ".params->{adjective}." people!</h1>";
```

Then navigate to the page: 
```  http://0.0.0.0:3000/hello/funny ```

or 
```  http://0.0.0.0:3000/hello/interesting ```

Implement this and see that it works.

<b>NOTES</b>:

* ``` params ``` is a method returning a hashref of all the parameters

* This technique is great for auto-generated URLs which might populate
a site-map for search engines to explore your website.


=====

We've just seen how we can use parameterised URLs for generating content,
but this is not the way to implement pages which take their parameters
from human input. You don't want the user to have to type their name into the
url!  It would be easier for them to type it into a field in a web page.
The two approaches for implementing this are the GET and POST type forms. 


&raquo; Exercise 6: Route Type 2 - GET query 
======================================

```
$ cp part1/ex4/step1.pl part1/ex6/step1.pl
```

* Remove all the route handlers except '/' which should now be

```
get '/' => sub {
    template 'hello-adj-index';
};
```

<b>NOTE</b> Don't remove the ```set``` s only remove the ```get``` s!!

* Create a new template ```views/hello-adj-index.tt``` containing

```
<h1>GET form for accessing the hello-adj get method</h1>
<form action="hello-adj" method="get">
  Adjective: <input type="text" name="adjective" /><br />
  <input type="submit" value="Submit" />
</form>
```


* In ``` part1/ex6/step1.pl ``` add a ``` /hello-adj ``` method

```
get '/hello-adj' => sub {
  my $params = params();
    return
  "<h1>Hello ".params->{adjective}." Things!</h1>"
};
```



Run it and see that if you visit the website at 

```
http://0.0.0.0:3000/
```

and enter a name like 'dynamic' and click submit, it will 
display the page 

```
http://0.0.0.0:3000/hello-adj?adjective=dynamic

```

and say 'Hello dynamic Things!'



Exercise 7: Route Type 3 - POST query 
=======================================

```
$ cp -r part1/ex6 part1/ex7
```

You've just done two experiments with dynamically generating content of the
web page based on information the user provided. In both cases, this
information wound up in the URL.

Putting the user's information into the url isn't the correct approach when the action changes the state of the server, or the information being passed in exceeds the limit on the url length (for a detailed explanation of why this is, see http://www.cs.tut.fi/~jkorpela/forms/methods.html http://blog.steveklabnik.com/2011/07/03/nobody-understands-rest-or-http.html) In this case we put the user's information in the header of the HTTP request, rather than the url.  This is called a POST request. 

With a POST we need to do two things. First of all, provide a POST
form in the template views/hello-adj-index.tt - after the get form.

```
<h1>POST form for accessing the hello-adj-post method</h1>
<form action="hello-adj" method="post">
  Adjective: <input type="text" name="adjective" /><br />
  <input type="submit" value="Submit" />
</form>
```

And then in the ``` part1/ex7/step1.pl ``` controller add the ``` hello-adj ``` POST method

```

post '/hello-adj' => sub {
  my $params = params();
    return
  "<h1>Hello ".params->{adjective}." Things!</h1>".
};

```

Run it and see that if you visit the website at  http://0.0.0.0:3000/ enter a name like 'dynamic' <i>in the post form</i> and click submit, it will  display the page 
http://0.0.0.0:3000/hello-adj
and say 'Hello dynamic Things!'


&raquo; Exercise 8: Dynamic Content + Template Toolkit
-------------------------------------------------------

Implement a new GET query so that if the user enters a comma-separated list of adjectives it prints out a line for each one.

```
$ cp -r part1/ex6 part1/ex8
```

* In ``` part1/ex8/step1.pl ```, update the ``` /hello-adj ``` route handler
filling in the ``` # TODO ``` section with code to generate an array reference

```
get '/hello_adj' => sub {
  my $params = params();
  ## TODO: Split the params->{adjectives} into a list of comma separated words
  ## and we pass a refence to this list into TT
  template 'hello-multiple-adj' => { adjective_list => \@adj_list };
};

```

* Now we must implement a new template view  and
this is where the Template Toolkit shows its power!  

Write this code in ``` views/hello-multiple-adj.tt ```

```
[% FOREACH adj in adjective_list %]
   <p>Hello [% adj %] thing!</p>
[% END %]
```


Check to see that it runs as expected.


Exercise 9: TT hashrefs and exploring parameters 
===============================================

In Exercise 8 we saw how to use the Template's ```FOREACH``` loop to show the
contents of an array where each element was a string.

In this example, we show the contents of a hashref.  This is a very
simple example but it illuminates how hashrefs are represented in TT.

```
$ cp -r part1/ex8 part1/ex9
$ rm part1/ex9/views/hello-multiple-adj.tt
```

Write a webpage http://0.0.0.0:3000/show-parameters 
which displays everything it receives as a parameter.

For example:

http://0.0.0.0:3000/show-parameters?x=1&y=2&z=t

would display


----

<b>Parameters</b>

<table>
<tr><td><b>Key</b></td><td><b>Value</b></td></tr>
<tr><td>x</td><td>1</td></tr>
<tr><td>y</td><td>2</td></tr>
<tr><td>z</td><td>t</td></tr>
</table>

----




* Write a route handler in ``` part1/ex9/step1.pl ``` 

```
get '/show-parameters' => sub {
  my $rh_params = params;
  template 'parameters' => { parameter_hashref =>  $rh_params };
};
```

* Change ``` views/hello-adj-index.tt ``` to 

```

<form action="show-parameters" method="get">
  First parameter: <input type="text" name="p1" /><br />
  Second parameter: <input type="text" name="p2" /><br />
  Third parameter: <input type="text" name="p3" /><br />
  <input type="submit" value="Submit" />
</form>

```

*  Write ``` parameters.tt ``` with a FOREACH loop which iterates over each key-value pair 
of the ``` parameter_hashref ``` variable



```

<h1>Parameters</h1>

<table>
<tr><td><b>Key</b></td><td><b>Value</b></td></tr>
[% FOREACH p IN parameter_hashref %]

---->INSERT YOUR CODE HERE

[% END %]

</table>

```


For help processing hashrefs in the template, read '<i>iterated values which are hash references</i>' in 

```
perldoc Template::Manual::Directives
```


Exercise 9': Wantarray problem
-------------------------------

<img src="https://github.com/andrewsolomon/YAPC2011DancingLesson/raw/master/slides/images/cybergedeon_warning_banana_skin.jpg" alt="Banana skin" width="200" />



```
$ cp part1/ex9/step1.pl part1/ex9/step2-back.pl
```
Change the ``` /show-parameters``` routehandler  from

```
get '/show-parameters' => sub {
  my $rh_params = params;
  template 'parameters' => { parameter_hashref =>  $rh_params };
};
```

to 

```
get '/show-parameters' => sub {
  template 'parameters' => { parameter_hashref =>  params };
};

```

and see what happens.

Called in this way 'params' returns a hash, rather than a hashref. To understand why is beyond the scope of this class, but
to find out more, read the Dancer::Request implementation of the ``` params ``` subroutine and read

```
$ perldoc -f wantarray
```


Exercise 10: Multi-value parameters
------------------------------------

As a modification of Exercise 8, provide the user with three fields of the same name, so that instead of typing a comma separated string like 'red,green,blue' they would put each in a different field.

```
$ cp -r part1/ex8 part1/ex10
```

* Change the input template ``views/hello-adj-index.tt`` giving it *three* identical input lines:

```
<input type="text" name="adjective" /><br />
<input type="text" name="adjective" /><br />
<input type="text" name="adjective" /><br />
```

* Change ``step1.pl`` so that it sends exactly the list returned by ``params->{adjective}`` to the template

```
template 'hello-multiple-adj' => { adjective_list =>  params->{adjective} };
```

What you'll have learnt from this is that multiple inputs of the same name are presented to the controller in an array ref of that name.
