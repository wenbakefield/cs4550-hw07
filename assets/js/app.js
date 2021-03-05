// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"

// Modified from CS 4550 Lecture Notes
// Author: Nat Tuck
// Attribution: https://github.com/NatTuck/scratch-2021-01/blob/master/notes-4550/10-multi/notes.md
import jQuery from 'jquery';
window.jQuery = window.$ = jQuery; // Bootstrap requires a global "$" object.
import "bootstrap";

import flatpickr from 'flatpickr';

window.addEventListener('load', () => {
  flatpickr('.flatpickr-datetime', {
    enableTime: true,
    altInput: true,
    altFormat: "n/j/Y @ h:i K",
  });
});
