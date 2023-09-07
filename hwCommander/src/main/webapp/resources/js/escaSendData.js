function sendAllData(){
    let index1 = 0;
    let index2 = 0;
    let index3 = 0;
    let answer0 = new Map();
    answer0.set("OS",sessionStorage.getItem("data-0"));
    let answer1 = new Map();
    answer1.set("Price",Number(sessionStorage.getItem("data-1")) * 10000);
    let answer2 = new Map();
    let answer2s = "";
    let twoDatas = JSON.parse(sessionStorage.getItem("data-2"));
    for(let i = 0 ; i < twoDatas.length; i++){
        answer2.set(twoDatas[i][0],twoDatas[i][1])
    }
    for(var [key,value] of answer2){
        let totalKey = answer2.size;
        answer2s += key + "," + value;
        index1++;
        if (index1 !== totalKey) {
            answer2s += ":";
        }
    }
    let answer3 = new Map();
    if(sessionStorage.getItem("data-3") !== ""){
        let threeDatas = JSON.parse(sessionStorage.getItem("data-3"));
        answer3.set("Fever", threeDatas[0]);
        answer3.set("Meterial", threeDatas[1]);
        answer3.set("AS", threeDatas[2]);
        answer3.set("Noise", threeDatas[3]);
        answer3.set("Stability", threeDatas[4]);
        answer3.set("QC", threeDatas[5]);
    }else {
        answer3.set("Fever", "null");
        answer3.set("Meterial", "null");
        answer3.set("AS", "null");
        answer3.set("Noise", "null");
        answer3.set("Stability", "null");
        answer3.set("QC", "null");
    }
    let answer3s = "";
    for(var [key,value] of answer3){
        let totalKey = answer3.size;
        answer3s += key + "," + value;
        index2++;
        if (index2 !== totalKey) {
            answer3s += ":";
        }
    }
    let answer4 = new Map();
    answer4.set("Wireless",sessionStorage.getItem("data-4"));
    let answer5 = new Map();
    answer5.set("CPU",sessionStorage.getItem("data-5"));
    let answer6 = new Map();
    answer6.set("GPU",sessionStorage.getItem("data-6"));
    let answer7 = new Map();
    answer7.set("Aio",sessionStorage.getItem("data-7"));
    let answer8 = new Map();
    if(sessionStorage.getItem("data-8") !== ""){
        let eightDatas = JSON.parse(sessionStorage.getItem("data-8"));
        answer8.set("main-color", eightDatas[0]);
        answer8.set("sub-color", eightDatas[1]);
    }else if (sessionStorage.getItem("data-8") === ""){
        answer8.set("main-color", "null");
        answer8.set("sub-color", "null");
    }
    let answer8s = "";
    for(var [key,value] of answer8){
        let totalKey = answer8.size;
        answer8s += key + "," + value;
        index3++;
        if (index3 !== totalKey) {
            answer8s += ":";
        }
    }
    let answer9 = new Map();
    answer9.set("RAM",sessionStorage.getItem("data-9"));
    let answer10 = new Map();
    answer10.set("Bulk",sessionStorage.getItem("data-10"));
    let answer11 = new Map();
    answer11.set("Ssd",sessionStorage.getItem("data-11"));
    let answer12 = new Map();
    answer12.set("Metarial",sessionStorage.getItem("data-12"));
    let answer13 = new Map();
    if(sessionStorage.getItem("data-13") !== ""){
        const thirteenDatas = JSON.parse(sessionStorage.getItem("data-13"));
        answer13.set("HDD",thirteenDatas[0] + ":" + thirteenDatas[1]);
    }else {
        answer13.set("HDD","");
    }
    let answer14 = new Map();
    answer14.set("Fan",sessionStorage.getItem("data-14"));
    let answer15 = new Map();
    answer15.set("LED",sessionStorage.getItem("data-15"));
    let answer16 = new Map();let answer17 = new Map();let answer18 = new Map();let answer19 = new Map();
    
    
    for(let i = 16; i <=19 ; i++){
        if(sessionStorage.getItem("data-" + i) !== ""){
            var answerName = "answer" + i;
            var answer = eval(answerName);
            answer.set(sessionStorage.getItem("data-" + i),"");
        }else if (sessionStorage.getItem("data-" + i) === ""){
            var answerName = "answer" + i;
            var answer = eval(answerName);
            answer.set("null","null");
        }
    }
    var urlParams = "";

    for (var i = 1; i <= 19; i++) {
        var mapName = "answer" + i;
        var map = eval(mapName);
        if(i === 2){
            urlParams += mapName + "<" + answer2s + ">";
        }else if(i===3){
            urlParams += mapName + "<" + answer3s + ">";
        }else if (i ===8){
            urlParams += mapName + "<" + answer8s + ">";
        }else {
            for (var [key, value] of map) {
                if(key === "" || !key){
                    key = "null";
                    value = "null";
                }else if(key !== "" && value === ""){
                    value = "null";
                }
                
                urlParams += mapName + "<" + key + "," + value + ">";
                
            }
        }
        urlParams += "|";
    }
    var Pattern = /\((.*?)\)/;
    var userInfoMatch = Pattern.exec(loginUser);
    var userInfoValues = userInfoMatch[1];

    var userInfoArray = userInfoValues.split(", ");
    var userInfoObject = {};
    for (var i = 0; i < userInfoArray.length; i++) {
        var keyValue = userInfoArray[i].split("=");
        var key = keyValue[0];
        var value = keyValue[1];
        userInfoObject[key] = value;
    }
    urlParams += "etc<userId," + userInfoObject.id + ">|etc<targetDate,null>" + "|answer0<" + Array.from(answer0.keys()) + "," + Array.from(answer0.values()) + ">";
    var baseUrl = "/estimateCalculationResult.do";
    var fullUrl = baseUrl + "?" + urlParams;
    location.href = baseUrl + "?resultString=" + encodeURIComponent(urlParams);
}