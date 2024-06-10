<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - 견적산출</title>
<!-- Required meta tags -->
<meta charset="UTF-8">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<link rel="stylesheet" href="/resources/css/ver_02/escaSelect.css">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />

<!-- date picker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/js/bootstrap-datepicker.min.js" integrity="sha512-LsnSViqQyaXpD4mBBdRYeP6sRwJiJveh2ZIbW41EBrNmKxgr/LFZIiWT6yr+nycvhvauz8c2nYMhrP80YhG7Cw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/locales/bootstrap-datepicker.ko.min.js" integrity="sha512-L4qpL1ZotXZLLe8Oo0ZyHrj/SweV7CieswUODAAPN/tnqN3PA1P+4qPu5vIryNor6HQ5o22NujIcAZIfyVXwbQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/css/bootstrap-datepicker3.min.css" integrity="sha512-aQb0/doxDGrw/OC7drNaJQkIKFu6eSWnVMAwPN64p6sZKeJ4QCDYL42Rumw2ZtL8DB9f66q4CnLIUnAw28dEbg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/css/bootstrap-datepicker3.standalone.min.css" integrity="sha512-t+00JqxGbnKSfg/4We7ulJjd3fGJWsleNNBSXRk9/3417ojFqSmkBfAJ/3+zpTFfGNZyKxPVGwWvaRuGdtpEEA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script>
	$(function(){
		$("#base-modal").modal("show");
		sessionStorage.clear();
	})

	let index = 0;
	function typeText() {
		const inputElement = $("#typingInput");
		const text = "사용하실 로직을 선택해주세요";
		if (index < text.length) {
			inputElement.val(function(i, val) {
			return val + text.charAt(index);
			});
			index++;
			setTimeout(typeText, 50);
		}
	}
	function modalPrev(){
		$(".modal-footer").css("display","block");
		$('#datepicker-input').datepicker({
			language: 'ko',
			format: 'yyyy-mm-dd',
			startDate: '2023-03-01',
			endDate: new Date(),
			autoclose: true,
		});
	}
	function clickAnswerBtn(el){
		if($(el).children().html() == "최신 버전"){
			for(let i = 1; i<=19 ; i++){
				sessionStorage.setItem("data-" + i, "");
			}
			sessionStorage.setItem("targetData" , "");
			sessionStorage.setItem("pay","y");
			location.href = "/ESCA/ESCA_00_ver_1_0.do";	
		}else if($(el).children().html() == "이전 버전"){
			$("#select-modal").modal("show");			
		}else {
			location.href = "/";
		}
	}
	function chooseDate(){
		$("#time-chooser").removeClass("d-flex").addClass("d-none");
		$('#date-chooser').children().css("display","block");
		$('#date-chooser').datepicker({
			language: 'ko',
			format: 'yyyy-mm-dd',
			startDate: '2023-03-01',
			endDate: new Date(),
			autoclose: true,
		}).on("changeDate", function(e){
			$("#date-input").val(e.format("yyyy-mm-dd"));
			if($("#time-input").val() != ""){
				$("#date-time-result").val($("#date-input").val() + " " + $("#time-input").val());	
			}else if($("#time-input").val() == ""){
				$("#date-time-result").val($("#date-input").val() + " " + "00:00:00");	
			}
		});
	}
	
	function chooseTime(){
		$('#date-chooser').children().css("display","none");
		$("#time-chooser").removeClass("d-none").addClass("d-flex");
	}
	function changeTime(){
		$("#time-input").val($("#time-chooser").children().val());
		if($("#date-input").val() != ""){
			$("#date-time-result").val($("#date-input").val() + " " + $("#time-input").val());
		}
	}
	function checkResult(){
		if($("#date-time-result").val() == ""){
			alert("날짜를 선택해주세요!");
		}else {
			sessionStorage.setItem("targetData",$("#date-time-result").val())
			for(let i = 1; i<=19 ; i++){
				sessionStorage.setItem("data-" + i, "");
			}
			location.href = "/ESCA/ESCA_00_ver_1_0.do";
			sessionStorage.setItem("pay","n");
		}
	}
	function resetTime(){
		$("#time-chooser").children().val("00:00:00");
		chooseDate();
		chooseTime();
		changeTime();
	}

	function selectBox(el){
		$(".esca-select-boxs").removeClass("text-white").removeClass("clicked");
		$(".esca-select-boxs").find("path").attr("fill","#71767F");

		$(el).addClass("text-white").addClass("clicked");
		$(el).find("path").attr("fill","#FFFFFF");

		if($(el).attr("version") == "resent"){
			sessionStorage.clear();
			sessionStorage.setItem("version","resent");
		}else if($(el).attr("version") == "prev"){
			sessionStorage.clear();
			sessionStorage.setItem("version","prev");
		}
	}
	function escaBtn(){
		if(sessionStorage.getItem("version") == "resent"){
			for(let i = 1; i<=19 ; i++){
				sessionStorage.setItem("data-" + i, "");
			}
			sessionStorage.setItem("targetData" , "");
			sessionStorage.setItem("pay","y");
			location.href = "/ESCA/ESCA_00_ver_1_0.do";	
		}
		if(sessionStorage.getItem("version") == "prev"){
			$("#select-modal").modal("show");
		}

		sessionStorage.removeItem("version");
	}
