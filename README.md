# Swift Websocket Server Example using Vapor 4.0

This project includes a minimum working example for a websocket server written in Swift. To interact with it I recommend using `websocat` ([Github-Link](https://github.com/vi/websocat)). 

Part of the challenge was to binary-encode and decode JSON payload into predefined Swift structs which are stored in the `Sources/App/websocket/messages` folder. 

## How to use
1. Build and run using `swift build` and `swift run`
2. In this example the websocket is served under the `/channel` path. In the terminal connect to the websocket server using `websocat`:
    ```bash
    # '-b' transfers payload binary encoded
    websocat -b ws://127.0.0.1:8080/channel
    ```
3. Paste into the console the JSON payload in the valid format (it is of type `WebsocketMessage<Connect>`):
    ```JSON
    {"client":"C13C2DA8-13FA-4BA6-A361-61488AC5B66A","data":{"connect":true}}
    ``` 
4. The websocket server should return the following message which should be displayed in the terminal decoded as string:
    ```JSON
    {"client":"C13C2DA8-13FA-4BA6-A361-61488AC5B66A","data":{"name":"Adrian","male":true,"age":33}}
    ```
