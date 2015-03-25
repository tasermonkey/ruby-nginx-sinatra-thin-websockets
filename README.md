# Ruby WebSocket example

Web socket example using Nginx, thin, em-websocket, event-machine, and all started with rake

This is a pretty simple webservice written in ruby that exposes websockets while the same server(thin) exposes a sinatra webservice

Though I used thin, any webserver that is supported by event-machine can be used.

I added nginx because normally when I write webservices I end up needing to use a nginx reverse-proxy.  This shows how to get websockets to be proxy through it.

Then the rake task was made because I mainly wanted to learn how to make some rake tasks.

## Getting started

1.  First checkout this code.
1.  execute `rake nginx:start`
1.  execute `rake webserver:start`
1.  You can how hit `http://localhost:3030/try` to verify that the normal end point is hit
1.  You can now in a browser javascript console (or application) hit do (from multiple browser tabs):

    ```
      ws = new WebSocket("ws://localhost:3030/websockets?client_name=one");
      ws.onmessage = function(evt) { console.log("From Server: " + evt.data); }
      ws.send("I am a message");
    ```
### Troubleshooting

* If you receive `nginx: [emerg] too long path in the unix domain socket in upstream` thats because unix socket filename limitation is `108` and OSX is `104`
  * Try setting the env variable `APP_TMP_DIR` to a root path shorter than this source directory path.

# LICENSE

This is license under the MIT License.  See the `LICENSE` file for more details.
