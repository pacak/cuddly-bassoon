{-# LANGUAGE RankNTypes #-}

module LoneWolf.Chapter
    
    where

import Solver


type ChapterId = Int
type Rounds = Int
type Price = Int


type Lens' b a = forall f. Functor f => (a -> f a) -> b -> f b


data Chapter = Chapter { _pchoice :: Decision
                       } deriving (Show, Eq)


data Decision
   = Decisions [Decision]
   | NoDecision ChapterOutcome
   | EvadeFight Rounds ChapterId FightDetails ChapterOutcome
   | AfterCombat Decision
   deriving (Show, Eq)


data ChapterOutcome
        = Fight FightDetails ChapterOutcome
        | Randomly [(Proba, ChapterOutcome)]
        | Conditionally [(ChapterOutcome)]
        | Goto ChapterId
        | GameLost
        | GameWon
        deriving (Show, Eq)

data FightDetails = FightDetails { _fendurance   :: Int } deriving (Show, Eq)


fendurance :: Lens' FightDetails Int
fendurance f  e = (\e' -> e { _fendurance = e'}) <$> f (_fendurance e)
