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