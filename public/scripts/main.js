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
    "Hockey stick under $30",
    "Oi Ocha Green Tea"
  ];

  var pickerTerm = exampleTerms[Math.floor(Math.random() * exampleTerms.length)];
  $("#searchbox").attr("placeholder", pickerTerm);
  $('#search-box').animo( { animation: ['fadeInUp'], duration: 0.4} );


  // Validate keyup event is alphabetic character
  // If character is valid set focus to next input box
  // $("form").delegate ("input", "keyup", function() {
  //   isSpecial(($(this).val()).toLowerCase());
  // });

})

$("#zipbox").keyup(function(event){
    if(event.keyCode == 13){
        $("#query-button").click();
    }
});

function submitQuery(form$) {

  var postData = form$.serializeArray();
  var formURL = form$.attr("action");

  $.ajax(
     {
       url : formURL,
       type: "POST",
       data : postData,
       success:function(data, textStatus, jqXHR)
       {
          console.log("success");
          // hide form
          $('#search-form').animo( { animation: ['fadeOutLeft'], duration: 0.3});
          $('#query-button').animo( { animation: ['fadeOutLeft'], duration: 0.3});

          setTimeout(function() {
            $('#search-form').hide();
            $('#query-button').hide();
          }, 300);

          $('#submitted-message').show().animo( { animation: ['bounceInUp'], duration: 1.0} );


          // show confirmation to user
       },
       error: function(jqXHR, textStatus, errorThrown)
       {
          console.log(jqXHR + textStatus + errorThrown);
       }
     });
};

function pollForPlace(zip) {
  var requestURL = "http://maps.googleapis.com/maps/api/geocode/json?address=" + zip + "&sensor=false"
  var place_name = null;

  $.ajax({
    url: requestURL,
    async: false,
    dataType: 'json',
    success: function (data) {
      try {
        place_name = data['results'][0]['address_components'][1]['long_name'];
      } catch(error) {
        place_name = "";
      }
    }
  });

  return place_name;
}


function transitionToPay() {
  $('#query-zip-section').animo( { animation: ['bounceOutLeft'], duration: 0.8});
  $('#query-button').animo( { animation: ['bounceOutLeft'], duration: 0.8});
  $('#submitted-message').text("Almost there! Our savvy search beavers charge a small $5 for their efforts.");

  setTimeout(function() {
    $('#query-zip-section').hide();
    $('#query-button').hide();
  }, 300);
  setTimeout(function() {
    $('#pay').show().animo( { animation: ['bounceInRight'], duration: 0.8} );
  }, 000);
}
