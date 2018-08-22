module Main exposing (..)

import Html exposing (Html, div, text, program)
import Mouse
import Time exposing (..)
import Keyboard exposing (..)
import Set exposing (Set)
import Char
import AnimationFrame exposing (..)


-- MODEL


type State
    = Play
    | Pause


type alias Input =
    { space : Bool
    , paddle1 : Int
    , paddle2 : Int
    }


type alias Game =
    { keysDown : Set KeyCode
    , windowDimensions : ( Int, Int )
    , state : State

    -- , delta : Time
    }


init : ( Game, Cmd Msg )
init =
    ( { keysDown = Set.empty
      , windowDimensions = ( 0, 0 )
      , state = Pause
      }
    , Cmd.none
    )



-- Messages


type Msg
    = KeyUpMsg Keyboard.KeyCode
    | KeyDownMsg Keyboard.KeyCode



-- VIEW


view : Game -> Html Msg
view game =
    div []
        [ text (toString game.keysDown) ]



-- UPDATE


update : Msg -> Game -> ( Game, Cmd Msg )
update msg game =
    case msg of
        KeyUpMsg code ->
            ( { game | keysDown = Set.remove code game.keysDown }, Cmd.none )

        KeyDownMsg code ->
            ( { game | keysDown = Set.insert code game.keysDown }, Cmd.none )



-- SUBSCRIPTION


subscriptions : Game -> Sub Msg
subscriptions game =
    Sub.batch
        [ Keyboard.downs KeyDownMsg
        , Keyboard.ups KeyUpMsg
        ]


main : Program Never Game Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
