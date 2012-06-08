
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
//= require bootstrap
//= require bootstrap-modal
//= require bootstrap-dropdown

//The click toggle for requesting advanced search partial
var display_advanced_search_bar = '#advanced_search_icon';

// The div which contains the advanced search section
var advanced_search_div = '#advanced_search_bar';

$(document).ready(
		function() {

			$('#tag_value').live('keypress', function(event) {
				if (event.which == 13) {
					event.preventDefault();
					$.ajax({
						url : "/search/approve_tag",
						success : function(html) {
							$('#approved_tags').append(html);
						}
					});
				}
			});

			$(display_advanced_search_bar).click(
					function(event) {
						event.preventDefault(); // Prevent link from following
						// its href

						if ($(advanced_search_div).hasClass('hidden')) {
							$.ajax({
								url : "/search/advanced",
								success : function(html) {
									$(advanced_search_div).html(html);
									$(advanced_search_div).slideDown();
									$(advanced_search_div)
											.removeClass('hidden');
									$(display_advanced_search_bar + " img")
											.attr('src',
													'/assets/navigate_up.png');
								}
							});
						} else {
							hide_div($(advanced_search_div));
							$(display_advanced_search_bar + " img").attr('src',
									'/assets/navigate_down.png');
						}

					});
			
			$(".search_box :checkbox").live('click', function(event){
				if($(this).is(":checked")){
					$(this).parent().addClass("highlight");
				}else{
					$(this).parent().removeClass("highlight");
				}
			});

			$("#friends_search .search_box input[type=checkbox]").live('click',
					function() {
						var friend_id = $(this).attr('id');
						if ($(this).attr('checked')) {
							$.ajax({
								url : "/search/get_list",
								data : {
									'friend_id' : friend_id
								},
								success : function(html) {
									$("#list_search .search_box").append(html);
								}
							})
						} else {
							remove_lists(friend_id);
						}
					});

			var hide_div = function(div) {
				div.slideUp().addClass('hidden');
			};

			var remove_lists = function(friend_id) {
				var friend = friend_id.split('.');
				$(".list_selection\\." + friend[0] + '\\.' + friend[1])
						.remove();
			};

			$('.add_to_list').live('click', function() {
				var classes = $(this).attr('class').split(" ");
				var store_id = classes[1].split(".")[1];
				var list_id = classes[2].split(".")[1];
				$.ajax({
					url : "/showpossiblelists",
					data : {
						'store_id' : store_id,
						'list_id' : list_id
					},
					success : function(html) {
						$('#modal_div-'+store_id).append(html);
						$('#modal-'+store_id).modal('show');
					}
				});
			});
			
			$('.remove_from_list').live('click', function() {
				var classes = $(this).attr('class').split(" ");
				var store_id = classes[1].split(".")[1];
				$.ajax({
					url : "/showcurrlists",
					data : {
						'store_id' : store_id
					},
					success : function(html) {
						$('#modal_div-'+store_id).append(html);
						$('#show_curr_list_modal-'+store_id).modal('show');
					}
				});
			});
			
			$("#create_list").click(function(event){
				$.ajax({
					url: "/createlist",
					success : function(html) {
						$("#modal_div_create_lists").append(html);
						$('#modal_create_list').modal('show');
					}
				});	
			});
		});