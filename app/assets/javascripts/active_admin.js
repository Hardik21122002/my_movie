//= require active_admin/base
//= require jquery
//= require jquery_ujs
//= require active_admin
//= require_tree .
 

// require("jquery") 


$(document).ready(function() {
  $('#theater').on('change', function() {
    var theaterId = $(this).val();
    console.log("selected-theater", theaterId);
    $.ajax({
      url: '/theater_screens',
      data: { theater_id: theaterId },
      success: function(data) {
        try {
          var screenDropdown = $('#show_screen_id_input select');
          screenDropdown.empty();
          screenDropdown.append($('<option>', {
            value: '',
            text: 'Select Screen'
          }));
          $.each(data, function(index, screen) {
            screenDropdown.append($('<option>', {
              value: screen.id,
              text: screen.screen_name
            }));
          }); 
        } catch (error) {
          console.error('Error processing response:', error);
        }
      },
      error: function(xhr, status, error) {
        console.error('AJAX request error:', error);
      }
    });
  });
});


document.addEventListener("DOMContentLoaded", function() {
  var userSelect = document.getElementById("user-ids-select");
  var usersFields = document.getElementById("users-fields");

  userSelect.addEventListener("change", function() {
    if (userSelect.value) {
      usersFields.style.display = "none";
    } else {
      usersFields.style.display = "block";
    }
  });
});
