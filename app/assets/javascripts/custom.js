$(function () {
    "use strict";

    $(".preloader").fadeOut();
    $(".alert").fadeOut(5000);
    if (document.getElementById("myTextarea")) {
        document.getElementById("myTextarea").placeholder = "Description (Optional)";
    }
    $('.add_nested_fields_link').click(function () {
        var x = document.getElementById("myDIV");
        if (x.style.display === "none") {
            x.style.display = "block";
        } else {
            // x.style.display = "none";
        }
    });
    $('.remove_nested_fields_link').click(function () {
        var x = document.getElementById("myDIV");
        if (x.style.display === "none") {
            x.style.display = "block";
        } else {
            // x.style.display = "none";
        }
    });


});



