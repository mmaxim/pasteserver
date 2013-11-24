# PasteServer 

An extremely simple client/server setup for sharing a clipboard amongst different systems. 
Right now it only support X11 and OSX.

### Usage

#### X11 ####
    ./start_x11

#### OSX ####
    ./start_osx

##### You can also query the server for history #####
    curl localhost:4567/history
