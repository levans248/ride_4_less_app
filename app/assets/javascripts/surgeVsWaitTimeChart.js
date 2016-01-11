function surgeVsWaitTime(json_data) {

  var surgePriceArray = [];
  var normalPriceArray =[];


  for(var i=0; i < json_data.length; i++){
    if(json_data[i]["surge_multiplier"]==1) {
      normalPriceArray.push([json_data[i]["time_estimate"]/60.0, json_data[i]["surge_multiplier"]]);
    } else {
      surgePriceArray.push([json_data[i]["time_estimate"]/60.0, json_data[i]["surge_multiplier"]]);
    }
  }
  $(function () { 
  var surgeChart = $('#new_years_data_graph').highcharts({
      chart: {
          type: 'scatter',
          zoomType: 'xy',
          renderTo: 'new_years_data_graph',
          borderWidth: 3,
          borderColor: 'black',
          borderRadius: 0
      },
      title: {
          text: 'Uber Surge Multiplier vs. Wait Time'
      },
      subtitle: {
          text: 'Uber Data Collected Dec. 30th, 2015 - Jan 2nd, 2016'
      },
      xAxis: {
          title: {
              enabled: true,
              text: 'Wait Time (minutes)'
          },
          startOnTick: true,
          endOnTick: true,
          showLastLabel: true
      },
       yAxis: {
          title: {
              text: 'Surge Multiplier'
          }
      },
      legend: {
          layout: 'vertical',
          align: 'right',
          verticalAlign: 'top',
          x: -10,
          y: 10,
          floating: true,
          backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
          borderWidth: 1
      },
      plotOptions: {
          scatter: {
              marker: {
                  radius: 5,
                  states: {
                      hover: {
                          enabled: true,
                          lineColor: 'rgb(100,100,100)'
                      }
                  }
              },
              states: {
                  hover: {
                      marker: {
                          enabled: false
                      }
                  }
              },
              tooltip: {
                  headerFormat: '<b>{series.name}</b><br>',
                  pointFormat: '{point.x} minutes, {point.y} X'
              }
          }
      },
      series: [{
          name: 'Surging',
          color: 'rgba(223, 83, 83, .5)',
          data: surgePriceArray
      },{
          name: 'Normal Price',
          color: 'rgba(102, 234, 113, 0.9)',
          data: normalPriceArray
      }]
    });
  });
}