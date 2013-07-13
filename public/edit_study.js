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
		pairs.push([0,0])
	});
	
	pairs_json = $('#study_pairs_field').attr('value')
	pairs = (JSON && JSON.parse(pairs_json)) || $.parseJSON(pairs_json);
	
	$('.pair_droppable').each(function() {
		set_droppable($(this))
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