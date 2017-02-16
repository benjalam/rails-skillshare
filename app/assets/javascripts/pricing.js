var start = $('#booking_start_date').val();

var end = $('#booking_end_date').val();

var start_date = new Date(start);
var end_date = new Date(end);

var diffDays = parseInt((end_date - start_date) / (1000 * 60 * 60 * 24));

var price = diffDays*
