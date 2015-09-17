function selectedRow (){

  $("input[type='checkbox']").on("click", function(){

      if($(this).is(":checked")){
          $(this).parents('tr').addClass("selectionColor");
      }
      else
      {
          $(this).parents('tr').removeClass("selectionColor");
      }
  });
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



