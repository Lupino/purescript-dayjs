module Data.Dayjs
  ( Dayjs
  , fromUnixTime
  , toUnixTime
  , set
  , add
  , subtract
  , format
  , getDayjs
  , dayjs
  , extend

  , isValid
  , isLeapYear
  , isSame
  , isBefore
  , isAfter

  , date
  , day
  , hour
  , millisecond
  , minute
  , month
  , second
  , year

  , unitMS
  , unitS
  , unitMIN
  , unitH
  , unitD
  , unitW
  , unitM
  , unitQ
  , unitY
  , unitDATE
  ) where

import Prelude (class Show, class Ord, class Eq, Unit, otherwise, Ordering (..))
import Effect (Effect)

foreign import data Dayjs :: Type

instance showDayjs :: Show Dayjs where
  show = format "YYYY-MM-DD HH:mm:ss"

instance eqDayjs :: Eq Dayjs where
  eq = isSame

instance ordDayjs :: Ord Dayjs where
  compare a b | isSame b a = EQ
              | isBefore b a = LT
              | otherwise = GT

foreign import fromUnixTime :: Int -> Dayjs

foreign import toUnixTime :: Dayjs -> Int

foreign import set :: String -> Int -> Dayjs -> Dayjs

foreign import add :: forall a. a -> String -> Dayjs -> Dayjs

foreign import subtract :: forall a. a -> String -> Dayjs -> Dayjs

foreign import format :: String -> Dayjs -> String

foreign import getDayjs :: Effect Dayjs

foreign import dayjs :: String -> Dayjs

foreign import extend :: forall a b c opts. (a -> b -> c -> Effect Unit) -> opts -> Effect Unit

foreign import isValid :: Dayjs -> Boolean

foreign import isLeapYear :: Dayjs -> Boolean

foreign import isSame :: Dayjs -> Dayjs -> Boolean

foreign import isBefore :: Dayjs -> Dayjs -> Boolean

foreign import isAfter :: Dayjs -> Dayjs -> Boolean

foreign import date :: Dayjs -> Int

foreign import day :: Dayjs -> Int

foreign import hour :: Dayjs -> Int

foreign import millisecond :: Dayjs -> Int

foreign import minute :: Dayjs -> Int

foreign import month :: Dayjs -> Int

foreign import second :: Dayjs -> Int

foreign import year :: Dayjs -> Int

unitMS   :: String
unitMS   = "millisecond"

unitS    :: String
unitS    = "second"

unitMIN  :: String
unitMIN  = "minute"

unitH    :: String
unitH    = "hour"

unitD    :: String
unitD    = "day"

unitW    :: String
unitW    = "week"

unitM    :: String
unitM    = "month"

unitQ    :: String
unitQ    = "quarter"

unitY    :: String
unitY    = "year"

unitDATE :: String
unitDATE = "date"
