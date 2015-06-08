/**
 * Created by ubuntujordi on 8/06/15.
 */
/*(
    function(){
        var app = angular.module("SongProjectJS",["SongSearch"]);
    }
    app.controller("SongProjectController", ["$http",
        function($http){

            this.songApi = 'http:localhost:3000/songCollection/'
            this.isLoading = false;
            this.song = {
                name: '',
                band:''

            }
            var songsCtrl = this;

            this.listSongs = function(name, id) {
                this.isLoading = true;
                $http.get(this.songApi+ id + '/songs/search?' + name)
                    .success(function (data) {
                        songsCtrl.songs = data;
                    });
            };

            this.addSong = function(song){
                $http.post(this.songApi, song)
                    .then(function(){
                        songsCtrl.newSong ={
                            name:song.name,
                            band:song.band
                        }

                    })
            }

        }

    ])
)*/