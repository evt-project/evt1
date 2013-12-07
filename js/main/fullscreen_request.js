/**
 * 
 * Full screen request
 * Version 0.1 (201210)
 *
 * Dual licensed under the MIT and GPL licenses:
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 * 
 * @author RafMas 
 * @since 2012
 *
 **/

(function () {
    var viewFullScreen = document.getElementById("main_fullscreen");
    if (viewFullScreen) {
        viewFullScreen.addEventListener("click", function () {
			//alert(viewFullScreen.title);
			if(viewFullScreen.title=="fullscreen"){
				var docElm = document.documentElement;
				if (docElm.requestFullscreen) {
					docElm.requestFullscreen();
				}
				else if (docElm.mozRequestFullScreen) {
					docElm.mozRequestFullScreen();
				}
				else if (docElm.webkitRequestFullScreen) {
					docElm.webkitRequestFullScreen();
				}
				//viewFullScreen.title="close";
			}
			else{
				if (document.exitFullscreen) {
					document.exitFullscreen();
				}
				else if (document.mozCancelFullScreen) {
					document.mozCancelFullScreen();
				}
				else if (document.webkitCancelFullScreen) {
					document.webkitCancelFullScreen();
				}
				//viewFullScreen.title="fullscreen";
			}
        }, false);
    }
	
	var viewFullScreenII = document.getElementById("view-fullscreenII");
    if (viewFullScreenII) {
        viewFullScreenII.addEventListener("click", function () {
			if(viewFullScreenII.title=="fullscreen"){
				var docElm = document.documentElement;
				if (docElm.requestFullscreen) {
					docElm.requestFullscreen();
				}
				else if (docElm.mozRequestFullScreen) {
					docElm.mozRequestFullScreen();
				}
				else if (docElm.webkitRequestFullScreen) {
					docElm.webkitRequestFullScreen();
				}
				//viewFullScreenII.title="close";
			}
			else{
				if (document.exitFullscreen) {
					document.exitFullscreen();
				}
				else if (document.mozCancelFullScreen) {
					document.mozCancelFullScreen();
				}
				else if (document.webkitCancelFullScreen) {
					document.webkitCancelFullScreen();
				}
				//viewFullScreenII.title="fullscreen";
			}
        }, false);
    }
	
	//Doesn't quite work - rafmas
	document.addEventListener("mozfullscreenchange", function(e) {
		if(viewFullScreen.title=="fullscreen"){
			viewFullScreen.title="close";
			viewFullScreenII.title="close";
			return false;
		}
		if(viewFullScreen.title=="close")
			viewFullScreen.title="fullscreen";	
			viewFullScreenII.title="fullscreen";	
	},false);
	document.addEventListener("webkitfullscreenchange", function(e) {
		if(viewFullScreen.title=="fullscreen"){
			viewFullScreen.title="close";
			viewFullScreenII.title="close";
			return false;
		}
		if(viewFullScreen.title=="close")
			viewFullScreen.title="fullscreen";	
			viewFullScreenII.title="fullscreen";	},false);

})();

function fullScreenLeft(){
		if (!$("#main_right_frame").hasClass('full')){
				$("#main_left_frame").toggleClass("full");
				if($('#main_left_frame').hasClass('full')){
					var height_full = ($(window).height() > $("body").height()) ? $(window).height()-4 : $("body").height();
					var width_full = ($(window).width()>$("#global_wrapper").width()) ? $(window).width()-4 : $("#global_wrapper").width();
					var margin_left = -($('#main_left_frame').offset().left);
					var margin_top = -($('#main_left_frame').offset().top);
					$('.go-full-right').css("z-index", "0");
					$('#main_left_frame').animate({
						width: width_full,
						height: height_full,
						top: margin_top,
						left: margin_left,
						minWidth: "1021px"
					}, 700);

					var leftR = -($('.go-full-left').offset().left+11);
					$('.go-full-left').animate({
						"left": leftR,
    					"color": "#F5EAD4",
    					"top": "-76px",
					}, 700);
					$('.go-full-left').toggleClass('closeFullScreen');
				} else {
					$('.go-full-right').css("z-index", "99999999");
					$('.go-full-left').animate({
						"left": "-3px",
						"color": "#4E443C",
						"top": "-11px"
					}, 700);
					if($('#main_right_frame').css("display")=="none"){
						$('#main_left_frame').animate({
							width: "99.5%", 
							height: "100%", 
							top: "0px", 
							left: "0px", 
							minWidth: "0px"
						}, 700);
					} else {
						$('#main_left_frame').animate({
							width: "49.8%",
							height: "100%",
							top: "0px",
							left: "0px",
							minWidth: "0px"
						}, 700);
					}
					$('.go-full-left').toggleClass('closeFullScreen');
				}
			}
	}

	function fullScreenRight(){
		$("#main_right_frame").toggleClass("full");
		if($('#main_right_frame').hasClass('full')){
			var height_full = ($(window).height() > $("body").height()) ? $(window).height()-4 : $("body").height();
			var width_full = ($(window).width()>$("#global_wrapper").width()) ? $(window).width()-4 : $("#global_wrapper").width();
			var margin_left = -($('#main_right_frame').offset().left);
			var margin_top = -($('#main_right_frame').offset().top);
			$('.go-full-left').css("z-index", "0");
			
			$('#main_right_frame').animate({
				width: width_full,
				height: height_full,
				marginTop: margin_top,
				left: margin_left,
				minWidth: "1021px"
			}, 700);
			
			var rightR = -((width_full-$('.go-full-right').offset().left)-20);
			$('.go-full-right').animate({
				"right": rightR,
				"top": "-8px",
			    "color": "#F5EAD4"
			},700);

			$('.go-full-right').toggleClass('closeFullScreen');
			
		} else {
			$('.go-full-left').css("z-index", "999999999999");
			$('.go-full-right').animate({
				"right": "-4px",
				"color": "#4E443C",
				"top": "-11px"
			}, 700);
			$('#main_right_frame').animate({
				width:  "49.7%",
				height: "100%", 
				marginTop: "0px", 
				left: "0px", 
				minWidth: "0px"
			}, 700, function(){
				$('#main_right_frame').removeAttr("style");
			});
			$('.go-full-right').toggleClass('closeFullScreen');
		}
	}