$(document).ready(function(){
  function getChart1(){
    $('#chart1').html('');
    var line1=[
      ['09-Sep-2013', 13],
      ['10-Sep-2013', 24],
      ['11-Sep-2013', 38],
      ['12-Sep-2013', 27],
      ['13-Sep-2013', 53],
      ['14-Sep-2013', 67],
      ['15-Sep-2013', 99]
      ];
    var plot1 = $.jqplot('chart1', [line1], {
        axes:{
          xaxis:{
            ticks: ['08-Sep-2013','09-Sep-2013','10-Sep-2013','11-Sep-2013','12-Sep-2013','13-Sep-2013','14-Sep-2013','15-Sep-2013','16-Sep-2013'],
            renderer:$.jqplot.DateAxisRenderer,
            tickOptions:{
              formatString:'%m.%d',
              showGridline: false,
              markSize: 0,
              pad:1.5
            }
          },
          yaxis:{
            showTicks: false,
            tickOptions:{
              formatString:'%.2f元'
            },
            min:0,
            pad:1.5
          }
        },
        series:[{color:'#ff8322',markerOptions:{style:'circle'}}],
        grid:{
          drawGridLines: true, 
          gridLineColor: '#f0f1f3',
          background: '#fff',
          borderColor: '#f0f1f3',
          borderWidth: 1, 
          shadowAngle: 0,
          shadowOffset: 0,
          shadowWidth: 0,
          shadowDepth: 0, 
          shadowAlpha: 0, 
          renderer: $.jqplot.CanvasGridRenderer,
          rendererOptions: {} 
        },
        highlighter: {
          show: true,
          tooltipAxes :'y',
          tooltipLocation: 's'
        },
        cursor: {
          show: false
        }
    });
  }
  function getChart2(){
    $('#chart2').html('');
    var line2=[
      ['09-Sep-2013', 54],
      ['10-Sep-2013', 24],
      ['11-Sep-2013', 38],
      ['12-Sep-2013', 27],
      ['13-Sep-2013', 53],
      ['14-Sep-2013', 67],
      ['15-Sep-2013', 99]
      ];
    var plot2 = $.jqplot('chart2', [line2], {
        axes:{
          xaxis:{
            ticks: ['08-Sep-2013','09-Sep-2013','10-Sep-2013','11-Sep-2013','12-Sep-2013','13-Sep-2013','14-Sep-2013','15-Sep-2013','16-Sep-2013'],
            renderer:$.jqplot.DateAxisRenderer,
            tickOptions:{
              formatString:'%m.%d',
              showGridline: false,
              markSize: 0,
              pad:1.5
            }
          },
          yaxis:{
            showTicks: false,
            tickOptions:{
              formatString:'%.2f元'
            },
            min:0,
            pad:1.5
          }
        },
        series:[{color:'#ff8322',markerOptions:{style:'circle'}}],
        grid:{
          drawGridLines: true, 
          gridLineColor: '#f0f1f3',
          background: '#fff',
          borderColor: '#f0f1f3',
          borderWidth: 1, 
          shadowAngle: 0,
          shadowOffset: 0,
          shadowWidth: 0,
          shadowDepth: 0, 
          shadowAlpha: 0, 
          renderer: $.jqplot.CanvasGridRenderer,
          rendererOptions: {} 
        },
        highlighter: {
          show: true,
          tooltipAxes :'y',
          tooltipLocation: 's'
        },
        cursor: {
          show: false
        }
    });
  }
  getChart1();
  
  $(window).resize(function(){
    getChart1();
    getChart2();
  });

  //选项卡
  $('.ui-tab-menu li').live('click',function(){
    var _this = $(this);
    var curIndex = _this.index();
    _this.addClass('cur').siblings().removeClass('cur');
    _this.parent().siblings('.ui-tab-con').find('.ui-tab-item').eq(curIndex).show().siblings().hide();
    if(curIndex == 0){
      getChart1();
    }else if(curIndex == 1){
      getChart2();
    }
  });
});