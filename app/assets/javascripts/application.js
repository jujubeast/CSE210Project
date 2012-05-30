// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
	$('#advanced_search').click(function(event) {
		event.preventDefault(); // Prevent link from following its href
		if ($("#advanced_search_bar").is(":visible")) {
			$("#advanced_search_bar").slideUp();
		} else {
			$.ajax({
				url : "/search/advanced",
				success : function(html) {
					$("#advanced_search_bar").html(html);
					$("#advanced_search_bar").slideDown();
				}
			});
		}
	});

	$("#friends_search input[type=checkbox]").live('click', function() {
		var friend_id = $(this).attr('id');
		if ($(this).attr('checked')) {
			alert(friend_id);
			$.ajax({
				url : "/search/get_list",
				data : {
					'friend_id' : friend_id
				},
				success : function(html) {
					$("#list_search").append(html);
				}
			})
		} else {
			remove_lists(friend_id);
		}
	});

	var remove_lists = function(friend_id) {
		$(".list_selection\\." + friend_id).remove();
	}

});