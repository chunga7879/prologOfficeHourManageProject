# UBC CPSC Course Pre-requisite Finder

This app allows students to easily look up the list of courses that need to be completed in order to take the CPSC course they are willing to take.

Students can also enter the list of the courses they have taken along with the course number (eg. CPSC 312) they are planning to take in order to find out whether their lists suffice the prerequisites of the course they’re looking up.

## Team Members of Arirang
+ Chunga Lee (18848614)
+ Yeongu Choe (77672566)
+ Ji Young Kim (17668112)

-------------------------------------------------

## Link to the video
[YouTube](https://youtu.be/IIGH89pZXMY)

-------------------------------------------------
## Link to the proposal
[Link](https://github.students.cs.ubc.ca/xhehf77/312-project2-arirang/blob/c637bc98f26291e7c40bad861cd64a30b59ff827/cpsc-312-project-arirang/README.md)

-------------------------------------------------
## How the MVP fulfills the proposal

### Print all the sets of required courses
The first goal of our MVP is to print out all the pre-requisites for the CPSC course of the user's choice.
Our askList function allows this. If the user prompts askList,
it first asks "What course do you want to know the list of pre-requisites for?" with input line.
If the user enters any CPSC course which is valid, then it prints out all pre-requisites by checking it recursively.
("recursive" here means that it prints out the pre-requisites of the pre-requisite course(s), and so on.)

#### Simple example
1) No pre-requisite \
When : course(cpsc103,[[]]).
```
?- askList.
What Course Do You Want To Know The List Of Pre-requisite?
|: cpsc103
Pre-requistes:
OR no other case
```
As there is no pre-requisite, it just prints "no other case".

2) Pre-requisite with pre-requisite courses that do not have pre-requisite courses. \
   When : \
course(cpsc103,[[]]). \
course(cpsc107,[[cpsc103]]).

```
?- askList.
What Course Do You Want To Know The List Of Pre-requisite?
|: cpsc107
Pre-requistes:
cpsc103, OR no other case
```
As CPSC 103 is the only pre-requisite for CPSC 107, and there is no other option, \
it prints out "cpsc103, OR no other case".

3) Type invalid CPSC course
If user enters an invalid CPSC course, it prints out "You entered an invalid CPSC course. Please try again."
```
   ?- askList.
   What Course Do You Want To Know The List Of Pre-requisite?
   |: cpsc111
   You write wrong cpsc course, Try again
```

#### Complex example with recursive case
1) Example 1
   When : \
   course(cpsc210,[[cpsc107],[cpsc110]]). \
   course(cpsc107,[[cpsc103]]). \
   course(cpsc103,[[]]). \
   course(cpsc110,[[]]).
```
?- askList.
What Course Do You Want To Know The List Of Pre-requisite?
|: cpsc210
Pre-requistes:
cpsc107, cpsc103, OR cpsc110, OR no other case
```
As there are two options for the list of the pre-requisites for CPSC 210, which is taking either CPSC 107 or CPSC 110.
As CPSC 107 requires CPSC 103, it print out both cpsc107, cpsc 103 for an option by checking it (i.e. prerequisite of CPSC 107) recursively, followed by the other option (i.e. cpsc110).

3) Example 2
   When : \
   course(cpsc313,[[cpsc213,cpsc221]]). \
   course(cpsc213,[[cpsc121,cpsc210]]). \
   course(cpsc121,[[]]). \
   course(cpsc210,[[cpsc107],[cpsc110]]).
   course(cpsc107,[[cpsc103]]).
   course(cpsc110,[[]]).
   course(cpsc103,[[]]).
   course(cpsc221,[[cpsc121,cpsc210]]).

```
?- askList.
What Course Do You Want To Know The List Of Pre-requisite?
|: cpsc313
Pre-requistes:
cpsc213, cpsc121, cpsc210, cpsc107, cpsc103, cpsc110, cpsc221, cpsc121, cpsc210, cpsc107, cpsc103, cpsc110, OR
no other case
```

