$(function(){
	$('.hd a.nav').bind('click',function(){
		var conHeight = $('.main').height();
		$('.leftNav').height(conHeight);
		if($(this).hasClass('open')){
			$('.leftNav')
			$('.main').animate({
				'left' : '0px'
			});
			$('.leftNav').animate({
				'left' : '-200px'
			});
			$(this).removeClass('open');
		}else{
			$('.leftNav')
			$('.main').animate({
				'left' : '200px'
			});
			$('.leftNav').animate({
				'left' : '0px'
			});
			$(this).addClass('open');
		}
	});
	$('.menuToolCon a.cx').bind('click',function(){
		$(this).toggleClass('hovercx');
		$('.menuCxCon').toggle();
	});
});