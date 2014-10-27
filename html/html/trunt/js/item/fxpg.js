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
    	hScrollbar:false,
    	vScrollbar:false,
    	onBeforeScrollStart: function (e) { var nodeType = e.explicitOriginalTarget ? e.explicitOriginalTarget.nodeName.toLowerCase():(e.target ? e.target.nodeName.toLowerCase():'');if(nodeType !='select'&& nodeType !='option' && nodeType !='input' && nodeType!='textarea' && nodeType!='ins'){e.preventDefault();}}
	});

	/*返回按钮*/
	$('.topCon a.goback,.topCon a.cancel').bind('click',function(){
		self.location=document.referrer;
	});

	//查询出更多菜单
	$('.menuToolCon a.cx').bind('click',function(){
		$(this).toggleClass('hovercx');
		if($(this).hasClass('hovercx')){
			$('.fotCon .bd').height('142px');
			$('.fotCon').height('152px');
		}else{
			$('.fotCon .bd').height('70px');
			$('.fotCon').height('80px');
		}
		$('.menuCxCon').toggle();
	});

	//点击出更多菜单
	$('.top a.nav').bind('click',function(){
		$(this).toggleClass('open');
		if($(this).hasClass('open')){
			$('.leftNav').animate({
				'left' : '0px'
			});
			$(this).removeClass('open');
		}else{
			$('.leftNav').animate({
				'left' : '-180px'
			});
			$(this).addClass('open');
		}
		event.stopPropagation();
		event.preventDefault();
	});
	$('.global').bind('click',function(){
		$('.top a.nav').removeClass('open');
		$('.leftNav').animate({
			'left' : '-180px'
		});
	});
});