### Check either taking the courses
The second goal of our MVP is to check whether the user can take the course of their interest
by comparing the courses they have taken so far and pre-requisites of the course they want to take.
"askCheck" is the function responsible for this. If the user prompts askCheck,
it asks "What courses have you taken so far? (Enter "stop" when you are done.)"
with an input line (Enter Course: ).
If the user enters CPSC courses they have taken before and stop when done entering,
then it asks what course the user wants to take.
By checking the pre-requisites of the course and comparing the pre-requisites with the courses the user has taken,
it prints out
1) "You can take the course. You meet the requirement." if user can take the course. \
   When : \
   course(cpsc103,[[]]). \
   course(cpsc203,[[cpsc103],[cpsc110]]). \
As the user has taken cpsc103, which is one of the options for the pre-requisite, the user fulfills the pre-requisite to take cpsc203.
```
   ?- askCheck.
   What Courses Have You Taken So Far? (Enter "stop" when you are done.)
   Enter Course: cpsc103
   Enter Course: stop
   What course do you want to take?
   cpsc203
   You can take the course. You meet the requirement.
   true.
```


2) "You have already taken the course." if the user has already taken the course they are interested in.
The course the user enters as the one they want to take is the course which s/he has already taken before. We implemented it by using "member" function.
```
   ?- askCheck.
   What Courses Have You Taken So Far? (Enter "stop" when you are done.)
   Enter Course: cpsc103
   Enter Course: stop
   What course do you want to take?
   cpsc103
   You have already taken the course.
   true.
```
3) "You cannot take the course. You did not finish the requirement," if the user cannot take the course because
s/he does not meet at least one of the options for the pre-requisites. We did it by comparing the pre-requisite courses with the courses s/he entered as they took before.
```
   ?- askCheck.
   What Courses Have You Taken So Far? (Enter "stop" when you are done.)
   Enter Course: cpsc100
   Enter Course: stop
   What course do you want to take?
   cpsc203
   You cannot take the course. You did not finish the requirement.
   true.
```

-------------------------------------------------
## New learning
1) [If-Else Statement](https://github.students.cs.ubc.ca/xhehf77/312-project2-arirang/blob/d0f5833d2821548a00ce4d3b2c81e3c9f255eec1/cpsc-312-project-arirang/prolog/test.pl#L169): We used the prolog version of the if-else statement here. With this, we could branch out the flow of the program. By using the nested conditional statement, we could deal with all the cases that we had to implement in the code. 

   Application on our project
   
   If the user enters an course that is already included in the TakenCourseList, \
   &nbsp;&nbsp;&nbsp;&nbsp;then -> It prints: "You have already taken the course." \
   &nbsp;&nbsp;&nbsp;&nbsp;else next condition: If the course set meets pre-requisite, \
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;then-> It prints: "You can take the course. You meet the requirement." \
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;else-> It prints: "You cannot take the course. You do not meet the requirement."\

2) [Recursion](https://github.students.cs.ubc.ca/xhehf77/312-project2-arirang/blob/d0f5833d2821548a00ce4d3b2c81e3c9f255eec1/cpsc-312-project-arirang/prolog/test.pl#L151): We used recursion combined with if-else statement. We put base case in the then statement and recursive case in the else statement.
   ```
   check(TakenCourseList, [Selected|Rest]) :- (
    checkForOneSet(TakenCourseList, Selected) ->
        true % base case
    ; 
    check(TakenCourseList,Rest) %   recursive case
   ).
   ```

3) [Append Function](https://github.students.cs.ubc.ca/xhehf77/312-project2-arirang/blob/d0f5833d2821548a00ce4d3b2c81e3c9f255eec1/cpsc-312-project-arirang/prolog/test.pl#L194): We used built in append function to build lists.
   ```
   (
       	response(Line) -> append([], Taken, Courses);
    	(
            	checkStringCourse(Line, C) ->
                    % If the course actually exists,
        			append([C], Taken, NewCourses),
    				get_Courses(NewCourses, Courses)
      ...
   ```

4) [Pattern Matching](https://github.students.cs.ubc.ca/xhehf77/312-project2-arirang/blob/d0f5833d2821548a00ce4d3b2c81e3c9f255eec1/cpsc-312-project-arirang/prolog/test.pl#L64): We made terms that bind course name in string to course name in prolog term. Then we used these terms to check if the course actually exists.
   ```
   checkStringCourse("cpsc100", cpsc100).
   checkStringCourse("cpsc101", cpsc101).
   checkStringCourse("cpsc103", cpsc103).
   ...
   , checkStringCourse(Line, CourseName)
   ...
   ```