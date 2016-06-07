// pull in desired CSS/SASS files
require( './styles/main.scss' );

// inject bundled Elm app into div#main
var Elm = require( './Main' );
var app = Elm.Main.embed( document.getElementById( 'main' ) );

// app.ports.localStorage.subscribe(function(msg) {
//   console.log("Hello from elm: " + msg);
// });
