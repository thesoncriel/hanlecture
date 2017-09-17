$(document).ready(function(){	
    $("body").append("<div class='ui-loader-background'> </div>");
    
    $("*[type='submit']").submit(function () {    	
    	$.mobile.loading("show", {
			text: "잠시만 기다려주세요",
			textVisible: true,
			theme: "z"
		});
    });
    
    $("*[type='submit']").click(function () {
    	$.mobile.loading("show", {
			text: "잠시만 기다려주세요",
			textVisible: true,
			theme: "z"
		});
    });
});