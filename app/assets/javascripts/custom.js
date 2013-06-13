$(function () {
	$('.tip').each(	function( index ) {
	  $(this).tooltip({
		'placement':'right'
		});
	});
});

function show_publish_modal(study, id) {
	$('#study_modal_title').text("Publish '" + study + "'?")
	$('#study_modal_link').attr('href', replace_id($('#study_modal_link').attr('href'), id))
	$('#study_modal').modal('show')
}

function show_delete_modal(study, id) {
	$('#delete_modal_title').text("Delete '" + study + "'?")
	$('#delete_modal_link').attr('href', replace_id($('#delete_modal_link').attr('href'), id))
	$('#delete_modal').modal('show')
}

function replace_id(text, new_id) {
	return text.replace(/(\d+)/g, new_id);
};