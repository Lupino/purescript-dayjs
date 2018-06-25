module Test.Main where

import Data.Dayjs

import Prelude (Unit, discard, ($), (<), (==), (>))
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

      equal 2019 $ year $ add 1 unitY t
      equal 6 $ month $ add 1 unitM t
      equal 26 $ date $ add 1 unitD t
      equal 2 $ day $ add 1 unitD t
      equal 23 $ hour $ add 1 unitH t
      equal 1 $ millisecond $ add 1 unitMS t
      equal 9 $ minute $ add 1 unitMIN t
      equal 21 $ second $ add 1 unitS t

      equal 2017 $ year $ subtract 1 unitY t
      equal 4 $ month $ subtract 1 unitM t
      equal 24 $ date $ subtract 1 unitD t
      equal 0 $ day $ subtract 1 unitD t
      equal 21 $ hour $ subtract 1 unitH t
      equal 999 $ millisecond $ subtract 1 unitMS t
      equal 7 $ minute $ subtract 1 unitMIN t
      equal 19 $ second $ subtract 1 unitS t

      equal 1 $ year $ set unitY 1 t
      equal 1 $ month $ set unitM 1 t
      equal 1 $ date $ set unitDATE 1 t
      -- equal 1 $ day $ set unitD 12 t
      equal 1 $ hour $ set unitH 1 t
      equal 1 $ millisecond $ set unitMS 1 t
      equal 1 $ minute $ set unitMIN 1 t
      equal 1 $ second $ set unitS 1 t
