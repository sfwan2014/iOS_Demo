$(function(){
	var topHeight = $('.topCon').height();//顶部高度
	var fotHeight = $('.fotCon').height() || 0;//底部菜单高度
	var botHeight = $('.botCon').height() || 0;//正常底部高度
	var dHeight = $(window).height();//全局高度
	var wrHeight = dHeight - topHeight - fotHeight - botHeight;
	$('.wrap').height(wrHeight);
	$('.main').height(wrHeight-11);
	$('.leftNav').height(dHeight);

	$(window).bind('resize',function(){
		var dHeight = $(window).height();//全局高度
		var wrHeight = dHeight - topHeight - fotHeight - botHeight;
		$('.wrap').height(wrHeight);
		$('.main').height(wrHeight-11);
		$('.leftNav').height(dHeight);
		myscroll.destroy();
		myscroll=new iScroll("wrapper",{
			checkDOMChanges: true,
	    	hScrollbar:false,
	    	vScrollbar:false
		});
	});

	var myscroll=new iScroll("wrapper",{
		checkDOMChanges: true,
		hScroll:false,
    	hScrollbar:false,
    	vScrollbar:false
	});

	/*返回按钮*/
	$('.topCon a.goback,.topCon a.cancel').bind('click',function(){
		self.location=document.referrer;
	});

	/*点击切换记住用户名*/
	$('.rmUse').bind('click',function(){
		if($(this).hasClass('fgUse')){
			$(this).removeClass('fgUse');
		}else{
			$(this).addClass('fgUse');
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
		var tfVal = $('#wrapper .bd').css('marginTop');
		//var tfVal = $('#wrapper .bd').css('-webkit-transform');
		tfVal = tfVal.split(',')[tfVal.split(',').length - 1];
		tfVal = parseInt(tfVal.substring(0,tfVal.length-1)) - 65;

		var topHeight = $('.topCon').height();//顶部高度
		var fotHeight = $('.fotCon').height() || 0;//底部菜单高度
		var botHeight = $('.botCon').height() || 0;//正常底部高度
		var dHeight = $(window).height();//全局高度
		var wrHeight = dHeight - topHeight - fotHeight - botHeight;
		$('.wrap').height(wrHeight);
		$('.main').height(wrHeight-11);
		myscroll.destroy();
		myscroll=new iScroll("wrapper",{
			checkDOMChanges: true,
	    	hScrollbar:false,
	    	vScrollbar:false
		});
		if(elm.hasClass(clsName)){
			// $('#wrapper .bd').css({'-webkit-transform':'matrix(1, 0, 0, 1, 0, '+tfVal+')'});
			$('#wrapper .bd').css({'margin-top':'-65px'});
		}else{
			$('#wrapper .bd').css({'margin-top':'0px'});
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

	//点击出更多菜单
	$('.top a.nav').bind('click',function(){
		$(this).toggleClass('open');
		if($(this).hasClass('open')){
			$('.global').animate({
				'left' : '180px'
			});
			$('.topCon').animate({
				'left' : '180px'
			});
			$('.fotCon').animate({
				'left' : '180px'
			});
			$('.leftNav').animate({
				'left' : '0px'
			});
			$(this).addClass('open');
		}else{
			$('.global').animate({
				'left' : '0px'
			});
			$('.topCon').animate({
				'left' : '0px'
			});
			$('.fotCon').animate({
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
	// $('.global').bind('click',function(){
	// 	$('.top a.nav').removeClass('open');
	// 	$('.leftNav').animate({
	// 		'left' : '-180px'
	// 	});
	// });

	$('.ui-reset').bind('click',function(){
		$('#phone').val('');
		$('#name').val('');
		$('#yijianText').val('');
	});

	$('.anList li').bind('click',function(){
		var _this = $(this);
		_this.addClass('cur').siblings().removeClass('cur');
	});

	//明细筛选
    var sxConHeight = $('.wrap').height();
    $('.sxCon').height(sxConHeight+12);
    $('.ui-shaixuan,.ui-shaixuanqr').bind('click',function(){
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

    function getTipsMM(quxian){
    	if(quxian){
    		var location = 'quxianguoye.html';
    	}else{
			var location = 'cunrujieguoye.html';
    	}
		var html = '';
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
});