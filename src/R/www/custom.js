$(document).on("ready", function(){

	var payoffEls = $(".payoff");

	$(payoffEls).slideUp();

	$("#amortization").on("click", function(){
		$(payoffEls).slideUp();
	});


	$("#funding").on("click", function(){
		$(payoffEls).slideDown();
	});



})