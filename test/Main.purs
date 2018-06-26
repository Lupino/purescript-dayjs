module Test.Main where

import Data.Dayjs

import Prelude (Unit, discard, ($), (<), (==), (>), show)
import Test.Unit (suite, test)
import Test.Unit.Assert (assert, assertFalse, equal)
import Test.Unit.Main (runTest)
import Effect (Effect)


main :: Effect Unit
main = runTest do
  suite "test dayjs" do
    test "test unix time" do
      equal 1529929022 $ toUnixTime $ fromUnixTime 1529929022

    test "test parse invalid time string" do
      assertFalse "parse time failed" $ isValid $ dayjs "ssss"

    test "test parse valid time string" do
      assert "parse time failed" $ isValid $ dayjs "2018-06-25 22:08:20"

    test "test read dayjs attribute" do
      let t = dayjs "2018-06-25 22:08:20"

      equal 2018 $ year t
      equal 5 $ month t
      equal 25 $ date t
      equal 1 $ day t
      equal 22 $ hour t
      equal 0 $ millisecond t
      equal 8 $ minute t
      equal 20 $ second t

    test "test dayjs Eq" do
      let t = dayjs "2018-06-25 22:08:20"
          t1 = dayjs "2018-06-25 22:15:23"

      assertFalse "dayjs is not the same" $ isSame t t1
      assert "dayjs is the same" $ isSame t t

      assertFalse "dayjs is not the same" $ t == t1
      assert "dayjs is the same" $ t == t

    test "test dayjs Ord" do
      let t = dayjs "2018-06-25 22:08:20"
          t1 = dayjs "2018-06-25 22:15:23"

      assert "t is before t1" $ isBefore t1 t
      assert "t1 is after t" $ isAfter t t1

      assert "t is before t1" $ t < t1
      assert "t1 is after t" $ t1 > t

    test "test dayjs format" do
      equal "2018-06-25 22:08:20"
        $ format "YYYY-MM-DD HH:mm:ss"
        $ dayjs "2018-06-25 22:08:20"

    test "test dayjs operation" do
      let t = dayjs "2018-06-25 22:08:20"

      equal "2019-06-25 22:08:20" $ show $ add 1 unitY t
      equal "2017-06-25 22:08:20" $ show $ subtract 1 unitY t
      equal "2016-06-25 22:08:20" $ show $ set unitY 2016 t


      equal "2018-07-25 22:08:20" $ show $ add 1 unitM t
      equal "2018-05-25 22:08:20" $ show $ subtract 1 unitM t
      equal "2018-11-25 22:08:20" $ show $ set unitM 10 t

      -- equal "2018-06-25 22:08:20" $ show $ add 2 unitDATE t
      -- equal "2018-06-25 22:08:19" $ show $ subtract 2 unitDATE t
      equal "2018-06-10 22:08:20" $ show $ set unitDATE 10 t

      equal "2018-06-26 22:08:20" $ show $ add 1 unitD t
      equal "2018-06-24 22:08:20" $ show $ subtract 1 unitD t
      -- equal "2018-06-25 22:08:20" $ show $ set unitD 15 t

      equal "2018-06-25 23:08:20" $ show $ add 1 unitH t
      equal "2018-06-25 21:08:20" $ show $ subtract 1 unitH t
      equal "2018-06-25 10:08:20" $ show $ set unitH 10 t

      equal "2018-06-25 22:08:21" $ show $ add 1000 unitMS t
      equal "2018-06-25 22:08:19" $ show $ subtract 1 unitMS t
      equal "2018-06-25 22:08:30" $ show $ set unitMS 10000 t

      equal "2018-06-25 22:09:20" $ show $ add 1 unitMIN t
      equal "2018-06-25 22:07:20" $ show $ subtract 1 unitMIN t
      equal "2018-06-25 22:10:20" $ show $ set unitMIN 10 t

      equal "2018-06-25 22:08:21" $ show $ add 1 unitS t
      equal "2018-06-25 22:08:19" $ show $ subtract 1 unitS t
      equal "2018-06-25 22:08:10" $ show $ set unitS 10 t
