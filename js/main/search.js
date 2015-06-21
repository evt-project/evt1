// [JACOPO] Search startup
$(function() {
	var URI = 'data/output_data';
	var jsonLocation = URI + '/' + "diplomatic" + '/' + 'diplomatic' + '.json';
	console.log(jsonLocation);
	triggerTipueSearch(jsonLocation);
	// $("#span_ee_select .label_selected").on('change', function(){
 //        jsonLocation = URI + '/'+$(this).text().toLowerCase()+'/' + $(this).text().toLowerCase() + '.json';
	// 	console.log(jsonLocation);
	// 	triggerTipueSearch(jsonLocation);
	// });
    var ee_label = document.getElementById("span_ee_select").children[0].children[0];

    ee_label.addEventListener("DOMAttrModified", function(e) {
        updateTipueSearchLocation(e.newValue.toLowerCase());
    }, false);
    
    function updateTipueSearchLocation(newLocation){
        jsonLocation = URI + '/'+newLocation+'/' + newLocation + '.json';
        console.log(jsonLocation);
        
        triggerTipueSearch(jsonLocation);
    }

	function triggerTipueSearch(jsonLocation) {
		$('#tipue_search_input').tipuesearch({
			'showURL' : false,
			'mode' : 'json',
			'contentLocation' : jsonLocation
		});
	}
	
	// "Tastiera" per la ricerca
	// Inizio tastiera virtuale
	var queryInput = document.getElementById("tipue_search_input");
    var search_box = document.getElementById("search_cont");
    var keyboard = document.createElement('div');
    keyboard.setAttribute('id', 'keyboard');
    keyboard.style.display = "none";

    // var keyboard = document.getElementById("keyboard");
    // queryInput.onfocus = function () {
    //     keyboard.style.display = "block";
    // };
    
    // Lista caratteri
    var key_list = ['Æ','æ','Ð','ð','Ᵹ','ᵹ','ſ','Þ','þ','Ƿ','ƿ'];

    // Tasti
    var keys = document.createDocumentFragment();
    for (var i in key_list) {
        var button = document.createElement('span');
        button.setAttribute('class','key');
        button.appendChild(document.createTextNode(key_list[i]));
        button.onclick = makeOnClick(queryInput, key_list[i]);
        keys.appendChild(button);
    }

    // Backspace
    var backspace = document.createElement('span');
    backspace.setAttribute('class','key');
    backspace.appendChild(document.createTextNode('<-'));
    backspace.onclick = function() {
        queryInput.value = queryInput.value.slice(0, queryInput.value.length - 1);
        queryInput.focus();
        $('#tipue_search_input').keyup();
    }
    keys.appendChild(backspace);
    keyboard.appendChild(keys);
    
    search_box.appendChild(keyboard);
    // Gestione onclick
    function makeOnClick(field, x) {
        return function() {
            field.value += x;
            field.focus();
            $('#tipue_search_input').keyup();
        };
    }
    /* Disabilito pulsante TASTIERA VIRTUALE nella ricerca se non presente */
    if ( document.getElementsByClassName('key').length == 0 ) {
        document.getElementById('keyboard_link').className += " " + "inactive"
    }
    // Fine tastiera virtuale
	
});