// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery.min.js
//= require popper.min.js
//= require bootstrap.min.js
//= require perfect-scrollbar.jquery.min.js
//= require sparkline.js
//= require custom.min.js
//= require owl.carousel.min.js
//= require moment.min.js
//= require fullcalendar.min.js
//= require jquery.ui.touch-punch-improved.js
//= reqiure jquery-ui.min.js
//= require app.init.overlay.js
//= require app-style-switcher.js

$(document).ready(function () {
      $(".owl-carousel").owlCarousel(
              {
                  nav: true,
                  loop: true,
                  responsive: {
                      0: {
                          items: 1,
                          nav: true
                      },
                      600: {
                          items: 3,
                          nav: false
                      },
                      1000: {
                          items: 3,
                          nav: true,
                          loop: true
                      }
                  }
              });
  });


