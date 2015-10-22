function selectedRow (param){
  var param_parent = $(param);
  var checkbox = param_parent.find('input.collection_selection')
  param_parent.toggleClass("selected");

  if (param_parent.hasClass("selected") )
  { checkbox.prop('checked','checked'); }
  else
  { checkbox.prop('checked',null); }
}

function showSearchForm(){
  $(".search_form form").show();
  $(".search_form a#show").hide();
  $(".search_form a#hide").show();
}

function  hideSearchForm(){
  $(".search_form form").hide();
  $(".search_form a#show").show();
  $(".search_form a#hide").hide();
}




