$(function(){
	/*点击切换记住用户名*/
	$('.rmUse').on('click',function(){
		$(this).toggleClass('fgUse');
	});

	/*重置登录按钮宽度*/
	function reLoginBtnWidh(){
		var cWidth = $('.loginBtn').width();
		var dWidth = $('.tyj p.btn').width();
		$('.ui-loginBtn').width((cWidth-30)/2);
		$('.tyj a.gotoIndex').width((dWidth-20)/2);
	}
	reLoginBtnWidh();

	function reSelectWidth(){
		var cWidth = $('.loginInput').width();
		$('.selectList').width(cWidth-2);
		$('.dqcrList .selectList').width(cWidth-142);
	}
	reSelectWidth();
	$(window).on('resize',function(){
		reLoginBtnWidh();
		reSelectWidth();
	});

	//选项事件
	$('.ui-selectBtn').on('click',function(){
		var _this = $(this);
		_this.parent().parent().css({'zIndex':'99'}).siblings().css({'zIndex':'0'});
		_this.parent().next().toggle();
		_this.find('i').toggleClass('cur');
	});
	$('.ui-selectList li').on('click mouseenter',function(e){
		var _this = $(this);
		if(e.type == 'mouseenter'){
			_this.addClass('cur').siblings().removeClass('cur');
		}else{
			var curVal = _this.text();
			_this.parent().prev().find('i').text(curVal).removeClass('cur');
			_this.parent().toggle();
		}
	});

	//选项卡
	$('.ui-tab-menu li').on('click',function(){
		var _this = $(this);
		var curIndex = _this.index();
		_this.addClass('cur').siblings().removeClass('cur');
		_this.parent().siblings('.ui-tab-con').find('.ui-tab-item').eq(curIndex).show().siblings().hide();
	});

	$('.anList li').on('click',function(){
		var _this = $(this);
		_this.addClass('cur').siblings().removeClass('cur');
	});
	$('.ui-reset').on('click',function(){
		$('#phone').val('');
		$('#name').val('');
		$('#yijianText').val('');
	});

	var isMobile = {
		Android: function() {
			return navigator.userAgent.match(/Android/i) ? true : false;
		},
		iOS: function() {
			return navigator.userAgent.match(/iPhone|iPad|iPod/i) ? true : false;
		},
	}
	if(isMobile.Android()){
		function finish(){
	    	window.eee.finis(true);
		}
	}
	

	$('.hd a.goback').on('click',function(){
		if(isMobile.iOS()){
			$(this).attr('href','javascript:void(0)');
			window.location='cancel';
		}else if(isMobile.Android()){
			$(this).attr('href','javascript:history.go(-1);');
			finish();
            window.eee.finis(true);
		}
	});
  
    $('.hd a.cancel').on('click',function(){
       if(isMobile.iOS()){
           $(this).attr('href','javascript:void(0)');
           window.location='cancel';
       }else if(isMobile.Android()){
           $(this).attr('href','javascript:history.go(-1);');
           finish();
           window.eee.finis(true);
       }
    });

    //明细筛选
    var sxConHeight = $('.con').height();
    $('.sxCon').height(sxConHeight+2);
    $('.ui-shaixuan,.ui-shaixuanqr').on('click',function(){
    	$('.sxCon').toggleClass('hover');
    	if($('.sxCon').hasClass('hover')){
    		$('.sxCon').animate({
	    		right : '-10px'
	    	},function(){
	    		$('.ui-shaixuan').addClass('shaixuanHover');
	    	});
    	}else{
    		$('.sxCon').animate({
	    		right : '-999px'
	    	},function(){
	    		$('.ui-shaixuan').removeClass('shaixuanHover');
	    	});
    	}
    	
    });
});