</script>
</head>
<body>
	<%@ include file="./common/header.jsp" %>

	<div class="esca-select-container">
		<div class="container">
			<div class="esca-select-box p-5">

				<h3 class="fw-bold text-white text-center mt-3 mb-4">사용하실 버전을 선택 해주세요</h3>

				<div class="d-flex gap-5 justify-content-center align-items-center">
					<div class="esca-select-boxs d-flex flex-column gap-4 justify-content-center align-items-center py-5 px-4 text-center" onclick="javascript:selectBox(this)" version="resent">
						<div class="svg-box ms-3 mt-4">
							<svg width="117" height="125" viewBox="0 0 117 125" fill="none" xmlns="http://www.w3.org/2000/svg">
								<path fill-rule="evenodd" clip-rule="evenodd" d="M7.4248 49.0669C7.4248 46.673 9.36543 44.7324 11.7593 44.7324H45.1364C46.7357 44.7324 48.2052 45.6132 48.9591 47.0237L53.1526 54.8696L85.446 54.8696C87.8399 54.8696 89.7805 56.8102 89.7805 59.2041V85.9103C89.7805 87.1072 88.8102 88.0775 87.6132 88.0775C86.4163 88.0775 85.446 87.1072 85.446 85.9103V59.2041H53.1526C51.5532 59.2041 50.0837 58.3233 49.3298 56.9128L45.1364 49.0669H11.7593V69.6558C11.7593 70.8528 10.789 71.8231 9.59206 71.8231C8.39512 71.8231 7.4248 70.8528 7.4248 69.6558V49.0669ZM9.59206 76.1576C10.789 76.1576 11.7593 77.1279 11.7593 78.3249V107.583H85.446V94.5793C85.446 93.3823 86.4163 92.412 87.6132 92.412C88.8102 92.412 89.7805 93.3823 89.7805 94.5793V107.583C89.7805 109.977 87.8399 111.917 85.446 111.917H11.7593C9.36543 111.917 7.4248 109.977 7.4248 107.583V78.3249C7.4248 77.1279 8.39512 76.1576 9.59206 76.1576Z" fill="#71767F"/>
								<path fill-rule="evenodd" clip-rule="evenodd" d="M24.7627 81.5759C24.7627 80.379 25.733 79.4087 26.9299 79.4087H70.275C71.472 79.4087 72.4423 80.379 72.4423 81.5759V109.75C72.4423 110.947 71.472 111.918 70.275 111.918H26.9299C25.733 111.918 24.7627 110.947 24.7627 109.75V81.5759ZM29.0972 83.7432V107.583H68.1078V83.7432H29.0972Z" fill="#71767F"/>
								<path fill-rule="evenodd" clip-rule="evenodd" d="M111.54 3.81437H36.2059C35.6793 3.81437 35.2524 4.2413 35.2524 4.76796V26.284C35.2524 26.8106 35.6793 27.2375 36.2059 27.2375H62.3001C64.6396 27.2375 66.8777 28.1926 68.4964 29.8816L73.0349 34.6173C73.4214 35.0206 74.0702 35.0069 74.4392 34.5876L78.3451 30.1497C79.9744 28.2984 82.3214 27.2375 84.7875 27.2375H111.54C112.066 27.2375 112.493 26.8106 112.493 26.284V4.76796C112.493 4.2413 112.066 3.81437 111.54 3.81437ZM36.2059 0C33.5727 0 31.438 2.13469 31.438 4.76796V26.284C31.438 28.9172 33.5727 31.0519 36.2059 31.0519H62.3001C63.5998 31.0519 64.8432 31.5825 65.7425 32.5208L70.281 37.2566C72.2134 39.2729 75.4573 39.2041 77.3025 37.1076L81.2084 32.6698C82.1136 31.6413 83.4175 31.0519 84.7875 31.0519H111.54C114.173 31.0519 116.308 28.9172 116.308 26.284V4.76796C116.308 2.13469 114.173 0 111.54 0H36.2059Z" fill="#71767F"/>
								<path d="M88.5316 9.55693C89.0637 9.55693 89.6301 9.83156 89.8361 10.5868L92.0675 18.6542L94.2474 10.3122C94.4019 9.69425 94.934 9.47111 95.5005 9.59126C96.1012 9.71141 96.3759 10.192 96.2042 10.8099L93.372 20.9371C93.1661 21.6923 92.5996 21.967 92.0675 21.967C91.5354 21.967 90.969 21.6923 90.763 20.9028L88.5144 12.5092L86.1629 20.9371C85.9569 21.6923 85.3733 21.967 84.8412 21.967C84.2919 21.967 83.7255 21.6923 83.5195 20.9199L80.756 10.9129C80.5672 10.2435 80.8933 9.7629 81.5113 9.60842C82.0777 9.47111 82.6613 9.55693 82.8501 10.2778L84.9614 18.6714L87.2099 10.5868C87.4159 9.83156 87.9823 9.55693 88.5316 9.55693Z" fill="#71767F"/>
								<path d="M70.1245 9.65967H75.9777C76.4926 9.65967 76.7329 10.0716 76.7329 10.5694C76.7329 11.05 76.4926 11.4791 75.9777 11.4791H70.8454V14.7232H75.6344C76.1322 14.7232 76.3725 15.1352 76.3725 15.6158C76.3725 16.0964 76.1322 16.5084 75.6344 16.5084H70.8454V20.0443H76.0978C76.6128 20.0443 76.8531 20.4734 76.8531 20.954C76.8531 21.4518 76.6128 21.8637 76.0978 21.8637H70.1245C69.026 21.8637 68.6655 21.5204 68.6655 20.4391V11.0843C68.6655 10.003 69.026 9.65967 70.1245 9.65967Z" fill="#71767F"/>
								<path d="M62.6458 9.55713C63.1607 9.55713 63.6585 9.83176 63.6585 10.4497V20.4738C63.6585 21.5552 63.2981 21.8985 62.1995 21.8985C61.3585 21.8985 61.0323 21.7269 60.1569 20.1649L56.9128 14.3632C56.5695 13.7453 56.2949 13.1617 56.0889 12.3893V21.0746C56.0889 21.6925 55.5911 21.9672 55.0762 21.9672C54.5613 21.9672 54.0635 21.6925 54.0635 21.0746V11.0505C54.0635 9.96908 54.4239 9.62579 55.5225 9.62579C56.3635 9.62579 56.6897 9.8146 57.5651 11.3594L60.8092 17.1611C61.1525 17.779 61.4271 18.3626 61.6331 19.135V10.4497C61.6331 9.83176 62.1309 9.55713 62.6458 9.55713Z" fill="#71767F"/>
								<path fill-rule="evenodd" clip-rule="evenodd" d="M82.8503 10.2781L84.9615 18.6716L87.2101 10.587C87.4161 9.8318 87.9825 9.55716 88.5318 9.55716C89.0639 9.55716 89.6303 9.8318 89.8363 10.587L92.0677 18.6544L94.2476 10.3124C94.4021 9.69448 94.9342 9.47134 95.5006 9.59149C96.1014 9.71165 96.376 10.1923 96.2044 10.8102L93.3722 20.9373C93.1662 21.6926 92.5998 21.9672 92.0677 21.9672C91.5356 21.9672 90.9691 21.6926 90.7632 20.903L88.5146 12.5095L86.163 20.9373C85.9571 21.6926 85.3735 21.9672 84.8414 21.9672C84.2921 21.9672 83.7256 21.6926 83.5197 20.9202L80.7562 10.9132C80.5674 10.2438 80.8935 9.76314 81.5114 9.60866C82.0778 9.47134 82.6614 9.55716 82.8503 10.2781ZM80.2973 11.0426C80.2972 11.0422 80.297 11.0418 80.2969 11.0414C80.1746 10.6068 80.2068 10.1784 80.4235 9.82078C80.638 9.46655 80.9944 9.24645 81.3958 9.1461L81.3991 9.14527C81.7286 9.06539 82.1275 9.03266 82.4968 9.17775C82.8966 9.33485 83.1836 9.66912 83.3115 10.1573L83.3127 10.1618L84.9847 16.809L86.7501 10.4616C86.7502 10.4612 86.7503 10.4609 86.7504 10.4605C86.8804 9.9845 87.1351 9.62877 87.4712 9.39661C87.8016 9.1683 88.1799 9.08037 88.5318 9.08037C88.8776 9.08037 89.2517 9.16957 89.579 9.39778C89.9117 9.62974 90.1661 9.98484 90.2961 10.4609C90.296 10.4606 90.2961 10.4611 90.2961 10.4609L92.0546 16.8186L93.785 10.1968C93.7852 10.1959 93.7855 10.195 93.7857 10.1942C93.8935 9.76551 94.1454 9.43945 94.4967 9.25369C94.8378 9.07327 95.2297 9.04717 95.5968 9.1245C96.0055 9.20688 96.3531 9.42501 96.5553 9.77627C96.7556 10.1242 96.7753 10.5363 96.6638 10.9378L93.8322 21.0628C93.832 21.0633 93.8319 21.0638 93.8318 21.0642C93.7017 21.5399 93.4474 21.8948 93.1149 22.1266C92.7876 22.3548 92.4135 22.444 92.0677 22.444C91.7216 22.444 91.345 22.3546 91.0156 22.1189C90.6815 21.8799 90.4302 21.5144 90.3022 21.0249C90.3021 21.0244 90.3019 21.0239 90.3018 21.0234L88.5052 14.3171L86.623 21.0628C86.6229 21.0632 86.6228 21.0637 86.6227 21.0641C86.3492 22.0645 85.5452 22.444 84.8414 22.444C84.4894 22.444 84.1098 22.356 83.7784 22.1239C83.4418 21.8883 83.1887 21.5277 83.0596 21.0453C83.0594 21.0446 83.0592 21.0438 83.059 21.043L80.2973 11.0426Z" fill="#71767F"/>
								<path fill-rule="evenodd" clip-rule="evenodd" d="M70.1243 9.18311H75.9774C76.3789 9.18311 76.711 9.3519 76.929 9.64123C77.1338 9.91315 77.2095 10.252 77.2095 10.5696C77.2095 10.8815 77.1325 11.2179 76.9307 11.4892C76.7164 11.7775 76.3858 11.9562 75.9774 11.9562H71.322V14.2467H75.6341C76.0323 14.2467 76.3584 14.4197 76.5713 14.7034C76.7719 14.971 76.849 15.3038 76.849 15.616C76.849 15.9282 76.7719 16.2611 76.5713 16.5286C76.3584 16.8124 76.0323 16.9854 75.6341 16.9854H71.322V19.5677H76.0976C76.5059 19.5677 76.8366 19.7464 77.0509 20.0346C77.2527 20.306 77.3296 20.6424 77.3296 20.9542C77.3296 21.2718 77.254 21.6107 77.0491 21.8826C76.8312 22.172 76.499 22.3408 76.0976 22.3408H70.1243C69.5546 22.3408 69.0207 22.2588 68.6505 21.8991C68.2764 21.5356 68.1885 21.0055 68.1885 20.4393V11.0846C68.1885 10.5184 68.2764 9.98831 68.6505 9.62477C69.0207 9.2651 69.5546 9.18311 70.1243 9.18311ZM76.0976 20.0445C76.6125 20.0445 76.8528 20.4736 76.8528 20.9542C76.8528 21.452 76.6125 21.864 76.0976 21.864H70.1243C69.0257 21.864 68.6653 21.5207 68.6653 20.4393V11.0846C68.6653 10.0032 69.0257 9.6599 70.1243 9.6599H75.9774C76.4924 9.6599 76.7327 10.0719 76.7327 10.5696C76.7327 11.0502 76.4924 11.4794 75.9774 11.4794H70.8452V14.7235H75.6341C76.1319 14.7235 76.3722 15.1354 76.3722 15.616C76.3722 16.0966 76.1319 16.5086 75.6341 16.5086H70.8452V20.0445H76.0976Z" fill="#71767F"/>
								<path fill-rule="evenodd" clip-rule="evenodd" d="M59.7405 20.3978L56.5654 14.7196V21.0748C56.5654 21.5284 56.375 21.8921 56.0669 22.1301C55.7746 22.356 55.4105 22.4442 55.0759 22.4442C54.7414 22.4442 54.3772 22.356 54.0849 22.1301C53.7769 21.8921 53.5864 21.5284 53.5864 21.0748V11.0507C53.5864 10.4845 53.6744 9.95443 54.0485 9.59089C54.4186 9.23122 54.9525 9.14923 55.5222 9.14923C55.9847 9.14923 56.4094 9.20104 56.8311 9.54332C57.2064 9.84793 57.5457 10.3588 57.9796 11.1246L57.981 11.1269L61.156 16.8051V10.4499C61.156 9.99636 61.3465 9.63268 61.6546 9.39464C61.9469 9.16877 62.311 9.08057 62.6455 9.08057C62.9801 9.08057 63.3442 9.16877 63.6365 9.39464C63.9446 9.63268 64.1351 9.99636 64.1351 10.4499V20.4741C64.1351 21.0403 64.0471 21.5703 63.673 21.9339C63.3028 22.2936 62.769 22.3755 62.1993 22.3755C61.7422 22.3755 61.3157 22.33 60.892 21.9892C60.5146 21.6856 60.1747 21.1725 59.7405 20.3978ZM61.6328 19.1352C61.5017 18.6436 61.3428 18.2284 61.156 17.8322C61.0494 17.606 60.9337 17.3859 60.8089 17.1613L57.5648 11.3597C56.6894 9.81483 56.3633 9.62602 55.5222 9.62602C54.4237 9.62602 54.0632 9.96931 54.0632 11.0507V21.0748C54.0632 21.6928 54.561 21.9674 55.0759 21.9674C55.5909 21.9674 56.0887 21.6928 56.0887 21.0748V12.3895C56.2198 12.8812 56.3787 13.2964 56.5654 13.6926C56.6721 13.9188 56.7878 14.1389 56.9126 14.3635L60.1567 20.1651C61.0321 21.7271 61.3582 21.8987 62.1993 21.8987C63.2978 21.8987 63.6583 21.5555 63.6583 20.4741V10.4499C63.6583 9.832 63.1605 9.55736 62.6455 9.55736C62.1306 9.55736 61.6328 9.832 61.6328 10.4499V19.1352Z" fill="#71767F"/>
							</svg>
						</div>	
						<div class="d-flex flex-column gap-3 mb-4">
							<p class="fw-semibold fs-4 m-0">최신 버전</p>
							<div class="d-flex flex-column">
								<p class="m-0">처음 이용하시는 경우</p>
								<p class="m-0">과거 견적산출이 아닌 새로 진행하고 싶을 경우</p>
							</div>
						</div>
					</div>
					<div class="esca-select-boxs d-flex flex-column gap-4 justify-content-center align-items-center py-5 px-4 text-center" onclick="javascript:selectBox(this)" version="prev">
						<div class="svg-box ms-3 mt-4">
							<svg width="117" height="125" viewBox="0 0 117 125" fill="none" xmlns="http://www.w3.org/2000/svg">
								<path fill-rule="evenodd" clip-rule="evenodd" d="M7.4248 48.6016C7.4248 46.2077 9.36543 44.2671 11.7593 44.2671H28.4478H45.1364C46.7357 44.2671 48.2052 45.1479 48.9591 46.5584L53.1526 54.4042L85.446 54.4042C87.8399 54.4042 89.7805 56.3449 89.7805 58.7388V85.4449C89.7805 86.6419 88.8102 87.6122 87.6132 87.6122C86.4163 87.6122 85.446 86.6419 85.446 85.4449V58.7388H53.1526C51.5532 58.7388 50.0837 57.858 49.3298 56.4474L45.1364 48.6016H11.7593V69.1905C11.7593 70.3875 10.789 71.3578 9.59206 71.3578C8.39512 71.3578 7.4248 70.3875 7.4248 69.1905V48.6016ZM9.59206 75.6923C10.789 75.6923 11.7593 76.6626 11.7593 77.8595V107.117H85.446V94.1139C85.446 92.917 86.4163 91.9467 87.6132 91.9467C88.8102 91.9467 89.7805 92.917 89.7805 94.1139V107.117C89.7805 109.511 87.8399 111.452 85.446 111.452H11.7593C9.36543 111.452 7.4248 109.511 7.4248 107.117V77.8595C7.4248 76.6626 8.39512 75.6923 9.59206 75.6923Z" fill="#71767F"/>
								<path fill-rule="evenodd" clip-rule="evenodd" d="M24.7627 81.1106C24.7627 79.9137 25.733 78.9434 26.9299 78.9434H70.275C71.472 78.9434 72.4423 79.9137 72.4423 81.1106V109.285C72.4423 110.482 71.472 111.452 70.275 111.452H26.9299C25.733 111.452 24.7627 110.482 24.7627 109.285V81.1106ZM29.0972 83.2779V107.118H68.1078V83.2779H29.0972Z" fill="#71767F"/>
								<path fill-rule="evenodd" clip-rule="evenodd" d="M95.3763 10.0844C86.1929 7.16125 76.3786 12.2362 73.4555 21.4196C70.5324 30.603 75.6074 40.4173 84.7908 43.3404C93.9742 46.2635 103.788 41.1885 106.712 32.0051C107.031 31.0014 108.104 30.4468 109.107 30.7662C110.111 31.0857 110.666 32.1583 110.346 33.162C106.784 44.3528 94.8246 50.5371 83.6339 46.9751C72.4431 43.413 66.2588 31.4535 69.8208 20.2627C73.3829 9.07192 85.3424 2.88762 96.5332 6.44967C100.491 7.70954 103.828 10.0234 106.325 12.983L103.41 15.443C101.363 13.0166 98.6294 11.1198 95.3763 10.0844Z" fill="#71767F"/>
								<path fill-rule="evenodd" clip-rule="evenodd" d="M105.818 7.16357C106.871 7.16357 107.725 8.01745 107.725 9.07076V15.5344C107.725 17.3415 106.07 18.696 104.299 18.3387L98.7659 17.2228C97.7333 17.0145 97.0651 16.0087 97.2734 14.9762C97.4816 13.9437 98.4874 13.2755 99.52 13.4837L103.911 14.3693V9.07076C103.911 8.01745 104.765 7.16357 105.818 7.16357Z" fill="#71767F"/>
								<path fill-rule="evenodd" clip-rule="evenodd" d="M89.6066 19.5605C88.5533 19.5605 87.6994 20.4144 87.6994 21.4677V27.0213C87.6994 27.8672 88.0738 28.6697 88.7218 29.2132L96.0098 35.3257C96.8168 36.0026 98.0197 35.897 98.6966 35.09C99.3735 34.283 99.268 33.08 98.4609 32.4032L91.5138 26.5765V21.4677C91.5138 20.4144 90.6599 19.5605 89.6066 19.5605Z" fill="#71767F"/>
							</svg>
						</div>	
						<div class="d-flex flex-column gap-3 mb-4">
							<p class="fw-semibold fs-4 m-0">이전 버전</p>
							<div class="d-flex flex-column">
								<p class="m-0">기존에 등록된 데이터를 기준으로 산출할 경우</p>
								<p class="m-0 text-danger">* 해당 버전으로는 구매가 불가능합니다</p>
							</div>
						</div>
					</div>
				</div>

				<div class="my-5 text-center">
					<button class="btn btn-primary fw-semibold px-5 py-2" onclick="escaBtn()">선택하기</button>
				</div>

			</div>
		</div>
	</div>

	<div class="modal fade" id="base-modal" data-bs-backdrop="static" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
		  <div class="modal-content">
			<div class="modal-header justify-content-center">
			  	<h1 class="modal-title fs-5 pt-2">견적산출 사전확인</h1>
			</div>
			<div class="modal-body">
				<div class="row">
					<p>현재 적용되어있는 로직은 베타버전입니다.</p>
					<p>업데이트 마다 점점 나아진 로직으로 개편 될 예정이지만</p>
					<p>산출 결과에 정상적인 수치가 나오지 않을 수 있습니다.</p>
					<p>위 경우에는 오류가 발생했다는 경고문과 함께 견적 산출이</p>
					<p>정상적으로 표시되지 않고 구매 또한 할 수 없게 만들었습니다.</p>
					<p>그 외 산출 결과에는 문제가 없으니 참고하여 이용해주시면 감사하겠습니다.</p>
				</div>
			</div>
			<div class="modal-footer justify-content-between">
				<div class="row w-100">
					<div class="col-md text-end">
						<button class="btn btn-primary w-50" data-bs-dismiss="modal">시작하기</button>
					</div>
				</div>
			</div>
		  </div>
		</div>
	</div>


	<div class="modal fade" id="select-modal" data-bs-backdrop="static" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
		  <div class="modal-content">
			<div class="modal-header justify-content-center">
			  <h1 class="modal-title fs-5 pt-2">과거견적 조회하기</h1>
			  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body pt-0">
				<div class="row">
					<div class="col-md">
						<p><div class="btn btn-primary" onclick="javascript:chooseDate()">날짜선택</div></p>
						<p><input type="text" class="form-control bg-light" disabled id="date-input" onclick="javascript:chooseDate()"></input></p>
						<p><div class="btn btn-primary" onclick="javascript:chooseTime()">시간선택</div></p>
						<p><input type="text" class="form-control bg-light" id="time-input" disabled></p>
						<small class="fz-6">시간 미선택시 00:00:00으로 입력됩니다</small>
					</div>
					<div class="col-md">
						<div id="date-chooser"></div>
						<div class="mt-2 p-2 pb-0 d-none" id="time-chooser">
							<input type="time" value="13:33:31" step="1" onchange="javascript:changeTime()">
							<div id="time-refresher" class="ps-4" onclick="javascript:resetTime()">
								<svg width="32px" height="32px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round" stroke="#CCCCCC" stroke-width="1.6799999999999997"> <path opacity="0.5" d="M3.46447 3.46447C2 4.92893 2 7.28595 2 12C2 16.714 2 19.0711 3.46447 20.5355C4.92893 22 7.28595 22 12 22C16.714 22 19.0711 22 20.5355 20.5355C22 19.0711 22 16.714 22 12C22 7.28595 22 4.92893 20.5355 3.46447C19.0711 2 16.714 2 12 2C7.28595 2 4.92893 2 3.46447 3.46447Z" fill="#1C274C"></path> <path d="M12.0096 5.25C8.62406 5.25 5.83333 7.79988 5.46058 11.0833H5.00002C4.69658 11.0833 4.42304 11.2662 4.30701 11.5466C4.19099 11.8269 4.25534 12.1496 4.47005 12.364L5.63832 13.5307C5.93113 13.8231 6.40544 13.8231 6.69825 13.5307L7.86651 12.364C8.08122 12.1496 8.14558 11.8269 8.02955 11.5466C7.91353 11.2662 7.63998 11.0833 7.33654 11.0833H6.97332C7.33642 8.63219 9.45215 6.75 12.0096 6.75C13.541 6.75 14.9136 7.42409 15.8479 8.49347C16.1204 8.80539 16.5942 8.83733 16.9061 8.56479C17.2181 8.29226 17.25 7.81846 16.9775 7.50653C15.7702 6.12471 13.9916 5.25 12.0096 5.25Z" fill="#1C274C"></path> <path d="M18.3618 10.4693C18.069 10.1769 17.5947 10.1769 17.3018 10.4693L16.1336 11.636C15.9189 11.8504 15.8545 12.1731 15.9705 12.4534C16.0866 12.7338 16.3601 12.9167 16.6636 12.9167H17.0268C16.6637 15.3678 14.548 17.25 11.9905 17.25C10.4591 17.25 9.08654 16.5759 8.15222 15.5065C7.87968 15.1946 7.40589 15.1627 7.09396 15.4352C6.78203 15.7077 6.7501 16.1815 7.02263 16.4935C8.22995 17.8753 10.0085 18.75 11.9905 18.75C15.376 18.75 18.1668 16.2001 18.5395 12.9167H19.0001C19.3035 12.9167 19.5771 12.7338 19.6931 12.4534C19.8091 12.1731 19.7448 11.8504 19.53 11.636L18.3618 10.4693Z" fill="#1C274C"></path> </g><g id="SVGRepo_iconCarrier"> <path opacity="0.5" d="M3.46447 3.46447C2 4.92893 2 7.28595 2 12C2 16.714 2 19.0711 3.46447 20.5355C4.92893 22 7.28595 22 12 22C16.714 22 19.0711 22 20.5355 20.5355C22 19.0711 22 16.714 22 12C22 7.28595 22 4.92893 20.5355 3.46447C19.0711 2 16.714 2 12 2C7.28595 2 4.92893 2 3.46447 3.46447Z" fill="#1C274C"></path> <path d="M12.0096 5.25C8.62406 5.25 5.83333 7.79988 5.46058 11.0833H5.00002C4.69658 11.0833 4.42304 11.2662 4.30701 11.5466C4.19099 11.8269 4.25534 12.1496 4.47005 12.364L5.63832 13.5307C5.93113 13.8231 6.40544 13.8231 6.69825 13.5307L7.86651 12.364C8.08122 12.1496 8.14558 11.8269 8.02955 11.5466C7.91353 11.2662 7.63998 11.0833 7.33654 11.0833H6.97332C7.33642 8.63219 9.45215 6.75 12.0096 6.75C13.541 6.75 14.9136 7.42409 15.8479 8.49347C16.1204 8.80539 16.5942 8.83733 16.9061 8.56479C17.2181 8.29226 17.25 7.81846 16.9775 7.50653C15.7702 6.12471 13.9916 5.25 12.0096 5.25Z" fill="#1C274C"></path> <path d="M18.3618 10.4693C18.069 10.1769 17.5947 10.1769 17.3018 10.4693L16.1336 11.636C15.9189 11.8504 15.8545 12.1731 15.9705 12.4534C16.0866 12.7338 16.3601 12.9167 16.6636 12.9167H17.0268C16.6637 15.3678 14.548 17.25 11.9905 17.25C10.4591 17.25 9.08654 16.5759 8.15222 15.5065C7.87968 15.1946 7.40589 15.1627 7.09396 15.4352C6.78203 15.7077 6.7501 16.1815 7.02263 16.4935C8.22995 17.8753 10.0085 18.75 11.9905 18.75C15.376 18.75 18.1668 16.2001 18.5395 12.9167H19.0001C19.3035 12.9167 19.5771 12.7338 19.6931 12.4534C19.8091 12.1731 19.7448 11.8504 19.53 11.636L18.3618 10.4693Z" fill="#1C274C"></path> </g></svg>
							</div>
						</div>
						
					</div>
				</div>
			</div>
			<div class="modal-footer justify-content-between">
				<div class="row w-100">
					<div class="col-md-6 ps-0">
						<input type="text" class="form-control bg-light" id="date-time-result" disabled>
					</div>
					<div class="col-md text-end">
						<button class="btn btn-primary w-50" onclick="javascript:checkResult()">시작하기</button>
					</div>
				</div>
			</div>
		  </div>
		</div>
	</div>
	
	<%@ include file="./common/footer.jsp" %>
</body>
<style>
	html {
		background-color: black;
	}
</style>
</html>
