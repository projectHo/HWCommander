$(function() {

    // 모달 버튼 높이
    setTimeout(() => {
        var modalBtnWidth = $(".modal-btn").width();
        var modalBtnPaddingLeft = parseFloat($(".modal-btn").css("padding-left"));
        var modalBtnPaddingRight = parseFloat($(".modal-btn").css("padding-right"));
        console.log(modalBtnWidth + modalBtnPaddingLeft + modalBtnPaddingRight);
        $(".modal-btn").height(modalBtnWidth + modalBtnPaddingLeft + modalBtnPaddingRight);
    }, 200);

    
    var windowWidth = window.outerWidth;

    if(windowWidth < 768){
        $(".modal-btn-col").addClass("mt-2");
    };
    if(windowWidth < 1400){
        $(".question-col-3").addClass("mt-4");
    };
    if(windowWidth <= 1530  && windowWidth >= 1400){
        $(".question-col-3").children().children("p").css("font-size","14px");
    }else {
        $(".question-col-3").children().children("p").css("font-size","16px");
    }

    $(window).on("resize",function(){
        // 모달 버튼 높이
        setTimeout(() => {
            var modalBtnWidth = $(".modal-btn").width();
            var modalBtnPaddingLeft = parseFloat($(".modal-btn").css("padding-left"));
            var modalBtnPaddingRight = parseFloat($(".modal-btn").css("padding-right"));
            console.log(modalBtnWidth + modalBtnPaddingLeft + modalBtnPaddingRight);
            $(".modal-btn").height(modalBtnWidth + modalBtnPaddingLeft + modalBtnPaddingRight);
        }, 200);


        var windowWidth = window.outerWidth;

        if(windowWidth < 768){
            $(".modal-btn-col").addClass("mt-2");
        }else {
            $(".modal-btn-col").removeClass("mt-2");
        };

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