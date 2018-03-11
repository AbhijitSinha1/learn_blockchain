# File Distribution

This application is an alternate file disrtribution channel where the users can either get the file directly from the file creator or from any of the existing users who have the file, but this ensures that the creator of the file is properly compensated each time the user downloads/opens the file. We would be using the blockchain at the backend to store the data of each users history.

## Idea
The core idea is that along with the backend we would have a companion application (preferably a mobile app) which lets users search and download files. Once the file is downloaded, the file can then be shared with other users using the same application. The file share can be either in the form of torrents or a simple file transfer.

Once the file is with the user, they would be able to open the file as many times as they want. The app will ensure that each time the user opens the file the original creator is compensated.

## Setup
To setup the project follow the steps:

* if you do not have a private blockchain setup on your system, install one by running  `npm install -g ethereumjs-testrpc`.
* clone this project to your local system
* in your local project directory run `npm install`
* start your private blockchain network. For `ethereum testrpc` use the command: `testrpc`.
* run this project using the command: `node app.js`
* goto http://localhost:3000/
