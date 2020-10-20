function playPause(id) {
    var mySong = document.getElementById(id); 

    if (mySong.paused) 
        mySong.play(); 
    else 
        mySong.pause(); 
    } 

document.addEventListener('play', function(e) {
    // get all <audio> tag elements in the page.
    var allAudios = document.getElementsByTagName('audio');
    // Iterate through all players and pause them, except for
    // the one who fired the "play" event ("target")
    for (var i = 0; i < allAudios.length; i++) {
        if (allAudios[i] != e.target) {
        allAudios[i].pause();
        }
    }
}, true);