var pairs = []

$(function() {
	$( "img", $('#thumb_gallery')).draggable({
      revert: true,
      containment: "document",
      helper: "clone",
      cursor: "move"
    });

	$('#add_pair').click(function() {
		id = pairs.length
		$('#pairs').append('<tr><td><b>'+(id+1)+'</b><div id="l'+ id + '" class="pair_droppable">Left<img class="thumb_dropped" /></div>'+
		'<div id="r'+ id +'" class="pair_droppable">Right<img class="thumb_dropped" /></div></td></tr>')
		set_droppable($('#l'+id));
		set_droppable($('#r'+id));
		pairs.push([-1,-1])
	});
	
	pairs_json = $('#study_pairs_field').attr('value')
	pairs = (JSON && JSON.parse(pairs_json)) || $.parseJSON(pairs_json);
	
	$('.pair_droppable').each(function() {
		set_droppable($(this))
	});
	
	$("form").submit(function() {
		if($('#study_name').val().length <= 0) {
			alert("Error: Study does not have a name.");
			return false;
		}
		
		unset_pair = false
		for(var i=0; i< pairs.length; i++) {
			pair = pairs[i]
			for(var j=0; j<pair.length; j++) {
				if(pair[j] == -1) {
					unset_pair = true
				}
			}
		}
		if(unset_pair) {
			alert("Error: One or more pairs contain blank images.");
			return false;
		}
       return true;
	});
});

function set_droppable(target) {
	target.droppable({
      accept: "#thumb_gallery > img",
      activeClass: "ui-state-highlight",
      drop: function( event, ui ) {
			$('img', this).attr('src', ui.draggable.attr('src'))
			id = $(this).attr('id')
			index = id.substring(1, id.length);
			image_index = id.substring(0,1) == 'l' ? 0 : 1;
			pairs[index][image_index] = ui.draggable.attr('title')
			$('#study_pairs_field').attr('value', JSON.stringify(pairs))
      }
    });
}