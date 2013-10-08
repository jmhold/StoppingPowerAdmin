$(function() {
	$( "img", $('#thumb_gallery')).draggable({
      revert: true,
      containment: "document",
      helper: "clone",
      cursor: "move"
    });

	$('#add_pair').click(function() {
		id = $('li','#pairs').length
		$('#pairs').append('<li class="ui-state-default"><b>'+(id+1)+'</b>'+
		'<div id="left" class="pair_droppable">Left<img class="thumb_dropped" /></div>'+
		'<div id="right" class="pair_droppable">Right<img class="thumb_dropped" /></div></li>');
		set_droppable($('#left'));
		set_droppable($('#right'));
		$('#left').attr('id', '-1')
		$('#right').attr('id', '-1')
	});
	
	$('.pair_droppable').each(function() {
		set_droppable($(this))
	});
	$('#pairs').sortable({
		placeholder: "ui-state-highlight pairs_placeholder",
		containment: "#study_form",
		update: function( event, ui ) {
			relable_pairs();
		}
	});
	$('#pairs').disableSelection();
	
	$("form").submit(function() {
		return check_submit();
	});
});

function check_submit() {
	if($('#study_name').val().length <= 0) {
		alert("Error: Study does not have a name.");
		return false;
	}
	
	pairs = []
	blank_image = false
	$('li','#pairs').each(function( index ) {
		ids = []
		$('.pair_droppable', this).each(function() {
			id = $(this).attr('id');
			if(id == -1) {
				blank_image = true;
			} else {
				ids.push(id)
			}
		});
		pairs.push(ids);
	});
	
	if(blank_image) {
		alert("Error: One or more pairs contain blank images.");
		return false;
	}
	
	$('#study_pairs_field').attr('value', JSON.stringify(pairs))
    return true;
}

function relable_pairs() {
	$('li b','#pairs').each(function( index ) {
		$(this).text(index+1);
	});
}

function set_droppable(target) {
	target.droppable({
      accept: "#thumb_gallery > div > img",
      activeClass: "ui-state-highlight",
      drop: function( event, ui ) {
			$('img', this).attr('src', ui.draggable.attr('src'))
			$(this).attr('id', ui.draggable.attr('id'))
      }
    });
}