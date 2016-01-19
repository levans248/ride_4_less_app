function internationalWaitTimeVsTimeOfDay(json_data, string) {

  var sanFranciscoArray= [];
  var hollywoodArray = [];
  var seattleArray = [];
  var denverArray = [];
  var newOrleansArray = [];
  var chicagoArray = [];
  var newYorkArray = [];
  var bostonArray = [];
  var parisArray = [];
  var perthArray =[];
  var londonArray =[];
  var bangkokArray =[];
  var hongKongArray =[];


  if(string == "international") {
    for(var i=0; i < json_data.length; i++){
      if(json_data[i]["city"] == "Nob Hill") {
        sanFranciscoArray.push(Math.round((json_data[i]["wait_time"]/60.0)* 100) / 100);
      } else if (json_data[i]["city"] == "Paris") {
        parisArray.push(Math.round((json_data[i]["wait_time"]/60.0)* 100) / 100);   
      } else if (json_data[i]["city"] == "Perth") {
        perthArray.push(Math.round((json_data[i]["wait_time"]/60.0)* 100) / 100);   
      } else if (json_data[i]["city"] == "London") {
        londonArray.push(Math.round((json_data[i]["wait_time"]/60.0)* 100) / 100);   
      } else if (json_data[i]["city"] == "Bangkok") {
        bangkokArray.push(Math.round((json_data[i]["wait_time"]/60.0)* 100) / 100);   
      } else if (json_data[i]["city"] == "Hong Kong") {
        hongKongArray.push(Math.round((json_data[i]["wait_time"]/60.0)* 100) / 100);  
      } 
    }
  } else {
    for(var i=0; i < json_data.length; i++){
      if(json_data[i]["city"] == "Nob Hill") {
        sanFranciscoArray.push(Math.round((json_data[i]["wait_time"]/60.0)* 100) / 100);
      } else if (json_data[i]["city"] == "Hollywood") {
        hollywoodArray.push(Math.round((json_data[i]["wait_time"]/60.0)* 100) / 100);   
      } else if (json_data[i]["city"] == "Seattle") {
        seattleArray.push(Math.round((json_data[i]["wait_time"]/60.0)* 100) / 100);   
      } else if (json_data[i]["city"] == "Denver") {
        denverArray.push(Math.round((json_data[i]["wait_time"]/60.0)* 100) / 100);   
      } else if (json_data[i]["city"] == "New Orleans") {
        newOrleansArray.push(Math.round((json_data[i]["wait_time"]/60.0)* 100) / 100);   
      } else if (json_data[i]["city"] == "Chicago") {
        chicagoArray.push(Math.round((json_data[i]["wait_time"]/60.0)* 100) / 100);  
      } else if (json_data[i]["city"] == "Boston") {
        bostonArray.push(Math.round((json_data[i]["wait_time"]/60.0)* 100) / 100);  
      } else if (json_data[i]["city"] == "Times Square, NY") {
        newYorkArray.push(Math.round((json_data[i]["wait_time"]/60.0)* 100) / 100);  
      }
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

  if(string == "international") {        
    $(function () {
        $('#international_data_graph').highcharts({
            chart: {
                borderWidth: 3,
                borderColor: 'black',
                borderRadius: 0
            },
            title: {
                text: 'International: Wait-Time vs Time Over the Night of Saturday January 16, 2016',
                x: -20 //center
            },
            subtitle: {
                text: '6:00 PM - 6:00 AM',
                x: -20
            },
            xAxis: {
                title: {
                    text: 'Time' 
                },
                type: 'datetime',
                tickInterval: 1000 * 3600,
                dateTimeLabelFormats: {
                    hour: '%l'
                }
            },    
            yAxis: {
                title: {
                    text: 'Wait-Time'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                valueSuffix: ' minutes'
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0
            },
            plotOptions:{
                series:{
                    pointStart:Date.UTC(2015,12,16,18,00),
                    pointInterval: 60 * 1000
                }
            },
            series: [{
                name: 'San Francisco',
                data: sanFranciscoArray
            }, {
                name: "London",
                data: londonArray
            },{
                name: "Paris",
                data: parisArray
            },{
                name: "Perth",
                data: perthArray
            },{
                name: "Hong Kong",
                data: hongKongArray
            },{
                name: "Bangkok",
                data: bangkokArray
            }]
        });
    });
  } else {
    $(function () {
        $('#international_data_graph').highcharts({
            chart: {
                borderWidth: 3,
                borderColor: 'black',
                borderRadius: 0
            },
            title: {
                text: 'Domestic: Surge Multiplier vs Time Over the Nigh of Saturday January 16, 2016',
                x: -20 //center
            },
            subtitle: {
                text: '6:00 PM - 6:00 AM',
                x: -20
            },
            xAxis: {
                title: {
                    text: 'Time' 
                },
                type: 'datetime',
                tickInterval: 1000 * 3600,
                dateTimeLabelFormats: {
                    hour: '%l'
                }
            },    
            yAxis: {
                title: {
                    text: 'Wait-Time'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                valueSuffix: ' minutes'
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0
            },
            plotOptions:{
                series:{
                    pointStart:Date.UTC(2015,12,16,18,00),
                    pointInterval: 60 * 1000
                }
            },
            series: [{
                name: 'San Francisco',
                data: sanFranciscoArray
            }, {
                name: "Hollywood",
                data: hollywoodArray
            },{
                name: "Seattle",
                data: seattleArray
            },{
                name: "Denver",
                data: denverArray
            },{
                name: "New Orleans",
                data: newOrleansArray
            },{
                name: "Chicago",
                data: chicagoArray
            },{
                name: "Boston",
                data: bostonArray
            },{
                name: "New York",
                data: newYorkArray
            }]
        });
    });
  }  
} 