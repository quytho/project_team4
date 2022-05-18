// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree.
$(document).ready(function () {

  var date = new Date();
    
  var day = date.getDate();
  var month = date.getMonth() + 1;
  var year = date.getFullYear();
  
  if (month < 10) month = "0" + month;
  if (day < 10) day = "0" + day;
  
  var today = year + "-" + month + "-" + day;       
  
  $(document).on("click", "#datePicker", function () {
    document.getElementById("datePicker").value = today;
  });

  $(document).on("click", ".form-check-input", function () {
    $(this).val($(this).is(":checked") ? 1 : 0);
    value = document.querySelector('.form-check-input').checked;
    if(value){
      document.getElementById("datePickerReturn1").value = today;
    }
    else{
      document.getElementById("datePickerReturn1").value = "";
    }
  });


  // set value checkbox
  $(".form-check-input").change(function(){
    $(this).val($(this).is(":checked") ? 1 : 0);
  });

  // accpet borrow request book
  $(document).on("click", ".edit_accept", function () {
    var sta = $(this).data('status')
    var borrowId = $(this).data('book-id')
    $.ajax({
      method: "put",
      url: "/admin/borrow_requets/"+ borrowId ,
      data: {status:sta,update_status: "status"},
    }).fail(function (msg) {
      alert("Accept fail")
    });
  });

  //ajax follow
  $(document).on("click", ".follow-book", function () {
    var bookId = $(this).data('book-id')
    var userId = $(this).data('user-id')
    var id = "unfollow-" + bookId;
    var ids = "follow-" + bookId;
    var other_button = (document).getElementById("unfollow-" + bookId)
    var other_button1 = (document).getElementById("follow-" + bookId)
    $.ajax({
      method: "post",
      url: "/follows",
      data: {user_id:userId, book_id:bookId},
      success: function() {
        $(other_button1).addClass('hidden');
        $(other_button).removeClass('hidden');
        location.reload();  //Refresh page
      },
    }).fail(function (msg) {
      alert("Follow fail")
    });
  });

  //ajax unfollow
  $(document).on("click", ".unfollow-book", function () {
    var follow = $(this).data('id')
    var id_follow = follow.id
    var bookId = $(this).data('book-id')
    var userId = $(this).data('user-id')
    var other_button = (document).getElementById("unfollow-" + bookId)
    var other_button1 = (document).getElementById("follow-" + bookId)
    $.ajax({
      method: "delete",
      url: "/follows/" + id_follow,
      data: {id:id_follow},
      success: function() {
        $(other_button).addClass('hidden');
        $(other_button1).removeClass('hidden');
        location.reload();  //Refresh page
      },
    }).fail(function (msg) {
      alert("Unfollow fail")
    });đo
  });

  //ajax like
  $(document).on("click", ".like-book", function () {
    var bookId = $(this).data('book-id')
    var userId = $(this).data('user-id')
    var other_button = (document).getElementById("unlike-" + bookId)
    var other_button1 = (document).getElementById("like-" + bookId)
    $.ajax({
      method: "post",
      url: "/likes",
      data: {user_id:userId, book_id:bookId},
      success: function() {
        $(other_button1).addClass('hidden');
        $(other_button).removeClass('hidden');
        location.reload();  //Refresh page
      },
    }).fail(function (msg) {
      alert("unlike fail")
    });
  });

  //ajax unlike
  $(document).on("click", ".unlike-book", function () {
    var like = $(this).data('id')
    var id_like = like.id
    var bookId = $(this).data('book-id')
    var userId = $(this).data('user-id')
    var other_button = (document).getElementById("unlike-" + bookId)
    var other_button1 = (document).getElementById("like-" + bookId)
    $.ajax({
      method: "delete",
      url: "/likes/" + id_like,
      data: {id:id_like},
      success: function() {
        $(other_button).addClass('hidden');
        $(other_button1).removeClass('hidden');
        location.reload();  //Refresh page
      },
    }).fail(function (msg) {
      alert("Unlike fail")
    });
  });
});



//display star
const ratingStars = [...document.getElementsByClassName("rating__star")];
function executeRating(stars) {
  const starClassActive = "rating__star fas fa-star";
  const starClassInactive = "rating__star far fa-star";
  const starsLength = stars.length;
  let i;
  stars.map((star) => {
    star.onclick = () => {
      i = stars.indexOf(star);

      if (star.className===starClassInactive) {
        for (i; i >= 0; --i) stars[i].className = starClassActive;
      } else {
        for (i; i < starsLength; ++i) stars[i].className = starClassInactive;
      }
    };
  });
}
executeRating(ratingStars);