$(document).ready(function() {

  specialQueries = {
    "feynman" : "Always go with the chocolate ice cream.",
    "big data" : "Give man Hadoop cluster he gain insight for a day. Teach man build Hadoop cluster he soon leave for better job — @BigDataBorat",
    "dieter rams" : "Good design is as little design as possible.",
    "moonshot" : "♥",
    "quail" : "I don't even know what a quail looks like",
    "doge" : "wow. such search.",
    "42" : "A clever one you are!",
    "hacker news": "Only the finest source of technology awesomeness and asshatery.",
    "science": "Well, dont't be too specific...",
    "answer": "42",
    "neo": "Blue or red pill?",
    "awesome": "I know what you are but what am I?",
    "map reduce": "Ain't no party like a map reduce party.",
    "ted": "Good name.",
    "bayes": "Is this Bayesian? You know I'm a strict Bayesian, right?",
    "statistics": "An exhaustive peer-reviewed study has revealed 62.381527% of all statistics are made up on the spot.",
    "john connors": "The machines rose from the ashes of the nuclear fire.",
    "euclid": "function gcd(a, b) { return b ? gcd(b, a % b) : a; }",
    "singularity": "Technology has been a double-edged sword since fire kept us warm but burned down our villages - Kurzweil."
  };

  // Terms used for search placeholder
  exampleTerms = [
    "Glow sticks",
    "Lederhosen",
    "Chopped wood",
    "Earbuds for running under $50",
    "Power Cable for my 2012 Macbook Air",
    "Hockey stick under $30"
  ];

  var pickerTerm = exampleTerms[Math.floor(Math.random() * exampleTerms.length)];
  $("#searchbox").attr("placeholder", pickerTerm);
  $('#search-box').animo( { animation: ['fadeInUp'], duration: 0.4} );


  // Validate keyup event is alphabetic character
  // If character is valid set focus to next input box
  $("form").delegate ("input", "keyup", function() {
    isSpecial(($(this).val()).toLowerCase());
  });

})

$("#searchbox").on('focus blur', function(){
  $("#bottominfo-box").toggleClass("focus-border");
  console.log('hi');
})

$('input:checkbox').live('change', function(){
    if($(this).is(':checked')){
      $(".zip").show();
      $("#zipbox").focus();
      $("#zipbox").css('border-left-width', "1px");

      $.get("http://ipinfo.io", function(response) {
          console.log(response.city, response.country);
      }, "jsonp");
    } else {
      $(".zip").hide();
      $("#zipbox").css('border-left-width', "0px");
      //$(".zip").css('margin-right', "0px");
    }
});

function transitionToEmail() {
  $('#query-zip-section').animo( { animation: ['bounceOutLeft'], duration: 0.8});
  setTimeout(function() {
    $('#query-zip-section').hide();
  }, 300);
  setTimeout(function() {
    $('#email-section').show().animo( { animation: ['bounceInRight'], duration: 0.4} );
  }, 300);
}
