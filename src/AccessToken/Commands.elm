module AccessToken.Commands exposing
    ( validate )


import Http
import Task
import AccessToken.Models exposing (..)
import AccessToken.Messages exposing (..)


validateTask : AccessToken -> Task.Task String Bool
validateTask accessToken =
    let
        -- no CORS atm
        --"https://api.mblox.com/xms/v1/" ++ accessToken.username ++ "/groups"
        url =
            "/xms/v1/" ++ accessToken.username ++ "/groups"
        authHeader = "Bearer " ++ accessToken.token
        request =
            { verb = "OPTIONS"
            , headers = [ ("Authorization", authHeader) ]
            , url = url
            , body = Http.empty
            }

        promoteError _ =
            "Request failed"

        handleVerifyTokenResp : Http.Response -> Task.Task String Bool
        handleVerifyTokenResp response =
            if response.status == 200 then
                Task.succeed True
            else if response.status == 401 then
                Task.succeed False
            else
                Task.fail "Unexpected response code"
    in
        Task.mapError promoteError (Http.send Http.defaultSettings request)
            `Task.andThen` handleVerifyTokenResp


validate : AccessToken -> Cmd Msg
validate accessToken =
    validateTask accessToken
        |> Task.perform TokenValidationFailed TokenValidationSuccess

