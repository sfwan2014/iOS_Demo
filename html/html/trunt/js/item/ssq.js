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
	});
	var myscroll=new iScroll("wrapper",{
		checkDOMChanges: true,
    	hScrollbar:false,
    	vScrollbar:false,
    	onBeforeScrollStart: function (e) { var nodeType = e.explicitOriginalTarget ? e.explicitOriginalTarget.nodeName.toLowerCase():(e.target ? e.target.nodeName.toLowerCase():'');if(nodeType !='select'&& nodeType !='option' && nodeType !='input' && nodeType!='textarea' && nodeType!='ins' && nodeType!='div'){e.preventDefault();}}
	});

	/*返回按钮*/
	$('.topCon a.goback,.topCon a.cancel').bind('click',function(){
		self.location=document.referrer;
	});

	//查询出更多菜单
	$('.menuToolCon a.cx').bind('click',function(){
		$('a.wdzh').removeClass('hoverwdzh');
		$(this).toggleClass('hovercx');
		if($(this).hasClass('hovercx')){
			$('.fotCon').addClass('myFoter');
		}else{
			$('.fotCon').removeClass('myFoter');
		}
		
		$('.ui-cxNav').toggle();
		$('.ui-myNav').hide();
	});
	$('.menuToolCon a.wdzh').bind('click',function(){
		$('a.cx').removeClass('hovercx');
		$(this).toggleClass('hoverwdzh');
		if($(this).hasClass('hoverwdzh')){
			$('.fotCon').addClass('myFoter');
		}else{
			$('.fotCon').removeClass('myFoter');
		}
		$('.ui-cxNav').hide();
		$('.ui-myNav').toggle();
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
});