$(document).ready(function() {
  var form = $('#eliza_form')
  form.submit(function(event) {
    event.preventDefault();
    var response = $('#respondness').val();
    var response_table = $('#q_rs');
    $.ajax({
      type: "POST",
      url: "/eliza",
      data: { query: response }
    })
      .done(function( msg ) {
        var newTableRow = $('<tr><td>' + response + '</td><td>' + msg + '</td></tr>');
        response_table.append(newTableRow);
      });
  })
})