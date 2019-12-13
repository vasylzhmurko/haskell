module Timer where

import Control.Concurrent
import Control.Concurrent.STM



func x y = do
    timer1 <- newTimer (x * 1000000)
    waitTimer timer1
    --putStrLn "Timer 1 expired"

    timer2 <- newTimer (1 * 1000000)
    forkIO $ do
        waitTimer timer2
        putStrLn "Timer 2 expired"
    stopTimer timer2
    --putStrLn "Timer 2 stopped"
    print y

data State = Start | Stop
type Timer = (TVar State, TMVar ())

waitTimer :: Timer -> IO ()
waitTimer (_, timer) = atomically $ readTMVar timer

stopTimer :: Timer -> IO ()
stopTimer (state, _) = atomically $ writeTVar state Stop

newTimer :: Int -> IO Timer
newTimer n = do
    state <- atomically $ newTVar Start
    timer <- atomically $ newEmptyTMVar
    forkIO $ do
        threadDelay n
        atomically $ do
            runState <- readTVar state
            case runState of
                Start -> putTMVar timer ()
                Stop  -> return ()
    return (state, timer)
