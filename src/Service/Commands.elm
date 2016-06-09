module Service.Commands exposing
    ( validate )


import Http
import Task
import Service.Models exposing (..)
import Service.Messages exposing (..)


validateTask : Service -> Task.Task String Bool
validateTask service =
    let
        -- no CORS atm
        --"https://api.mblox.com/xms/v1/" ++ service.username ++ "/groups"
        url =
            "/xms/v1/" ++ service.username ++ "/groups"
        authHeader = "Bearer " ++ service.token
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


validate : Service -> Cmd Msg
validate service =
    validateTask service
        |> Task.perform TokenValidationFailed TokenValidationSuccess

