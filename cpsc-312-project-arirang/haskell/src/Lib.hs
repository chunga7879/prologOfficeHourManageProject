module Lib where

someFunc :: IO ()
someFunc = askDate >>= chooseBookingDate >>= finishLine 
        where finishLine bool = if (bool) then putStrLn("booked") else putStrLn("not booked")

-- choose the date for new booking (if put some quits, it will finish the function) 
chooseBookingDate :: String -> IO Bool
chooseBookingDate preferredDateStr = do
    -- in real implementation isValidDateForm can be true or false
    if (elem preferredDateStr ["quit", "Quit", "q", "Q"])
      then do
        -- putStrLn("If you want to finish the process, put Q")
        -- finish <- getLine 
        -- if (finish == "Q") 
        --   then do
        --   putStrLn("It quits the process")
          return(False)
        -- else do
        --   askDate >>= chooseBookingDate
    else if (isValidDateForm preferredDateStr) 
      then do
        -- in real implementataion: it will deal with some exception cases
        -- currentTime <- getCurrentTime
        -- let (ty,tm,td) = toGregoiarn $ utctDay currentTime
        -- let currentDay = (fromGregorian ty tm td)
        -- let preferredDate = convertToDate preferredDateStr
        -- let preferredDay = dayOfWeek preferredDate

        -- if (currentDay > preferredDay) 
        --   then do
        --     putStrLn("You can only choose date on a today or after today, please try again")
        --     askDate >>= chooseBookingDate
        -- else if (preferredDay == Tuesday || preferredDay == Saturday || preferredDay == Sunday)
        --   then do
        --     putStrLn("No office hour on Tuesday Saturday Sunday, please try again")
        --     askDate >>= chooseBookingDate
        -- else 
        --   then do
            printSchedule preferredDateStr
            return(True)
    else 
       do
        putStrLn("The date form is invalid") 
        return(False)

-- it is to ask what date is good for it
askDate:: IO String
askDate =  putStrLn("What date do you want to book for office hour? (YYYY-MM-DD)") >>
    putStrLn("NOTE: We have office hour every MONDAY, WEDNESDAY, THURSDAY, FRIDAY") >> getLine

-- isValidDateForm: it is to check the string have format of YYYY-MM-DD with appropriate number!
-- this code(isValidDateForm, splitSep) reference from : https://github.com/ezzllyzz/barbershopscheduler/blob/main/main.hs
isValidDateForm :: String -> Bool
isValidDateForm [] = False 
isValidDateForm str 
    | length lst == 3 = validComb year month date 
    | otherwise = False 
    where 
        lst = splitSep (== '-') str
        year = read (lst!!0) :: Integer 
        month = read (lst!!1) :: Int
        date = read (lst!!2) :: Int
        validComb y m d 
            | (elem m [1, 3, 5, 7, 8, 10, 12]) = d >= 1 && d <= 31
            | (elem m [4, 6, 9, 11]) = d >= 1 && d <= 30
            | m == 2 = d >= 1 && d <= 29
            | otherwise = False 
splitSep :: (a -> Bool) -> [a] -> [[a]]
splitSep f [] = [[]]
splitSep f (h:t)
    | f h = [] : splitSep f t
    | otherwise = ((h:t1):t2) where t1:t2 = splitSep f t

-- USE getCurrentTime from Data.Time
-- convertToDate: It is to convert from date in string format to date in Day format 
-- printSchedule: Helper function which It will print timeslots.
printSchedule :: String -> IO()
printSchedule _ = putStrLn("TIME SLOTS")

-- year, month, day, hour, minute
type DateTime = (Int, Int, Int, Int, Int)

data TimeSlot = Simple (DateTime, String)
  deriving (Show, Eq)
 
--Initialize an office hour by creating 6 * 10-min time slots, starting at the given time with givin instructor name
--the current version just shows the idea of creating 6 slots, each of which is 10 min apart from the previous/next slots
--the final version will check the correct format of time (eg. 00 comes after 59, not 60), etc.
initialOfficeHour :: DateTime -> String -> [TimeSlot]
initialOfficeHour (year, month, day, hr, min) s
    | isValid((year, month, day, hr, min)) = [Simple ((year, month, day, hr, min), s)
                                                  , Simple ((year, month, day, hr, min + 10), s)
                                                  , Simple ((year, month, day, hr, min + 20), s)
                                                  , Simple ((year, month, day, hr, min + 30), s)
                                                  , Simple ((year, month, day, hr, min + 40), s)
                                                  , Simple ((year, month, day, hr, min + 50), s)]
    | otherwise = []

--This method adds time slot with student name and booking time to the list of existing timeslot lists
addSchedule :: DateTime -> String -> [TimeSlot] -> [TimeSlot]
addSchedule dt s ts = newSlot:ts
        where newSlot = Simple (dt, s)
 
--Removes one student booking from the existing bookings
deleteSchedule :: TimeSlot -> [TimeSlot] -> [TimeSlot]
deleteSchedule _ [] = []
deleteSchedule selected (w:ws) = if (selected == w) then ws else w: (deleteSchedule selected ws)

-- check date time valid form (helper function)
isValid:: DateTime -> Bool
isValid (year, month, day, hr, min) = (year == 2021) && ( month >= 10 ) && ( 0 < day && day <= 31) && ( 0 < hr && hr <= 24) && (0 <= min && min <= 59)

