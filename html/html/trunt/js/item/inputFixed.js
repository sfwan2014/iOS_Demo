//解决输入框有焦点时的fixed bug
$('input,textarea').each(function(){
	$(this).bind('focus blur',function(e){
		if(e.type == 'focus'){
			$('.j-topCon,.j-fotCon,.j-botCon,.j-totCon').css({'position':'absolute'});
		}else{
			$('.j-topCon,.j-fotCon,.j-botCon,.j-totCon').css({'position':'fixed'});
		}
	});
});