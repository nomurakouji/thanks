
$(function() {
	setTimeout(function(){
        //0.5秒後に1.6秒かけてフェードイン!
		$('.start p').fadeIn(1600);
	},500); 
	setTimeout(function(){
        //2.5秒後に0.5秒かけてロゴ含め真っ白背景をフェードアウト！
		$('.start').fadeOut(500);
	},2500); 
});