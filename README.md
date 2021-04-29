# Album Art

This app serves the following purposes:

1. To store data on a Spotify user's song history. Accessing information about what a user has listened to can be challenging and is not instantaneous.

2. To prototype how an Apple-like, Album Artwork screen saver could function for Spotify users.

## Links

+ [Album Art](https://album-art.herokuapp.com/) - Play with the app! Note that this app works best on Chrome. Also, because this app is deployed on Heroku, it may take a minute to load. If it takes longer than this, you may need to refresh your browser.
+ [Demo](https://youtu.be/V8r7mgcpA4A) - Watch me demo the app

## Features

* Stores information on recently played Spotify songs, such as album cover images, song titles, and artist names. Recently played songs are accessed via Spotify's API and the Ruby wrapper, [RSpotify](https://github.com/guilhermesad/rspotify). Since Spotify's [Recently Played API](https://developer.spotify.com/documentation/web-api/reference-beta/) only allows users to retrieve information on the past 50 songs, only the most recently played 50 songs can be stored at a time. Thus, users seeking to track their song history beyond 50 songs should regularly log into the program. Songs are automatically loaded each time a user logs in, however songs can be loaded without logging out by clicking 'refresh'.

* Displays the album covers for recently played songs in a clean, customizable view. Users decide which covers to showcase, along with the number of rows and columns of the grid on which to display the songs.

* Plays 30-second song previews. Users can preview songs by clicking on the album covers in the program.

## Preview

![Welcome Screen](/public/screenshots/01_Welcome.png)  
![Sign Up Screen](/public/screenshots/02_Sign_Up.png)  
![Log In Screen](/public/screenshots/03_Log_In.png)  
![Set Up Screen](/public/screenshots/04_Set_Up.png)  
![Select Songs Screen 1](/public/screenshots/05_Edit_1.png)  
![Select Songs Screen 2](/public/screenshots/06_Edit_2.png)  
![Display Album Covers Screen](/public/screenshots/07_Display.png)  

## Configuration

1. Register a Spotify application and obtain a client ID and client secret. Follow this guide from Spotify for information on how to do this: https://developer.spotify.com/documentation/general/guides/app-settings.

2. Generate a secure session secret. You can use the Rake task in the program. Just open the program from your terminal and type in the following command: 

```
rake generate:session_secret'
```

3. Create a file titled '.env' in the program's root directory with the following (replace the 'X's with information from the previous steps):

```
export CLIENT_ID=XXXXXXXXXXXXXXXXXXXXXXX
export CLIENT_SECRET=XXXXXXXXXXXXXXXXXXX
export SESSION_SECRET=XXXXXXXXXXXXXXXXXX
```

4. Run 'bundle install' to install the necessary Ruby gems and you're good to go!

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alexander-mc/album_art.git. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.
