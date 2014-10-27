$(function(){
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


	// $('.j-topCon a.goback,.j-topCon a.cancel').bind('click',function(){
	// 	if(isMobile.iOS()){
		// 	$(this).attr('href','javascript:void(0)');
		// 	window.location='cancel';
		// }else if(isMobile.Android()){
		// 	$(this).attr('href','javascript:history.go(-1);');
		// 	finish();
	// 	}else{
	// 		$(this).attr('href','javascript:history.go(-1);');
	// 		//self.location=document.referrer;
	// 	}
	// });
	// var isWebView;
	// $('.j-topCon a.goback,.j-topCon a.cancel').bind('click',function(){
	// 	$(this).attr('href','javascript:history.go(-1);');

	// });
	var isWebView;
	try{
		isWebView = window.test();
	}catch(e){
		isWebView = 'web';
	}
  

  
  
    alert(isWebView);
//	if(isWebView == 'ios'){
		$('.j-topCon a.goback,.j-topCon a.cancel').bind('click',function(){
			self.location=document.referrer;
			$(this).attr('href','javascript:void(0)');
			window.location='cancel';
		});
	}else if(isWebView == 'android'){
		$('.j-topCon a.goback,.j-topCon a.cancel').bind('click',function(){
			$(this).attr('href','javascript:history.go(-1);');
			finish();
		});
	}else if(isWebView == 'web'){
		$('.j-topCon a.goback,.j-topCon a.cancel').bind('click',function(){
            alert(window.test());
			$(this).attr('href','javascript:history.go(-1);');
		});
	}

	function initPage(){
        var topHeight = $('.j-topCon').height();//顶部高度
        var totHeight = $('.j-totCon').height() || 0;//顶部占位高度
        var fotHeight = $('.j-fotCon').height() || 0;//底部菜单高度
        var botHeight = $('.j-botCon').height() || 0;//正常底部高度
        var sWidth = screen.width;//全局宽度
        var sHeight = screen.height;//全局高度
        var dHeight = $(window).height();//全局高度
        var dWidth = $(window).width();//全局宽度


        var wrHeight = dHeight - totHeight - topHeight - fotHeight - botHeight;
        var jBgConheight = (dWidth/sWidth)*sHeight;
        var jwHeight = $('.j-wrap').height();
        $('.leftNav').height(dHeight);

        $('.j-main').css({'min-height':wrHeight});
        $('.j-wrap,.j-wrap .bd').css({'min-height':wrHeight+10});
        $('.j-wrapCon,.j-topCon,.j-botCon,.j-totCon,.fotCon').width(dWidth);
        $('.j-wrap').css({'width':dWidth-22});
        //$('body').height(dHeight);
        //$('.j-main').css({'min-height':400});
        //$('.j-topCon,.j-botCon').width(dWidth);
        //$('.j-wrap').css({'width':dWidth-22});
        //$('.j-wrap .fd').css({'height':wrHeight-jwHeight+10});
        //$('.j-bgCon').height(jBgConheight);


        //明细筛选
	    var sxConHeight = $('.j-wrap').height() - 22;
		if(wrHeight < 280){
	        $('.sxCon').height(wrHeight+80);
		}else{
			$('.sxCon').height(wrHeight+20);
			}
    }
    initPage();
    $(window).bind('resize',function(){
        initPage();
    });

    $('.ui-shaixuan,.ui-shaixuanqr').bind('click',function(){
	    	$('.sxCon').toggleClass('hover');
	    	if($('.sxCon').hasClass('hover')){
	    		$('.sxCon').animate({
		    		right : '11px'
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

	/*点击切换记住用户名*/
	$('.rmUse').bind('click',function(){
		if($(this).hasClass('fgUse')){
			$(this).removeClass('fgUse');
		}else{
			$(this).addClass('fgUse');
		}
	});

	function getFgPw(){
		var html = '';
			html += '<div style="margin:10px;font-size:14px; width:220px;">请登录建信基金官网（<a href="http://www.ccbfund.cn">www.ccbfund.cn</a>）找回交易密码</div>'
				 +'<p class="btn"><a class="gotoIndex ui-tipsClose" href="javascript:void(0)">确 定</a></p>';
		return html;
	}
  
	$('.ui-fgPassword').bind('click',function(){
		var html = getFgPw();
		$('.ui-tipsCon').html(html);
		resizeTips();
	});

	$('.ui-zztj').bind('change',function(){
		if($(this).val() != 1){
			$('.ui-zztj-txt').show().siblings().hide();
		}else{
			$('.ui-zztj-time').show().siblings().hide();
		}
	});

	

	/*重置登录按钮宽度*/
	function reLoginBtnWidh(){
		var cWidth = $('.loginBtn').width();
		var dWidth = $('.tyj p.btn').width();
		$('.ui-loginBtn').width((cWidth-30)/2);
		$('.tyj a.gotoIndex').width((dWidth-20)/2);
	}
	reLoginBtnWidh();

	//选项卡
	$('.ui-tab-menu li').bind('click',function(){
		var _this = $(this);
		var curIndex = _this.index();
		_this.addClass('cur').siblings().removeClass('cur');
		_this.parent().siblings('.ui-tab-con').find('.ui-tab-item').eq(curIndex).show().siblings().hide();
	});


	//重置select宽度
	function reSelectWidth(){
		var cWidth = $('.loginInput').width();
		$('.selectList').width(cWidth-2);
		$('.dqcrList .selectList').width(cWidth-152);
	}
	reSelectWidth();
	$(window).bind('resize',function(){
		reLoginBtnWidh();
		reSelectWidth();
	});

	//选项事件
	$('.ui-selectBtn').bind('click',function(){
		var _this = $(this);
		_this.parent().parent().css({'zIndex':'99'}).siblings().css({'zIndex':'0'});
		_this.parent().next('.ui-selectList').show();
		_this.find('i').toggleClass('cur');
	});
	$('.ui-selectList li').bind('click mouseenter',function(e){
		var _this = $(this);
		if(e.type == 'mouseenter'){
			_this.addClass('cur').siblings().removeClass('cur');
		}else{
			var curVal = _this.text();
			_this.parent().prev().find('i').text(curVal).removeClass('cur');
			_this.parent().toggle();
		}
	});

	function reIscroll(elm,clsName){
		var topHeight = $('.j-topCon').height();//顶部高度
        var totHeight = $('.j-totCon').height() || 0;//顶部占位高度
        var fotHeight = $('.j-fotCon').height() || 0;//底部菜单高度
        var botHeight = $('.j-botCon').height() || 0;//正常底部高度
        var sWidth = screen.width;//全局宽度
        var sHeight = screen.height;//全局高度
        var dHeight = $(window).height();//全局高度
        var dWidth = $(window).width();//全局宽度


        var wrHeight = dHeight - totHeight - topHeight - fotHeight - botHeight;
        var jBgConheight = (dWidth/sWidth)*sHeight;

		if(elm.hasClass(clsName)){
			$('.j-main').css({'min-height':wrHeight+65});
        	$('.j-wrap,.j-wrap .bd').css({'min-height':wrHeight+75});
		}else{
			$('.j-main').css({'min-height':wrHeight});
        	$('.j-wrap,.j-wrap .bd').css({'min-height':wrHeight+10});
		}
	}

	//查询出更多菜单
	$('.menuToolCon a.cx').bind('click',function(){
		var _this = $(this);
		$('a.wdzh').removeClass('hoverwdzh');
		$(this).toggleClass('hovercx');
		if($(this).hasClass('hovercx')){
			$('.fotCon').addClass('myFoter');
		}else{
			$('.fotCon').removeClass('myFoter');
		}
		$('.ui-cxNav').toggle();
		$('.ui-myNav').hide();
		reIscroll(_this,'hovercx');
	});
	$('.menuToolCon a.wdzh').bind('click',function(){
		var _this = $(this);
		$('a.cx').removeClass('hovercx');
		$(this).toggleClass('hoverwdzh');
		if($(this).hasClass('hoverwdzh')){
			$('.fotCon').addClass('myFoter');
		}else{
			$('.fotCon').removeClass('myFoter');
		}
		$('.ui-cxNav').hide();
		$('.ui-myNav').toggle();
		reIscroll(_this,'hoverwdzh');
	});

	//解决输入框有焦点时的fixed bug
	$('select').each(function(){
		$(this).bind('focus blur',function(e){
			if(e.type == 'focus'){
				$('.j-topCon,.j-fotCon,.j-botCon,.j-totCon').css({'position':'absolute'});
			}else{
				$('.j-topCon,.j-fotCon,.j-botCon,.j-totCon').css({'position':'fixed'});
			}
		});
	});

	//点击出更多菜单
	$('.j-top a.nav').bind('click',function(){
		$(this).toggleClass('open');
		var dWidth = $(window).width();
		dWidth = dWidth - 180;
		if($(this).hasClass('open')){
			$('.j-main').animate({
				'left' : '180px',
				'width': dWidth
			});
			$('.j-topCon').animate({
				'left' : '180px'
			});
			$('.j-fotCon').animate({
				'left' : '180px'
			});
			$('.leftNav').animate({
				'left' : '0px'
			});
			$(this).addClass('open');
		}else{
			$('.j-main').animate({
				'left' : '0px',
				'width': '100%'
			});
			$('.j-topCon').animate({
				'left' : '0px'
			});
			$('.j-fotCon').animate({
				'left' : '0px'
			});
			$('.leftNav').animate({
				'left' : '-180px'
			});
			$(this).removeClass('open');
		}
		event.stopPropagation();
		event.preventDefault();
	});

	$(window).bind('resize',function(){
		var dWidth = $(window).width();
		dWidth = dWidth - 180;
		if($('.j-top a.nav').hasClass('open')){
			$('.j-main').animate({
				'left' : '180px',
				'width': dWidth
			});
			$('.j-topCon').animate({
				'left' : '180px'
			});
			$('.j-fotCon').animate({
				'left' : '180px'
			});
			$('.leftNav').animate({
				'left' : '0px'
			});
			$(this).addClass('open');
		}else{
			$('.j-main').animate({
				'left' : '0px',
				'width': '100%'
			});
			$('.j-topCon').animate({
				'left' : '0px'
			});
			$('.j-fotCon').animate({
				'left' : '0px'
			});
			$('.leftNav').animate({
				'left' : '-180px'
			});
			$(this).removeClass('open');
		}
	});
	// $('.global').bind('click',function(){
	// 	$('.top a.nav').removeClass('open');
	// 	$('.leftNav').animate({
	// 		'left' : '-180px'
	// 	});
	// });

	$('.ui-btnTyj').bind('click',function(){
		if($('#phone').val() == '' || $('#name').val() == '' || $('#yijianText').val() == ''){
			alert('请填写完必填项。');
		}else{
			$(this).attr('href','dengluhou.html');
		}
	});

	$('.ui-reset').bind('click',function(){
		$('#phone').val('');
		$('#name').val('');
		$('#yijianText').val('');
	});

	$('.anList li').bind('click',function(){
		var _this = $(this);
		_this.toggleClass('cur').siblings().removeClass('cur');
	});

    function getTipsMM(quxian){
    	var html = '';
    	if(quxian){
    		var location = 'quxianguoye.html';
    		html +='<div class="fwts_srmm">'
				+'<div class="srmmWrap">'
		            +'<div class="srmmCon">'
		                +'<h6 class="title">服务提示</h6>'
		                +'<p class="tTips">为确保账户安全，请输入交易密码</p>'
		                +'<input class="password" type="password" />'
		            +'</div>'
		            +'<div class="hrText">'
		                +'<div class="hrText01"></div>'
		            +'</div>'
		            +'<p class="btn">'
		                +'<a class="gotoIndex ui-tipsClose" href="javascript:void(0)">取 消</a>'
		                +'<a class="gotoIndex" href="'+location+'">确 定</a>'
		            +'</p>'
	            +'</div>'
	            +'<div class="qrtjWrap">'
		            +'<div class="qrtjCon">'
		                +'<h6 class="title">服务提示</h6>'
		                +'<p class="tTips" style="text-align: left;">确认提交后，将从您的银行账户实时扣款</p>'
		            +'</div>'
		            +'<div class="hrText">'
		                +'<div class="hrText01"></div>'
		            +'</div>'
		            +'<p class="btn">'
		                +'<a class="gotoIndex ui-tipsClose" href="javascript:void(0)">取 消</a>'
		                +'<a class="gotoIndex" href="'+location+'">确 定</a>'
		            +'</p>'
	            +'</div>'
	        +'</div>';
    	}else{
			var location = 'cunrujieguoye.html';
			html +='<div class="fwts_srmm">'
				+'<div class="srmmWrap">'
		            +'<div class="srmmCon">'
		                +'<h6 class="title">服务提示</h6>'
		                +'<p class="tTips">为确保账户安全，请输入交易密码</p>'
		                +'<input class="password" type="password" />'
		                +'<p class="tText">确认提交后，将从您的银行账户实时扣款</p>'
		            +'</div>'
		            +'<div class="hrText">'
		                +'<div class="hrText01"></div>'
		            +'</div>'
		            +'<p class="btn">'
		                +'<a class="gotoIndex ui-tipsClose" href="javascript:void(0)">取 消</a>'
		                +'<a class="gotoIndex ui-qrtjBtn" href="javascript:void(0)">确 定</a>'
		            +'</p>'
	            +'</div>'
	            +'<div class="qrtjWrap">'
		            +'<div class="qrtjCon">'
		                +'<h6 class="title">服务提示</h6>'
		                +'<p class="tTips" style="text-align: left;">确认提交后，将从您的银行账户实时扣款</p>'
		            +'</div>'
		            +'<div class="hrText">'
		                +'<div class="hrText01"></div>'
		            +'</div>'
		            +'<p class="btn">'
		                +'<a class="gotoIndex ui-tipsClose" href="javascript:void(0)">取 消</a>'
		                +'<a class="gotoIndex" href="'+location+'">确 定</a>'
		            +'</p>'
	            +'</div>'
	        +'</div>';
    	}
		
		
		return html;
	}

    function resizeTips(){
		$('.ui-tipsBg').fadeIn(100,function(){
			$('.ui-tipsWrap').fadeIn(200);
		});
		var tipsWidth = -$('.ui-tipsWrap').width()-2;//数字为内边距和边框
		var tipsHeight = -$('.ui-tipsWrap').height()-2;//数字为内边距和边框
		$('.ui-tipsWrap').css({'margin-left':''+tipsWidth/2+'px','margin-top':''+tipsHeight/2+'px'});
	}

    $('.ui-Confirm').bind('click',function(){
    	if($(this).hasClass('ui-quxian')){
    		var quxian = true;
    		var html = getTipsMM(quxian)
    	}else{
    		var html = getTipsMM();
    	}
		
		$('.ui-tipsCon').html(html);
		resizeTips();
	});
	$('body').delegate('.ui-qrtjBtn','click',function(){
		$('.srmmWrap').hide();
		$('.qrtjWrap').show();
	});

	/*关闭tips*/
	$('body').delegate('.ui-tipsClose','click',function(){
		$('.ui-tipsWrap').fadeOut(100,function(){
			$('.ui-tipsBg').fadeOut(200);
			$('.ui-tipsCon').html('');//清空tips内容
		});
	});

	function testIos(){
		alert('ios,test~');
	}
});