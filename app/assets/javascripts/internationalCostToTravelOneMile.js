function internationalCostToTravelOneMile(cost_trends_hash) {
    
    var sf = cost_trends_hash["SF"];
    var chicago = cost_trends_hash["Chicago"];
    var boston = cost_trends_hash["Boston"];
    var bangkok = cost_trends_hash["Bangkok"];
    var hong_kong = cost_trends_hash["Hong Kong"];
    var perth = cost_trends_hash["Perth"];
    var london = cost_trends_hash["London"];
    var paris = cost_trends_hash["Paris"];
    var seattle = cost_trends_hash["Seattle"];
    var new_york = cost_trends_hash["New York"];
    var new_orleans = cost_trends_hash["New Orleans"];
    var hollywood = cost_trends_hash["Hollywood"];
    var denver = cost_trends_hash["Denver"];

    console.log(denver);

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
        $('#international_data_graph').highcharts({
            chart: {
                type: 'column',
                borderWidth: 3,
                borderColor: 'black',
                borderRadius: 0
            },
            title: {
                text: 'Cost to Travel 1 Mile with Uber in Different Cities Around the World'
            },
            subtitle: {
                text: "Data Used to Compute Average Cost Collect from 6PM January 16th - 6AM January 17th"
            },
            xAxis: {
                type: 'category',
                text: 'City'
            },
            yAxis: {
                title: {
                    text: 'Cost in Dollars'
                }

            },
            legend: {
                enabled: false
            },
            plotOptions: {
                series: {
                    borderWidth: 0,
                    dataLabels: {
                        enabled: true,
                        format: '${point.y:.2f}'
                    }
                }
            },

            tooltip: {
                headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
                pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>${point.y:.2f}</b> of total<br/>'
            },

            series: [{
                name: 'City',
                colorByPoint: true,
                data: [{
                    name: 'San Francisco',
                    y: sf,
                }, {
                    name: 'Chicago',
                    y: chicago
                }, {
                    name: 'Boston',
                    y: boston
                }, {
                    name: 'Bangkok',
                    y: bangkok
                }, {
                    name: 'Hong Kong',
                    y: hong_kong
                }, {
                    name: 'Perth',
                    y: perth
                }, {
                    name: 'London',
                    y: london
                }, {
                    name: 'Paris',
                    y: paris
                }, {
                    name: 'Seattle',
                    y: seattle
                }, {
                    name: 'New York',
                    y: new_york
                }, {
                    name: 'New Orleans',
                    y: new_orleans
                }, {
                    name: 'Hollywood',
                    y: hollywood
                }, {
                    name: 'Denver',
                    y: denver
                }]
            }],
        });
    });
}