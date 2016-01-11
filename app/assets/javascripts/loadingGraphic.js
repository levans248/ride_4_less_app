$(document).ready(function() { 
 
  $(document).ajaxStart($('#new_years_data_graph').block({ 
      message: '<h1>Loading...</h1>', 
      css: { border: '3px solid #a00'} 
      })
  ).ajaxStop($.unblockUI);

  $('.toggle_chart_buttons').click(function() { 
            $('#new_years_data_graph').block({ message: '<h1>Loading</h1' }); 
        });




}); 
