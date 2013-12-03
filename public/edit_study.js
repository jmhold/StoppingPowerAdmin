$(function() {
	
	set_draggable();

	$('#add_pair').click(function() {
		id = $('li','#pairs').length
		$('#pairs').append('<li><b>'+(id+1)+'</b> '+
		'<div id="left" class="pair_droppable">Left<img class="thumb_dropped" /></div> '+
		'<div id="right" class="pair_droppable">Right<img class="thumb_dropped" /></div> '+
		'<a href="#" role="button" class="btn btn-danger pair_delete" onClick=""><i class="icon-trash icon-white"></i></a></li>');
		set_droppable($('#left'));
		set_droppable($('#right'));
		$('#left').attr('id', '-1');
		$('#right').attr('id', '-1');
		set_deletable($('li','#pairs')[id]);
		relable_pairs();
	});
	
	$( "#slider" ).slider({
	      value: parseInt($('#slider_value').text()),
	      min: 0,
	      max: 3,
	      step: 1,
	      slide: function( event, ui ) {
			  $('#study_warm_up_pairs_field').attr('value', ui.value);
			  $('#slider_value').html(ui.value);
			  relable_pairs();
	      }
	    });
	
	$('.pair_droppable').each(function() {
		set_droppable($(this));
	});
	$('li','#pairs').each(function() {
		set_deletable($(this));
	});
	$('#pairs').sortable({
		placeholder: "ui-state-highlight pairs_placeholder",
		containment: "#study_form",
		update: function( event, ui ) {
			relable_pairs();
		}
	});
	$('#pairs').disableSelection();
	relable_pairs();
	
	$("form").submit(function() {
		return check_submit();
	});
});

function set_draggable() {
	$( "img", $('#thumb_gallery')).draggable({
      revert: true,
      containment: "document",
      helper: "clone",
      cursor: "move"
    });
}

function check_submit() {
	if($('#study_name').val().length <= 0) {
		alert("Error: Study does not have a name.");
		return false;
	}
	if(!$('#study_timer').val().match('^[0-9]*\.[0-9]*$')) {
		alert("Error: Timer value must be a number.");
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
	warmups = parseInt($('#slider_value').text());
	$('li','#pairs').each(function( index ) {
		num = index + 1 - warmups;
		if(num <= 0) {
			$('b', this).text("W" + (num+warmups));
			$(this).attr('class','warmup');
		} else {
			$('b', this).text(num);
			$(this).attr('class','');
		}
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

function set_deletable(target) {
	$('.pair_delete', target).click(function() {
		if(confirm("Are you sure you want to delete this pair?")) {
			target.remove();
			relable_pairs();
		}
	});
}