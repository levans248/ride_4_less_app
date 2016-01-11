$(document).ready(function(){
    $(window).resize(function(){
        var footerHeight = $('.footer').outerHeight();
        var stickFooterPush = $('.push').height(footerHeight);
  
        $('.content_wrapper').css({'marginBottom':'-' + footerHeight + 'px'});
      });
  
      $(window).resize();
    });