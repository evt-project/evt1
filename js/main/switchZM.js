/**
 *
 * @author JK
 * @since 2012
 *
 **/

var magnifierON = false;
//var bigImage;

function magnifierReady() {
	$("#mag_image_elem").empty();
	setMagHeight();
	var img = document.getElementById("iviewerImage").cloneNode(false);
	img.removeAttribute("style");
	/*IT: calcolo nuova altezza: */
	if ($('.current_mode').attr('id') == 'imgd_link') {
		zoomImagWidth = 900;
	} else {
		zoomImagWidth = 445; /*richiamata anche in jqzoom*/
	}
	var imgWidth = parseFloat($("#iviewerImage").css('width'));
	var imgHeight = parseFloat($("#iviewerImage").css('height'));
	zoomImagHeight = (zoomImagWidth * imgHeight) / imgWidth; /*richiamata anche in jqzoom*/
	/*IT: modifico gli attibuti della nuova immagine*/
	img.setAttribute('id', 'magImage');
	/*IT: inserisco nuova immagine in #mag_image_elem */
	var hash_parts = new Array();
	hash_parts = location.hash.substr(1).split('&');
	if ( hash_parts != "" ) {
		for (var i = 0; i < hash_parts.length; i++) {
		    if(hash_parts[i].indexOf("page") === 0) { //begins with "page"
		        current_pp = hash_parts[i].substr(5);
		    	if (current_pp.indexOf('-') > 0) {
		    		current_pp = current_pp.substr(0, current_pp.indexOf('-'));
				}
		    }
		}
	} else {
		if ($('.current_mode').attr('id') == 'imgd_link'){
			current_pp = $('.main_dd_select .option_container .option:first-child').data('value');	
		} else {
			current_pp = $('.main_pp_select .option_container .option:first-child').data('value');
		}
	}

	if ($('.current_mode').attr('id') == 'imgd_link')
		imgB = "data/input_data/images/double/" + current_pp + "_big.jpg";
	else
		imgB = "data/input_data/images/single/" + current_pp + "_big.jpg";
	$("#mag_image_elem").append('<a href="' + imgB + '" class="magnifier" ></a>');
	$("#mag_image_elem > a").append(img);
	/*IT: imposto il css della nuova immagine*/
	$("#magImage").css({
		'width': zoomImagWidth + 'px',
		'height': zoomImagHeight + 'px',
		'margin-left': 'auto',
		'margin-right': 'auto'
	});
	if ($('.current_mode').attr('id') == 'imgd_link') {
		setTimeout(function() {
			magONbig();
		}, 1000);
	} else {
		setTimeout(function() {
			magON();
		}, 1000);
	}
}

function setMagHeight() {;
	left_headerHeight = $("#left_header").height();
	if ($('#left_header').hasClass('menuClosed')) {
		$("#mag_image_elem").css({
			'margin-top': '0px',
			'height': ($("#image_cont").height()) + 'px'
		});
	} else {
		$("#mag_image_elem").css({
			'margin-top': left_headerHeight + 'px',
			'height': ($("#image_cont").height()) - left_headerHeight + 'px'
		});
	}
	$('.zoomWindow').css({
		left: ($("#image_cont").width() - $(".zoomWindow").width()) / 2 + 'px'
	});
	$('.zoomPup').css({
		left: ($("#image_cont").width() - $(".zoomPup").width()) / 2 + 'px'
	});
}

function magOn() {
	if (magnifierON == false) {
	   if($('#switchMag').hasClass('likeInactive')){
	       $('#switchMag').removeAttr('onclick').removeClass('likeInactive').addClass('inactive');
	       $('#switchMag i').removeClass('fa fa-search-plus').addClass('fa fa-search');
	   }
	   else{
      		/*IT: Se il collegamento testo immagine è attivo, lo disattivo*/
      		UnInitialize(); //Add by JK for ITL
      		$('#switchITL i').removeClass('fa fa-chain').addClass('fa fa-chain-broken');
      		$('#switchITL').removeClass('active'); //Add by CDP
      		if($('#switchITL').hasClass('likeInactive')) disableITLbutton();
      
      		/*IT: Se gli HotSpot sono attivi, li disattivo*/
      		UnInitializeHS(); //Add by JK for HS
      		$('#switchHS i').removeClass('fa fa-dot-circle-o').addClass('fa fa-circle-o');
      		$('#switchHS').removeClass('active');
      		if($('#switchHS').hasClass('likeInactive')) disableHSbutton();
      
      		/*IT: rendo visibile il div del magnifier e invisibile quello dello zoom*/
      		$("#mag_image_elem").fadeIn();
      		$("#image_elem, #image_tool, #image_fade").css({
      			'display': 'none'
      		});
      		//$('#image_tool').addClass('menuClosed'); //Add by CDP per gestire la scomparsa del menu
      		$('#switchMag').addClass('active'); //Add by CDP for FA
      		$('#switchMag i').removeClass('fa fa-search').addClass('fa fa-search-plus');
      		//$('#switchITL').removeClass('inactive');//Add by CDP for FA
      		
      		magnifierON = true;
      	}
	} else {
		/*IT: rendo visibile il div dello dello zoom e invisibile quello del magnifier*/
		$("#image_elem, #image_fade").css({
			"overflow": "hidden"
		});
		$("#image_elem, #image_fade").fadeIn();
		if (!$('#image_tool').hasClass('menuClosed')) $("#image_tool").css({
			"display": "block",
			"overflow": "hidden"
		}); //Add by CDP per gestire la scomparsa del menu
		$("#mag_image_elem").fadeOut();
		$('#switchMag').removeClass('active'); //Add by CDP for FA
		$('#switchMag i').removeClass('fa fa-search-plus').addClass('fa fa-search');

		magnifierON = false;
	}
	$('#thumb_cont').css('display', 'none');
}

