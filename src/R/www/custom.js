$(document).on("ready", function(){

	var payoffEls = $(".payoff");

	var charts = {
		fundedRatio: $("#assetliabilityPlot"),
		annualPayment: $("#flowsPlot"),
		fundingPeriod: $("#amortPlot")
	};

	$(payoffEls).slideUp();
	$(charts.fundingPeriod).hide();

	$("#amortization").on("click", function(){
		$(this).addClass("btn-active");
		$("#funding").removeClass("btn-active");
		$(payoffEls).slideDown();

		$(charts.fundedRatio).hide();
		$(charts.annualPayment).hide();
		$(charts.fundingPeriod).show();
	});


	$("#funding").on("click", function(){
		$(this).addClass("btn-active");
		$("#amortization").removeClass("btn-active");
		$(payoffEls).slideUp();

		$(charts.fundedRatio).show();
		$(charts.annualPayment).show();
		$(charts.fundingPeriod).hide();
	});



})