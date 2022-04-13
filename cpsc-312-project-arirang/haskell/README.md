
# UBC CPSC 312 OFFICE HOUR SCHEDULER

With this app, instructors can create time slots (date and time) for CPSC 312 office hours, and students can book preferred time slots by looking at the available slots.

## Team Members

Our team is:

+ Chunga Lee (18848614)
+ Yeongu Choe (77672566)
+ Ji Young Kim (17668112)

We call ourselves: Arirang

## Product Pitch

This project allows the instructor to schedule office hours (date and time) for CPSC 312, for which each student can book or cancel a time slot. One office hour session will be divided into some time slots for 10 minutes, and each student can book a one-time slot at most per day. It can help instructors to manage office hours and know which student is assigned to the time slots. It further prevents a small number of students from dominating office hours. From the students’ perspective, it makes students easily check what time slots are available. For example, the instructor schedules an office hour for October 14 for 10am. It is divided into some time slots with 10 minutes each, making 6 available slots. Also, students can pick a 10-min time slot to book/cancel (one slot per day at max).

## Minimal Viable Project

The app will use the IO system to print some questions(eg. “which time do you want to book?”) and to get answers with some built-in functions (i.e. putStrLn, getLine) by focusing on the relationship between users and terminal instead of using user interface.
It will build on the strength and power of the language. As variables in Haskell are immutable, we can set a time slot as a variable once and make it unable to change the time slots once created, even if a student books/cancels that time slot. By making the data type to represent the time slots, we can limit the format of the time slots (by making time slots using that data type). It leads naturally to learning and applying some new element of the language (including what that element is!) We may need to learn imperative programming using Haskell. In lectures, we only learned about making functions and connecting them to make one big functionality. Therefore, we may need to learn how to store data for the booking time. When we make variables containing the office hour information, garbage collection will automatically collect unused variables that don’t have references.
In our codes for this proposal, we demonstrated how booking and cancelling a time slot can work by passing in the time slot as an argument. For the final project, we are hoping to implement storing and reading of data by accessing csv files.


## Proof of Concept

The key element of our project the proof-of-concept focuses on are (1) to initialize office hours and (2) to choose date and time to make a booking as the purpose of our project is to allow the students to book an office hour on their preferred date and time.
This gives us confidence that, with sufficient work, we could complete the full (minimal viable) project. By making other helper functions and functions(initialize office hours) that make time slots and date, with key elements (chooseBookingDate ), it lets students to successfully choose their preferred booking date and time. By making the function which confirms the booking(addSchedule), it finally allows students to book a time slot for an office hour. It will use the data type, “TimeSlot”, which helps manage time slots. The “deleteSchedule” function enables the student to cancel his/her booking.

The code contained in the main.hs in haskell/app in this github
link: cpsc-312-project-template/haskell/app/Main.hs


### How to test and run the code: Haskell

In this proposal, we are testing whether the “chooseBookingDate” function with a correctly-formatted argument passed will work properly, which means, invalid format should not pass the tests. Spec.hs also tests 3 more functions that we implemented in Lib.hs: initialOfficeHour, addSchedule, and deleteSchedule. Again, invalid formats will not pass, and we successfully added/deleted schedules (i.e. a student booking/cancelling a time slot). These tests can be run by entering “make” in the project directory in the terminal.

The code contained in the Spec.hs in haskell/app in this github
link: cpsc-312-arirang/haskell/test/Spec.hs

### How to test and run the code: Prolog

This section will be included in the next proposal.

