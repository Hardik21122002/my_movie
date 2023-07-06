document.addEventListener('DOMContentLoaded', function() {
  const theaterDropdown = document.getElementById('theater-dropdown'); 
  theaterDropdown.addEventListener('change', function() {
    const selectedTheaterId = theaterDropdown.value;
    setTheaterId(selectedTheaterId);
  });

  function setTheaterId(theaterId) {
    $.ajax({
      type: 'POST',
      url: '/set_theater',
      data: { theater_id: theaterId },
      dataType: 'json',
      success: function() {
        // Update the selected value in the theater dropdown
        theaterDropdown.value = theaterId;
        // Reload the page if necessary
        window.location.reload();
      },
      error: function(xhr, textStatus, errorThrown) {
        console.log('Error setting theater ID:', errorThrown);
      }
    });
  }
});