function disableITLbutton() {
	if($('#switchITL').hasClass('likeInactive')) $('#switchITL').removeClass('likeInactive');
	$('#switchITL').addClass('inactive'); //Add by CDP for FA
	$('#switchITL').removeAttr("onclick");
	$('#switchITL').attr('title', 'Image-Text link non disponibile');
	//$('#switchITL i').removeClass('fa-chain').addClass('fa-chain-broken'); //Add by CDP for FA
}

function enableITLbutton() {
	if($('#switchITL').hasClass('inactive')) $('#switchITL').removeClass('inactive');
	if($('#switchITL').hasClass('likeInactive')) $('#switchITL').removeClass('likeInactive');
	$('#switchITL').attr('onclick', 'switchIMT()');
	$('#switchITL').removeAttr('title').attr('title', 'Image-Text link');
}

function disableHSbutton() {
	if($('#switchHS').hasClass('likeInactive')) $('#switchHS').removeClass('likeInactive');
	$('#switchHS').addClass('inactive'); //Add by CDP for FA
	$('#switchHS').removeAttr('onclick');
	$('#switchHS').attr('title', 'Hot spot non disponibili');
	//$('#switchHS i').removeClass('fa fa-dot-circle-o').addClass('fa fa-dot-circle-o'); //Add by CDP for FA
}

function enableHSbutton() {
	if($('#switchHS').hasClass('inactive')) $('#switchHS').removeClass('inactive');
	if($('#switchHS').hasClass('likeInactive')) $('#switchHS').removeClass('likeInactive');
	$('#switchHS').attr('onclick', 'switchHS()');
	$('#switchHS').removeAttr('title').attr('title', 'Hot spot');
}

function chooseZoomMag() {
	//if ((magnifierON == true) && (bigImage == true)) 
	if (magnifierON) {
		/*IT: rendo visibile il div del magnifier e invisibile quello dello zoom*/
		$("#image_elem, #image_tool, #image_fade, #thumb_cont").css('display', 'none');
		$("#mag_image_elem").css('display', 'none').fadeIn(1000);
		$('#switchMag').removeClass('inactive').addClass('active'); //Add by CDP for FA
		//document.getElementById("#image_tool").setAttribute('style', 'display:none;');
	}
	//else if ((magnifierON == false) || ((magnifierON == true) && (bigImage == false))) {
	else{
		/*IT: rendo visibile il div dello dello zoom e invisibile quello del magnifier*/
		magnifierON == false;
		$("#mag_image_elem, #thumb_cont").css({
			"display": "none"
		});
		$("#image_elem").css({
			"display": "block",
			"overflow": "hidden"
		});
		if (!$('#image_tool').hasClass('menuClosed')) $("#image_tool").css({
			"display": "block",
			"overflow": "hidden"
		}); //Add by CDP per gestire la scomparsa del menu
	}
}

function magON() {
	var options = {
		zoomType: 'drag',
		position: 'inside',
		title: false,
		lens: false,
		preloadImages: false,
		alwaysOn: false,
		lensWidth: 30,
		lensHeight: 15,
		zoomRatio: 1
	};
	$('.magnifier').jqzoom(options);
}

function magONbig() {
	var options = {
		zoomType: 'drag',
		position: 'inside',
		title: false,
		lens: false,
		preloadImages: false,
		alwaysOn: false,
		lensWidth: 40,
		lensHeight: 20,
		zoomRatio: 1
	};
	$('.magnifier').jqzoom(options);
}