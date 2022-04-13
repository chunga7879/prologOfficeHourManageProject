import Lib
import Test.Tasty
import Test.Tasty.HUnit

main :: IO ()
main = defaultMain $ testGroup "Tests" $
  [ testCase "successful chooseBookingDate" $ do
    (chooseBookingDate "2021-10-27") >>= (\b -> b @?= True),
    testCase "unsuccessful chooseBookingDate with quit" $ do
    (chooseBookingDate "quit") >>= (\b -> b @?= False)
    , testCase "successful successful" $ do
    (chooseBookingDate "2021-00-27") >>= (\b -> b @?= False)
    , testCase "successful initialization" $ do
      (initialOfficeHour (2021, 10, 22, 10, 00) "Steve") @?= [Simple ((2021,10,22,10,00), "Steve")
                    , Simple ((2021,10,22,10,10),"Steve")
                    , Simple ((2021,10,22,10,20),"Steve")
                    , Simple ((2021,10,22,10,30),"Steve")
                    , Simple ((2021,10,22,10,40),"Steve")
                    , Simple ((2021,10,22,10,50),"Steve")]
    , testCase "unsuccessful initialization: incorrect format passed in" $ do
      (initialOfficeHour (2010, 10, 27, 13, 00) "Steve") @?= []
    , testCase "successful addSchedule" $ do
      (addSchedule (2021, 10, 22, 09, 00) "chunga" [Simple ((2021,10,22,10,00), "Yeongu"), Simple ((2021,10,22,10,10),"Jiyoung")])
      @?= [Simple ((2021, 10, 22, 09, 00), "chunga"), Simple ((2021,10,22,10,00), "Yeongu"), Simple ((2021,10,22,10,10),"Jiyoung")]
    , testCase "successful deleteSchedule" $ do 
      (deleteSchedule (Simple ((2021, 10, 22, 09, 00), "chunga")) 
        [Simple ((2021, 10, 22, 09, 00), "chunga"), Simple ((2021,10,22,10,00), "Yeongu"), Simple ((2021,10,22,10,10),"Jiyoung")]
        @?= [Simple ((2021,10,22,10,00), "Yeongu"), Simple ((2021,10,22,10,10),"Jiyoung")]
       )
  ]


