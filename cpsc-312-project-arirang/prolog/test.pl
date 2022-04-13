% Make a group of tests with begin_tests/end_tests.
% Make a test with test/2.
% Run your tests with run_tests/0.

% After you load this file in swipl, run with: run_tests.
% On the command line:
% * Use `make test-repl` to enter a repl with this file loaded.
% * Use `make test` to run the unit tests.
% * At the project run, use `make prolog-eval` to run the unit tests.

% Knowledge Base
% course (CourseName, PreRequisites)
course(cpsc100,[[]]).
course(cpsc101,[[]]).
course(cpsc103,[[]]).
course(cpsc107,[[cpsc103]]).
course(cpsc110,[[]]).
course(cpsc121,[[]]).
course(cpsc203,[[cpsc103],[cpsc110]]).
course(cpsc210,[[cpsc107],[cpsc110]]).
course(cpsc213,[[cpsc121,cpsc210]]).
course(cpsc221,[[cpsc121,cpsc210]]).
course(cpsc298,[[]]).
course(cpsc299,[[cpsc298]]).
course(cpsc301,[[]]).
course(cpsc304,[[cpsc221]]).
course(cpsc310,[[cpsc213,cpsc221]]).
course(cpsc311,[[cpsc210]]).
course(cpsc312,[[cpsc210]]).
course(cpsc313,[[cpsc213,cpsc221]]).
course(cpsc317,[[cpsc213,cpsc221]]).
course(cpsc319,[[cpsc310]]).
course(cpsc320,[[cpsc221]]).
course(cpsc322,[[cpsc221]]).
course(cpsc330,[[cpsc203],[cpsc210]]).
course(cpsc340,[[cpsc221]]).
course(cpsc344,[[cpsc210]]).
course(cpsc349,[[]]).
course(cpsc368,[[cpsc203],[cpsc210]]).
course(cpsc398,[[]]).
course(cpsc399,[[]]).
course(cpsc410,[[cpsc310]]).
course(cpsc411,[[cpsc213,cpsc221,cpsc311]]).
course(cpsc415,[[cpsc313]]).
course(cpsc416,[[cpsc313,cpsc317]]).
course(cpsc418,[[cpsc261,cpsc320]]).
course(cpsc420,[[cpsc320]]).
course(cpsc421,[[cpsc221]]).
course(cpsc422,[[cpsc322]]).
course(cpsc426,[[cpsc314]]).
course(cpsc430,[[]]).
course(cpsc436,[[]]).
course(cpsc440,[[cpsc320,cpsc340]]).
course(cpsc448,[[]]).
course(cpsc449,[[cpsc349]]).
course(cpsc455,[[cpsc310]]).
course(cpsc490,[[]]).
course(cpsc491,[[cpsc221,cpsc310,cpsc344]]).
course(cpsc499,[[]]).


% Helper that matches course name in string to course term

checkStringCourse("cpsc100", cpsc100).
checkStringCourse("cpsc101", cpsc101).
checkStringCourse("cpsc103", cpsc103).
checkStringCourse("cpsc107", cpsc107).
checkStringCourse("cpsc110", cpsc110).
checkStringCourse("cpsc121", cpsc121).
checkStringCourse("cpsc203", cpsc203).
checkStringCourse("cpsc210", cpsc210).
checkStringCourse("cpsc213", cpsc213).
checkStringCourse("cpsc221", cpsc221).
checkStringCourse("cpsc298", cpsc298).
checkStringCourse("cpsc299", cpsc299).
checkStringCourse("cpsc301", cpsc301).
checkStringCourse("cpsc304", cpsc304).
checkStringCourse("cpsc310", cpsc310).
checkStringCourse("cpsc311", cpsc311).
checkStringCourse("cpsc312", cpsc312).
checkStringCourse("cpsc313", cpsc313).
checkStringCourse("cpsc317", cpsc317).
checkStringCourse("cpsc319", cpsc319).
checkStringCourse("cpsc320", cpsc320).
checkStringCourse("cpsc322", cpsc322).
checkStringCourse("cpsc330", cpsc330).
checkStringCourse("cpsc340", cpsc340).
checkStringCourse("cpsc344", cpsc344).
checkStringCourse("cpsc349", cpsc349).
checkStringCourse("cpsc368", cpsc368).
checkStringCourse("cpsc398", cpsc398).
checkStringCourse("cpsc399", cpsc399).
checkStringCourse("cpsc410", cpsc410).
checkStringCourse("cpsc411", cpsc411).
checkStringCourse("cpsc415", cpsc415).
checkStringCourse("cpsc416", cpsc416).
checkStringCourse("cpsc418", cpsc418).
checkStringCourse("cpsc420", cpsc420).
checkStringCourse("cpsc421", cpsc421).
checkStringCourse("cpsc422", cpsc422).
checkStringCourse("cpsc426", cpsc426).
checkStringCourse("cpsc430", cpsc430).
checkStringCourse("cpsc436", cpsc436).
checkStringCourse("cpsc440", cpsc440).
checkStringCourse("cpsc448", cpsc448).
checkStringCourse("cpsc449", cpsc449).
checkStringCourse("cpsc455", cpsc455).
checkStringCourse("cpsc490", cpsc490).
checkStringCourse("cpsc491", cpsc491).
checkStringCourse("cpsc499", cpsc499).


