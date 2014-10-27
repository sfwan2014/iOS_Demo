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
	    	hScrollbar:false,
	    	vScrollbar:false
		});
	});
	// var myscroll=new iScroll("wrapper",{
	// 	hScroll:false,
 //    	hScrollbar:false,
 //    	vScrollbar:false
	// });
	

	// var myglobal = new iScroll("global",{
	// 	vScroll: false,
	// 	hScrollbar: false,
	// 	useTransition:true,
	// 	onBeforeScrollStart: function(e) {
	// 		var nodeType = e.explicitOriginalTarget ? e.explicitOriginalTarget.nodeName.toLowerCase():(e.target ? e.target.nodeName.toLowerCase():'');
 //    		if(nodeType !='select'&& nodeType !='option' && nodeType !='input' && nodeType!='textarea' && nodeType!='a'){
 //    			e.preventDefault();
 //    		}
	// 		e.stopPropagation();
	// 	}
	// });

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
			_this.parent().hide();
		}
	});
});