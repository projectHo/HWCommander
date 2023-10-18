$(function() {
    var windowWidth = window.outerWidth;
    if(windowWidth >= 320 && windowWidth < 1024){
        $("#mainMenuMobile").css("display","block");
        $("#mainMenu").css("display","none");
    }else if(windowWidth >= 1024){
        $("#mainMenu").css("display","block");
        $("#mainMenuMobile").css("display","none");
    };
    if(windowWidth >= 320 && windowWidth < 768){
        $(".bordered-li").removeClass("border-end");
    }else {
        $(".bordered-li").addClass("border-end");
    }
        
    $(window).on("resize",function(){
        var windowWidth = window.outerWidth;
        if(windowWidth >= 320 && windowWidth < 1024){
            $("#mainMenuMobile").css("display","block");
            $("#mainMenu").css("display","none");
        }else if(windowWidth >= 1024){
            $("#mainMenu").css("display","block");
            $("#mainMenuMobile").css("display","none");
        };
        if(windowWidth >= 320 && windowWidth < 768){
            $(".bordered-li").removeClass("border-end");
        }else {
            $(".bordered-li").addClass("border-end");
        }
    });
})