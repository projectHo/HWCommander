$(function() {
    var windowWidth = window.outerWidth;
    for(var i = 1 ; i<=20 ; i++ ){
        $(".q-" + i).removeClass("show").css("display","none");
    }
    if(windowWidth >= 576){
        setTimeout(() => {
            $(".modal-btn-col").children("button").removeClass("w-100").addClass("w-25");
            $(".modal-btn-col").children("h5").removeClass("w-100 pt-3").addClass("w-25");
            var modalBtnWidth = $(".modal-btn").width();
            var modalBtnPaddingLeft = parseFloat($(".modal-btn").css("padding-left"));
            var modalBtnPaddingRight = parseFloat($(".modal-btn").css("padding-right"));
            $(".modal-btn").height((modalBtnWidth + modalBtnPaddingLeft + modalBtnPaddingRight)/2);
        }, 200);
    }else if(windowWidth < 576){
        $(".modal-btn-col").children("button").removeClass("w-25").addClass("w-100");
        $(".modal-btn-col").children("h5").removeClass("w-75").addClass("w-100 pt-3");
    };
        
    if(windowWidth < 768){
        $("#select-date-modal-start-btn").addClass("mt-2");
        $(".side-empty").css("width","1%");
        $(".main-box").removeClass("container").css("width","98%");
        $("#sidebarToggle").attr("onclick","javascript:resizeEsBtn()");
    }else if(windowWidth >= 768){
        $(".side-empty").css("width","10%");
        $(".main-box").css("width","80%");
        $("#sidebarToggle").removeAttr("onclick","javascript:resizeEsBtn()");
        $(".modal-btn-col.new-btn").addClass("pb-2 border-bottom");
    }
    

    if(windowWidth < 1400){
        $(".question-col-3").addClass("mt-4");
    };
    if(windowWidth <= 1530  && windowWidth >= 1400){
        $(".question-col-3").children().children("p").css("font-size","14px");
    }else {
        $(".question-col-3").children().children("p").css("font-size","16px");
    }

    $(window).on("resize",function(){
        var windowWidth = window.outerWidth;
    
        if(windowWidth >= 576){
            setTimeout(() => {
                $(".modal-btn-col").children("button").removeClass("w-100").addClass("w-25");
                $(".modal-btn-col").children("h5").removeClass("w-100 pt-3").addClass("w-75");
                var modalBtnWidth = $(".modal-btn").width();
                var modalBtnPaddingLeft = parseFloat($(".modal-btn").css("padding-left"));
                var modalBtnPaddingRight = parseFloat($(".modal-btn").css("padding-right"));
                $(".modal-btn").height((modalBtnWidth + modalBtnPaddingLeft + modalBtnPaddingRight)/2);
            }, 200);
        }else if(windowWidth < 576){
            $(".modal-btn-col").children("button").removeClass("w-25").addClass("w-100");
            $(".modal-btn-col").children("h5").removeClass("w-75").addClass("w-100 pt-3");
        };

        if(windowWidth < 768){
            $("#select-date-modal-start-btn").addClass("mt-2");
            $(".side-empty").css("width","1%");
            $(".main-box").removeClass("container").css("width","98%");
            resizeEsBtn();
            $("#sidebarToggle").attr("onclick","javascript:resizeEsBtn()");
        }else if(windowWidth >= 768){
            $("#select-date-modal-start-btn").removeClass("mt-2");
            $(".side-empty").css("width","10%");
            $(".main-box").css("width","80%");
            $("#es-btn").css("display","block");
            $("#sidebarToggle").removeAttr("onclick","javascript:resizeEsBtn()");
            $(".modal-btn-col.new-btn").addClass("pb-2 border-bottom");
        }

        if(windowWidth < 1400){
            $(".question-col-3").addClass("mt-4");
        }else {
            $(".question-col-3").removeClass("mt-4");
        }

        if(windowWidth <= 1530 && windowWidth >= 1400){
            $(".question-col-3").children().children("p").css("font-size","14px");
        }else {
            $(".question-col-3").children().children("p").css("font-size","16px");
        }
    });
})