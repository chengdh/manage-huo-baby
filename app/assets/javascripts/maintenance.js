var cloudMoved = false;
var cloud2Moved = false;
var cloud3Moved = false;
var WAVE_TIME = 6000;

$(init);

function init() {
	cloudMove();
	cloud2Move();
	cloud3Move();
	waves2Out();
	waves3Out();
}

function cloudMove() {
	if (!cloudMoved) {
		$("#cloud").css("left", $("#cloud").offset().left)
	}

	$("#cloud").animate({
		left: $("#sky").width()
	},
	cloudMoved ? 180000: 150000, "linear", function() {
		$(this).css("left", - parseInt($(this).css("width")))

		cloudMoved = true;

		cloudMove();
	})
}

function cloud2Move() {
	if (!cloud2Moved) {
		$("#cloud2").css("left", $("#cloud2").offset().left)
	}

	$("#cloud2").animate({
		left: $("#sky").width()
	},
	cloud2Moved ? 120000: 60000, "linear", function() {
		$(this).css("left", - parseInt($(this).css("width")))

		cloud2Moved = true;

		cloud2Move();
	})
}

function cloud3Move() {
	if (!cloud3Moved) {
		$("#cloud3").css("left", $("#cloud3").offset().left)
	}

	$("#cloud3").animate({
		left: $("#sky").width()
	},
	cloud3Moved ? 400000: 150000, "linear", function() {
		$(this).css("left", - parseInt($(this).css("width")))

		cloud3Moved = true;

		cloud3Move();
	})
}

function waves2Out() {
	var pause = 2000;
	var wavesTop = parseInt($("#waves2").css("top"));

	$("#waves2").animate({
		top: 0
	},
	WAVE_TIME, function() {
		wavesIn();
	})

	function wavesIn() {
		$("#waves2").animate({
			top: wavesTop
		},
		WAVE_TIME - pause, function() {
			setTimeout(waves2Out, pause);
		})
	}
}

function waves3Out() {
	var wavesTop = parseInt($("#waves3").css("top"));

	$("#waves3").animate({
		top: 5
	},
	WAVE_TIME, wavesIn)

	function wavesIn() {
		$("#waves3").animate({
			top: wavesTop
		},
		WAVE_TIME, waves3Out)
	}
}