% Pre requisite Printer
% When user types "askList" in the swipl prompt,
% the code will start
% This code asks user to enter course name, which they want to know prerequisite of.

askList :- writeln('What course do you want to know the list of pre-requisites for?')
    , read_line_to_string(current_input, Line)
    , (
      	checkStringCourse(Line, CourseName) ->
      		write('Pre-requistes:'), nl, bringPreRequisite(CourseName)
      ;
      	write("You entered an invalid CPSC course. Please try again.")
      ).

% list all the pre-requisite of the course
bringPreRequisite(CourseName) :- course(CourseName,ListPre), writeAllInList(ListPre).

% list all the pre-requisite of the course
bringPreRequisiteInside(CourseName) :- course(CourseName,ListPre), writeAllInListInside(ListPre).

% Helper for bringPreRequisite
writeInList([]).
writeInList([Y|Ys]) :-
  write(Y), write(', '), bringPreRequisiteInside(Y), writeInList(Ys).

writeAllInList([]) :- write('no other case').
writeAllInList([X|Xs]) :- writeInList(X), write('OR\n'), writeAllInList(Xs).

writeAllInListInside([]) :- write('').
writeAllInListInside([X|Xs]) :- writeInList(X), write(''), writeAllInListInside(Xs).

% check(TakenCourseList, PreRequisiteList)
% Check if the taken courses includes prerequisite.
check(TakenCourseList, [Selected|Rest]) :- (
    checkForOneSet(TakenCourseList, Selected) ->
    % If checkForOneSet is true,
        true
    ; %If checkForOneSet is false, pass Selected and go to next one
    check(TakenCourseList,Rest)
).

% Compare pre-requisite list to taken course list
checkForOneSet(_, []).
checkForOneSet(TakenCourseList, [X|Xs]) :- member(X, TakenCourseList), checkForOneSet(TakenCourseList, Xs).

% Ask question what they want to take and check whether or not they can take the course
askCheck :- writeln('What courses have you taken so far? (Enter "stop" when you are done.)')
    , get_Courses([], TakenCourseList)
    , write("What course do you want to take?")
    , nl
    , read_line_to_string(current_input, Line)
    % match the courses in string, which user typed into term
    , checkStringCourse(Line, CourseName)
    , course(CourseName,PreRequisitesList)
    , (
      % if course has already been taken
      member(CourseName,TakenCourseList) ->
      	write("You have already taken the course."),nl
      ;
      (
      	check(TakenCourseList, PreRequisitesList) ->
            % If check is true, print the following
      		write("You can take the course. You meet the requirement."),nl
      ;
       % pre-requsite requirement has not satisfied
       write("You cannot take the course. You do not meet the requirement."),nl
      )
     ).
% Stop asking for taken course, when user type "stop"
response("stop").

% check if the input course is valid
% if the course is valid, add to the list
get_Courses(Taken, Courses) :-
    write("Enter Course: "),
    read_line_to_string(current_input, Line),
    (
       	response(Line) -> append([], Taken, Courses);
    	(
            	checkStringCourse(Line, C) ->
                    % If the course actually exists,
        			append([C], Taken, NewCourses),
    				get_Courses(NewCourses, Courses)
        		;
                    % If the course does not exist, print the following
        		write("This course does not exist! Start over! "),
                % Program closes when the course does not exist
                % User needs to start again
                fail
        )
    ).
