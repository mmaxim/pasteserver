# PasteServer 

An extremely simple client/server setup for sharing a clipboard amongst different systems. 
Right now it only supports X11 and OSX.

### Usage

#### Server ####
    ./start_server

#### X11 Client ####
    ./start_x11 <server>

#### OSX Client ####
    ./start_osx <server>

##### You can also query the server for history #####
    curl <server>:4567/history
