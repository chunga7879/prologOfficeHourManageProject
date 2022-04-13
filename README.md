# UBC CPSC Course Prerequisite Finder

This app allows students to easily look up the list of courses that need to be completed in order to take the CPSC course they are willing to take. 

Students can also enter the list of the courses they have taken along with the course number (eg. CPSC 312) they are planning to take in order to find out whether their lists suffice the prerequisites of the course they’re looking up.


## Team Members

Our team is:

+ Chunga Lee 
+ Yeongu Choe 
+ Ji Young Kim 

We call ourselves: Arirang.


## Product Pitch

Looking up the prerequisites of courses can sometimes take a long time, especially for new/transfer students who are not so familiar with UBC’s system in general. Also, you are not done just by opening the course page on UBC’s course schedule and then checking “Pre-reqs” under the course description. If you are missing one, some, or all of the listed courses, you need to click on each of the course(s) you are missing, and do the same thing over and over again until you reach the courses that have nothing listed for prerequisites! (It is quite analogous to reaching the base case on recursive calls!) And you have to write down all the courses each time you click on a link.

We thought an app, with which users can easily look up the prerequisites, will save their time. This app won’t be appreciated just for the sake of quickness but also for the accuracy it brings! -- because sometimes, we miss small details when we have to open up so many tabs/windows. For example, lots of students get CPEN 221 mixed with CPSC 221 because they don’t pay attention!. They can also use this app as a personal (course) planner, with which they can find out whether the courses they have taken so far are sufficient for taking the course they want/need. Among all the courses offered by UBC, we will mainly focus on computer science courses listed on the [UBC calendar](http://www.calendar.ubc.ca/vancouver/courses.cfm?page=name&code=CPSC).


## Minimal Viable Project

#### Ultimate goal:

If the user types the course name, then the program will print all the courses needed to be taken before the input course, layer by layer. Users can type “;”, to go to the lower layer which is pre-requisites of pre-requisites.
If the user types some taken courses, the program will print out all the courses that meet the prerequisite.


#### Implementation:

Since satisfying a course’s prerequisites implies that the course’s prerequisite courses’ prerequisites have been fulfilled (and their prerequisites…), recursion is one of the core concepts that will be used for the implementation of this app.
The app will use a top-down approach to both of the product ideas listed in the “product pitch” -- (1) for returning the list of courses required to be taken for the course the user is interested in taking, and (2) for letting the user know whether his/her list (of courses taken so far) is sufficient to take the course s/he is interested in. The idea is as follows: The user enters the course s/he is willing/planning to take. In Prolog, the answer clause will be formatted as, for instance, “yes <- CPSC312.” The search will keep going down until it reaches “yes <- .”
Prolog is very suitable for carrying out such performances because this logical programming language is capable of returning the correct answer (i.e. true or false), as long as it is provided with the correct logic (eg. rules and relations) and KB. We will need to be able to print the list of the courses by appending the values of the child nodes of a node with the value of the course the user is looking up, in a tree.


## Proof of Concept

In our sample code, we have implemented a function that can check if the list of the courses the user is passing in is included in the prerequisites of the other argument (i.e. the course the user is willing/planning to take). If it is, the function will return True, and False otherwise. This can be implemented in a way more user-friendly by using pattern matching, after which users can simply enter the course code and number.


### How to test and run the code: Prolog

In this proposal, we are testing for check and checkForOneSet which is the helper function of check. In checkForOneSet, it checks whether all elements of one list in the list of prerequisites are contained in the list of the course the user took before(given by argument). It passes if all elements of the list of right side are contained in the list of the left side(Courses), and it fails if not. 
So, by using checkForOneSet, check tests whether at least one of the lists in the list of prerequisites, all elements are contained in the courses that user previously took. So, the test passes if there are cases in which all elements of one list in prerequisites of course contain the left side list (Courses), and it fails if there is no case satisfied. 
