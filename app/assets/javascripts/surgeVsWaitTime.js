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

  Highcharts.setOptions({
       colors: ["#DDDF0D", "#7798BF", "#55BF3B", "#DF5353", "#aaeeee", "#ff0066", "#eeaaee", 
          "#55BF3B", "#DF5353", "#7798BF", "#aaeeee"],
       chart: {
          backgroundColor: {
             linearGradient: [0, 0, 0, 400],
             stops: [
                [0, 'rgb(96, 96, 96)'],
                [1, 'rgb(16, 16, 16)']
             ]
          },
          borderWidth: 0,
          borderRadius: 15,
          plotBackgroundColor: null,
          plotShadow: false,
          plotBorderWidth: 0
       },
       title: {
          style: { 
             color: '#FFF',
             font: '16px Lucida Grande, Lucida Sans Unicode, Verdana, Arial, Helvetica, sans-serif'
          }
       },
       subtitle: {
          style: { 
             color: '#DDD',
             font: '12px Lucida Grande, Lucida Sans Unicode, Verdana, Arial, Helvetica, sans-serif'
          }
       },
       xAxis: {
          gridLineWidth: 0,
          lineColor: '#999',
          tickColor: '#999',
          labels: {
             style: {
                color: '#999',
                fontWeight: 'bold'
             }
          },
          title: {
             style: {
                color: '#AAA',
                font: 'bold 12px Lucida Grande, Lucida Sans Unicode, Verdana, Arial, Helvetica, sans-serif'
             }            
          }
       },
       yAxis: {
          alternateGridColor: null,
          minorTickInterval: null,
          gridLineColor: 'rgba(255, 255, 255, .1)',
          lineWidth: 0,
          tickWidth: 0,
          labels: {
             style: {
                color: '#999',
                fontWeight: 'bold'
             }
          },
          title: {
             style: {
                color: '#AAA',
                font: 'bold 12px Lucida Grande, Lucida Sans Unicode, Verdana, Arial, Helvetica, sans-serif'
             }            
          }
       },
       legend: {
          itemStyle: {
             color: '#CCC'
          },
          itemHoverStyle: {
             color: '#FFF'
          },
          itemHiddenStyle: {
             color: '#333'
          }
       },
       credits: {
          style: {
             right: '50px'
          }
       },
       labels: {
          style: {
             color: '#CCC'
          }
       },
       tooltip: {
          backgroundColor: {
             linearGradient: [0, 0, 0, 50],
             stops: [
                [0, 'rgba(96, 96, 96, .8)'],
                [1, 'rgba(16, 16, 16, .8)']
             ]
          },
          borderWidth: 0,
          style: {
             color: '#FFF'
          }
       },
       
       
       plotOptions: {
          line: {
             dataLabels: {
                color: '#CCC'
             },
             marker: {
                lineColor: '#333'
             }
          },
          spline: {
             marker: {
                lineColor: '#333'
             }
          },
          scatter: {
             marker: {
                lineColor: '#333'
             }
          }
       },
       
       toolbar: {
          itemStyle: {
             color: '#CCC'
          }
       }
    }); 


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