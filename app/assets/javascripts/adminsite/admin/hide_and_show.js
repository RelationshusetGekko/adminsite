function selectedRow (param){
  var param_parent = param;
  if( param_parent.className == "selectionColor"  ){
    param_parent.classList.remove("selectionColor");
  }
  else
  {
    param_parent.classList.add("selectionColor");
  }
};

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




//$(document).ready(function () {



