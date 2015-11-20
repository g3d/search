// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .

$(function(){
  $(document).foundation();
  jQuery.ajaxSetup({
    'beforeSend': function(xhr) {
        xhr.setRequestHeader("Accept", "text/javascript");
        var csrf_meta_tag = jQuery('meta[name="csrf-token"]');
        if (csrf_meta_tag) {
            xhr.setRequestHeader('X-CSRF-Token', csrf_meta_tag.attr('content'));
        }
    }
  });
  var search = new Drooms.Search('.js-search-input');
});

$(function(){ $(document).foundation(); });
