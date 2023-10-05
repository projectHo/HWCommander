<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - 견적산출</title>
<!-- Required meta tags -->
<meta charset="UTF-8">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet" href="/resources/css/estimateCalculationOneCss.css" />
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet"/>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>

<!-- 09.15 사이드바 토글 js-->
<script src="/resources/js/ESCA_NEW_Script.js"></script>
<!-- 09.12 단독 스타일시트 추가 -->
<link rel="stylesheet" href="/resources/css/ESCASelect.css">

<!-- 09.18 데이터 전송 js -->
<script src="/resources/js/escaSendData.js"></script>
<!-- 09.18 반응형 추가 -->
<script src="/resources/js/ESCA_NEW_Resize.js"></script>
<link rel="stylesheet" href="/resources/css/escaMQ.css">
<!-- 09.08 date picker js css 추가 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/js/bootstrap-datepicker.min.js" integrity="sha512-LsnSViqQyaXpD4mBBdRYeP6sRwJiJveh2ZIbW41EBrNmKxgr/LFZIiWT6yr+nycvhvauz8c2nYMhrP80YhG7Cw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/locales/bootstrap-datepicker.ko.min.js" integrity="sha512-L4qpL1ZotXZLLe8Oo0ZyHrj/SweV7CieswUODAAPN/tnqN3PA1P+4qPu5vIryNor6HQ5o22NujIcAZIfyVXwbQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/css/bootstrap-datepicker3.min.css" integrity="sha512-aQb0/doxDGrw/OC7drNaJQkIKFu6eSWnVMAwPN64p6sZKeJ4QCDYL42Rumw2ZtL8DB9f66q4CnLIUnAw28dEbg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/css/bootstrap-datepicker3.standalone.min.css" integrity="sha512-t+00JqxGbnKSfg/4We7ulJjd3fGJWsleNNBSXRk9/3417ojFqSmkBfAJ/3+zpTFfGNZyKxPVGwWvaRuGdtpEEA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- 09.27 4번질문 chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-dragdata"></script>
<script>
	// 파라미터 추가사항
	const loginUser = "${loginUser}";
	// 정보들
	const btnList = JSON.parse(`${processResourceTypeCodeInfoVOList}`);
	const modalList = JSON.parse(`${processResourceMasterVOList}`);

	$(function(){		
		$("#ESCA_modal").modal("show");
		

		// bootstrap tooltip base
		const tooltipTriggerList = $('[data-bs-toggle="tooltip"]');
		const tooltipList = tooltipTriggerList.map(function() {
			return new bootstrap.Tooltip($(this)[0]);
		}).get();

		// 3번 질문 기본 세팅
		for(let i = 0 ; i < btnList.length ; i++){
			if(btnList[i].processLgCd == "01"){
				const games = $("<button></button>").attr("type","button").attr("data-bs-toggle","modal").attr("data-bs-target","#q3-modal").addClass("list-group-item list-group-item-action").html(btnList[i].processTypeExclusiveCdNm).attr("id",btnList[i].processTypeExclusiveCd).attr("onclick","javascript:qestionThreeBtns(this)");
				$(".q3-game").append(games);
			}else if(btnList[i].processLgCd == "02"){
				const works = $("<button></button>").attr("type","button").attr("data-bs-toggle","modal").attr("data-bs-target","#q3-modal").addClass("list-group-item list-group-item-action").html(btnList[i].processTypeExclusiveCdNm).attr("id",btnList[i].processTypeExclusiveCd).attr("onclick","javascript:qestionThreeBtns(this)");
				$(".q3-work").append(works);
			}
		}
		// 4번질문 기본
		createChart();
		// 리셋버튼
		$(".reset-svg").mouseover(()=>{
			$(".reset-svg").addClass("mouse-in");
			setTimeout(() => {
				$(".reset-svg").removeClass("mouse-in");
			}, 2000);
		})
	})

	// 초반 모달 기능
	function modalNewBtn(){
		sessionStorage.setItem("targetData","")
		for(let i = 0; i<=19 ; i++){
			sessionStorage.setItem("data-" + i, "");
		}
		$("#ESCA_modal").modal("hide");
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
			for(let i = 0; i<=19 ; i++){
				sessionStorage.setItem("data-" + i, "");
			}
			$("#select-date").modal("hide");	
		}
	}
	function resetTime(){
		$("#time-chooser").children().val("00:00:00");
		chooseDate();
		chooseTime();
		changeTime();
	}

	// 견적산출 버튼 반응형 이벤트
	function resizeEsBtn(){
		if($("body").hasClass("sb-sidenav-toggled")){
			$("#es-btn").css("display","none");
		}else {
			setTimeout(() => {
				$("#es-btn").css("display","block");    
			}, 100);
		}
	}
	
	// 질문 목록 클릭 이벤트
	function clickQestionList(el){
		$(".q-base").removeClass("show").css("display","none");
		var qnum = $(el).attr("qnum");
		for(var i = 1 ; i<=20 ; i++ ){
			if( i != qnum){
				$(".q-" + i).removeClass("show").css("display","none");
			}
		}
		setTimeout(() => {
			$(".q-" + qnum).addClass("show");
		}, 100);
		$(".q-" + qnum).css("display","block");
	}

	// 질문 페이지 별 이벤트들
	// 1번질문
	function questionOneBtns(el){
		if($(el).attr("val") == "1"){
			sessionStorage.setItem("data-0",0);
		}else if($(el).attr("val") == "2"){
			sessionStorage.setItem("data-0",1);
		}else {
			sessionStorage.setItem("data-0",2);
		}
	}
	function questionOneSaveBtn(){
		$(".q1-badge").attr("bool","1");
		if(sessionStorage.getItem("data-0") == 0){
			$(".q1-badge").html("OS : 프리도스");
		}else if(sessionStorage.getItem("data-0") == 1){
			$(".q1-badge").html("OS : COEM");
		}else if(sessionStorage.getItem("data-0") == 2){
			$(".q1-badge").html("OS : Fpp");
		}else {
			alert("선택 후 저장 해주세요");
		}
	}
	// 2번질문
	function questionTwoBtns(el){
		const chkNum = /[0-9]/;
		if (!$(el).val()){
			$(".q2-badge").html("Price : " + $(el).val()).attr("bool","0");	
		}else if($(el).val() < 0){
			alert("0원 이상으로 입력해주세요~");
			$(el).val("");
		}else if($(el).val() > 500){
			alert("500만원 이하로 입력해주세요!");
			$(el).val("");
		}else if (!chkNum.test($(el).val())){
			alert("숫자만 입력해주세요!!");
			$(el).val("");
		}
	}
	function questionTwoSaveBtn(){
		if($("#can-pay-val").val() == ""){
			alert("값을 입력하신 후 저장 해주세요")
		}else{
			$(".q2-badge").html("Price : " + $("#can-pay-val").val()).attr("bool","1");
			sessionStorage.setItem("data-1", $("#can-pay-val").val())
		}
	}

	// 3번 질문
	let q3ImpBool = false;
	function qestionThreeBtns(el){
		$(".q3-modal-title").html($(el).html()).attr("id",$(el).attr("id"));
		const q3ModalTbody = $("#q3-modal-tbody");

		let thisGanreCd = $(el).attr("id");

		for(let i = 0 ; i< modalList.length ; i++){
			if(modalList[i].processTypeExclusiveCd == thisGanreCd){
				let tr = $(`<tr scope="col" class="q3-modal-items" onclick="javascript:q3ModalItems(this)"></tr>`).attr("id",modalList[i].id);
				let th = $("<th></th>").html(modalList[i].processName);
				tr.append(th);
				q3ModalTbody.append(tr);
			}
		}
	}	
	function q3ModalItems(el){
		let q3ModalGanre = $(".q3-modal-title").html();
		let q3ModalId = $(el).attr("id");
		let q3ModalName = $(el).children().html();
		let q3ModalElem = {q3ModalId,q3ModalName,q3ModalGanre};

		let isDuplicate = false;
		if($(".q3-table").css("display") == "table"){
			console.log("11")
			for(let i = 0 ; i < $("#q3-tbody").children().length ; i++){
				let findedId = $("#q3-tbody").children().eq(i).find("td").attr("id");
				if(q3ModalElem.q3ModalId != findedId){
					isDuplicate = false;
				}else {
					isDuplicate = true;
				}
			}
		}
		if(isDuplicate){
			alert("중복입니다. 다른 항목을 선택해주세요.");
			return false;
		}
		if($(el).css("color") == "rgb(33, 37, 41)"){
			$(el).css("color","rgb(255, 0, 0)");
			savedQ3List.push(q3ModalElem);
		}else {
			$(el).css("color", "rgb(33, 37 ,41)");
			savedQ3List = savedQ3List.filter(function(obj){
				return obj.q3ModalId !== q3ModalId;
			})
		}
	}
	function q3ModalCloseBtn(){
		setTimeout(() => {
			$("#q3-modal-tbody").children().remove();	
		}, 200);
		$("#q3-modal-search").val("");
		if(savedQ3List.length > 0){
			let q3TbodyIds = [];
			for(let i = 0 ; i < $("#q3-tbody").children().length ; i++){
				let findedId = $("#q3-tbody").children().eq(i).find("td").attr("id");
				q3TbodyIds.push(findedId);
				console.log(q3TbodyIds);
			}
			let filteredQ3List = [];

			for (let i = 0; i < q3TbodyIds.length; i++) {
				filteredQ3List = filteredQ3List.concat(savedQ3List.filter(function (obj) {
					return obj.q3ModalId === q3TbodyIds[i];
				}));
			}
			savedQ3List = filteredQ3List;

			console.log(savedQ3List);
		}
	}
	let savedQ3List = [];
	function q3ModalSaveBtn(){
		$("#q3-modal-search").val("");
		$("#q3-tbody").children().remove();
		$(".q3-badge").attr("bool","0").html("");
		for(let i = 0 ; i < savedQ3List.length ; i++){
			const q3Tbody = $("#q3-tbody");
			let tr = $("<tr></tr>");
			let th;
			if(savedQ3List[i].q3ModalName == "서핑"){
				th = $(`<th scope="row" class="align-middle q3-th-ganre"></th>`).html(savedQ3List[i].q3ModalGanre);
			}else {
				th = $(`<th scope="row" class="align-middle q3-th-ganre"></th>`).html(savedQ3List[i].q3ModalGanre).attr("id",$(".q3-modal-title").attr("id"));
			}
			let td1 = $(`<td class="align-middle"></td>`).html(savedQ3List[i].q3ModalName).attr("id",savedQ3List[i].q3ModalId);
			let td2 = $("<td></td>");
			let td2Input = $(`<input type="text" placeholder="1~100" class="form-control q3-imp-input" oninput="javascript:q3InputCheck(this)">`)
			td2.append(td2Input);
			let td3 = $(`<td></td>`);
			let button = $(`<button class="btn btn-danger margin-auto" onclick="javascript:q3DeleteBtn(this)">삭제</button>`);
			td3.append(button);
			tr.append(th).append(td1).append(td2).append(td3);
			q3Tbody.append(tr);
			if($("#q3-tbody").children().length !== 0){
				$(".q3-table").css("display","table");
				setTimeout(() => {
					$(".q3-save-btn").css("display","inline-block");
				}, 100);
				$(".q3-save-btn").addClass("show");
			}
		}
		setTimeout(() => {
			$("#q3-modal-tbody").children().remove();	
		}, 200);
	}
	function q3DeleteBtn(el){
		$(el).parent().parent().remove();
		let deleteElem = $(el).parent().prev().prev().attr("id");
		$(".q3-badge").attr("bool","0").html("");
		$(".q3-imp-input").val("");
		savedQ3List = savedQ3List.filter(function(obj){
			return obj.q3ModalId !== deleteElem;
		})
		if($("#q3-tbody").children().length == "0"){
			$(".q3-table").css("display","none");
			setTimeout(() => {
				$(".q3-save-btn").css("display","none");
			}, 100);
			$(".q3-save-btn").removeClass("show");
		}
		if($(el).parent().prev().prev().html() == "서핑"){
			$("#PR999999").attr("state","00");
		}
	}
	function q3SurfBtn(el){
		let q3ModalGanre = $(el).html();
		let q3ModalId = $(el).attr("id");
		let q3ModalName = $(el).html();
		let q3ModalElem = {q3ModalId,q3ModalName,q3ModalGanre};
		if($(el).attr("state") == "00"){
			$(el).attr("state","01");
			savedQ3List.push(q3ModalElem);
		}else if($(el).attr("state") == "01"){
			$(el).attr("state","00");
			savedQ3List = savedQ3List.filter(function(obj){
				return obj.q3ModalId !== q3ModalId;
			})
		}
		q3ModalSaveBtn();
		if($("#q3-tbody").children().length == "0"){
			$(".q3-table").css("display","none");
			setTimeout(() => {
				$(".q3-save-btn").css("display","none");
			}, 100);
			$(".q3-save-btn").removeClass("show");
		}
	}
	const noResultText = document.createTextNode("일치하는 결과가 없습니다.");
	function searchLabel() {
		const labelTable = $("#q3-modal-tbody");
		const noResultRow = $("<tr>");
		const noResultCell = $("<td>");
		const labels = labelTable.find("th");
		const searchInput = $("#q3-modal-search").val().toLowerCase();
		const matchedLabels = [];
		labels.each(function() {
			const label = $(this);
			const labelName = label.text().toLowerCase();

			if (labelName.includes(searchInput)) {
				matchedLabels.push(label);
			}
		});
		for(let i = 0 ; i < labels.length; i++){
		}
		const searchInputValue = $("#q3-modal-search").val().trim();
		if (matchedLabels.length > 0) {
			matchedLabels.sort(function(a, b) {
			const aIndex = a.text().toLowerCase().indexOf(searchInput);
			const bIndex = b.text().toLowerCase().indexOf(searchInput);

			if (aIndex === bIndex) {
				return a.text().toLowerCase().localeCompare(b.text().toLowerCase());
			}

			return aIndex - bIndex;
			});
			
			hideAllRows();
			
			matchedLabels.forEach(function(matchedLabel) {
			const row = matchedLabel.closest("tr");
			row.css("display", "table-row");
			});
		}else {
			hideAllRows();

			noResultCell.attr("colspan", "2");
			noResultCell.append(noResultText);
			noResultRow.append(noResultCell);
			labelTable.append(noResultRow);
		}
	}
	function hideAllRows() {
		const labelTable = $("#q3-modal-tbody");
		const noResultRow = $("<tr>");
		labelTable.find("tr").css("display", "none");

		if (noResultRow.parent().is(labelTable)) {
			noResultRow.remove();
		}
	}
	let q3Total = 0;
	function q3InputCheck(el){
		q3Total = 0;
		$(".q3-imp-input").each(function(){
			let val = Number($(this).val());
			q3Total += val;
			if($(this).val() == "0"){
				alert("0 이상 입력해주세요.");
				$(this).val("");
				return false;
			}
			if(q3Total >= 101){
				alert("총합 100 이하로 입력해주세요.");
				$(".q3-imp-input").val("");
				return false;
			}
			if(q3Total === 100){
				q3ImpBool = true;
			}else {
				q3ImpBool = false;
			}
		});
	}
	function questionThreeSaveBtn(){
		if(q3ImpBool){
			$(".q3-badge").html("GR : " + savedQ3List[0].q3ModalName + "...").attr("bool","1");
			let q3Values = [];
			for (let i = 0; i< savedQ3List.length ; i++){
				let q3Value = [];
				q3Value.push(savedQ3List[i].q3ModalId);
				q3Value.push($(".q3-imp-input").eq(i).val());
				if($(".q3-th-ganre").eq(i).attr("id") == null){
					q3Value.push("");	
				}else {
					q3Value.push($(".q3-th-ganre").eq(i).attr("id"));
				}
				q3Values.push(q3Value);
			}
			sessionStorage.setItem("data-2",JSON.stringify(q3Values));
		}else {
			alert("비중을 합 100에 맞게 입력해주세요.");
		}
	}
	// 4번질문
	// hex chart.js
	var myChart ;
	function createChart(){
		var minDataValue = 0; 

		var ctx = $('#myChart')[0].getContext('2d');
		var gradient = ctx.createLinearGradient(0, 0, 0, 300);
		gradient.addColorStop(0, 'rgba(153, 50, 204, 0.9)'); 
		gradient.addColorStop(1, 'rgba(37, 180, 220, 0.9)'); 

		myChart = new Chart(ctx, {
			type: 'radar',
			data: {
				labels: ['발열', '소재', 'AS', '소음', '안정성', 'QC'],
				datasets: [{
					label: '',
					data: [1, 1, 1, 1, 1, 1],
					backgroundColor: gradient,
					pointRadius: 6,
					hoverRadius: 12,
				}]
			},
			options: {
				onHover: function(event, chartElement) {
						if (chartElement.length > 0) {
							var point = chartElement[0];
							var label = myChart.data.labels[point.index];
							if(label === "발열"){
								$("#explane-area").html("발열 : 제품을 낮은 온도로 유지해줄 발열제어능력을 의미합니다.\n\n0일 때 온전한 성능을 발휘할 수 있는 최소한의 쿨러만 설치되며, 2일 때 예산을 초과편성하지 않는 선에서의 최고의 쿨링성능을 제공합니다.")
							}else if(label ==="소재"){
								$("#explane-area").html("소재 : 하드웨어적 제품 가치를 의미합니다.\n\n강판의 종류, 두께, 강도, 열전도율, 베어링 방식, 방열판 구조, 쿨링솔루션 등을 의미합니다.\n\n0일 때 소재를 전혀 고려하지 않고 호환성만 검토하며\n\n2일 때 하드웨어적으로 완성에 가까운 제품을 선정하게 됩니다.")
							}else if(label === "소음"){
								$("#explane-area").html("소음 : 제품의 상세설명 상 표기 데시벨을 점수화하여 기록된 자료입니다.\n\nBeta버전으로, 실측 테스트가 진행되지 않아 알고리즘 연산식에서 배제됩니다.\n\n수치 변동에 따라 제품 선정 변경점이 존재하지 않습니다.")
							}else if(label === "QC"){
								$("#explane-area").html("QC : 제품의 결함율을 나타냅니다.\n\n단순한 출고 결함율만이 아닌 최근 해당 제품 혹은 제품의 제조사, 제품군의 라인업/칩셋 등의 이슈를 다룹니다.\n\n0일 때 당장의 리콜/판매금지 제품을 제외하곤 모든 가능성을 열어두며, 2일 때 이름값을 다소 지불하더라도 입증된 메이저 제품군만을 취급합니다.")
							}else if(label === "안정성"){
								$("#explane-area").html("안정성 : 제품의 성능을 온전하게 유지하고 수명을 올려줄 모든 수단을 의미합니다.\n\n0일 때 가격대비 퍼포먼스 표기 성능이 가장 높은 제품을 선택하고, 2일 때 제품의 체급을 낮춰서라도 프리미엄 라인업을 선정합니다.")
							}else if(label === "AS"){
								$("#explane-area").html("AS : 제품들의 사후처리 가능성을 나타냅니다.\n\n수리규정, 유통사 평판 등이 이에 해당합니다.\n0일 때 AS를 전혀 감안하지 않으며, 2일 때 AS의 가격가치를 제품 성능보다도 우선시합니다.")
							}else {
								$("#explane-area").html("가성비 : (깡통 독3사) 최소한의 기준치를 충족한 제품군들 중 성능만을 위해 예산을 소요합니다.\n가격대 성능비가 가장 좋지만 체급에 비해 종합 안정성이 떨어집니다.\n\n메인스트림 : (필수옵션 소나타)해당 예산대의 평균적인 제품군을 선정합니다. 예산 내의 이상적인 견적을 받을 수 있습니다.\n\n프리미엄 : (풀옵 경차)예산에 비해 과한 제품 종합 안정성을 보장합니다.\n각 라인업별 최고의 제품들만 선별하여 활용하겠지만, 성능은 돈값을 못한다는 이야기를 듣기 쉽습니다.");
							}
						}
				},
				maintainAspectRatio: false,
				responsive: false,
				scales: {
					r: {
						display: false,
						min: minDataValue,
						max: 2,
						ticks: {
						// display: false,
						stepSize: 0.01
						}
						
					}
				},
				plugins: {
					legend: {
						display: false
					},
					dragData: {
						round: 2,
						showTooltip: true,
						onDragStart: function (event, datasetIndex, index, value) {
							if (value < minDataValue) {
								return false;
							}
						},
						onDrag: function (event, datasetIndex, index, value) {
							const hexInputs = $(".hex-input");
							hexInputs[index].value = parseFloat(myChart.data.datasets[datasetIndex].data[index]).toFixed(2);
							hexagonType();
							if (value < minDataValue) {
								myChart.data.datasets[datasetIndex].data[index] = minDataValue;
								myChart.update();
							}
						},
						onDragEnd: function(event, datasetIndex, index, value){
							const hexInputs = $(".hex-input");
							hexInputs[index].value = parseFloat(myChart.data.datasets[datasetIndex].data[index]).toFixed(2);
						}
					}
				},
				animation: {
					duration: 500,
					easing: 'easeOutQuart'
				},

				afterDraw: function(chart) {
					var ctx = chart.ctx;
					var scale = chart.scales.r;
					
					if (scale.max === 2) {
						ctx.save();
						ctx.beginPath();
						ctx.strokeStyle = '#000000';
						ctx.lineWidth = 2;
						ctx.setLineDash([5, 5]);
						ctx.moveTo(scale.xCenter, scale.yCenter);
						ctx.lineTo(scale.xCenter + scale.radius, scale.yCenter);
						ctx.stroke();
						ctx.restore();
					}
				}
			}
		});
	}
	
	function hexagonType(){
		const hexInputs = $(".hex-input");

		for(let i = 0 ; i<hexInputs.length; i++){
			const inputValue = parseFloat(hexInputs[i].value);
			if(hexInputs[i].value < 0 || hexInputs[i].value>2){
				alert("0이상 2미만으로 입력해주세요!");
				setTimeout(() => {
					hexInputs[i].value = "1.00";
					myChart.data.datasets[0].data[i] = 1;
					myChart.update();
				}, 1);
				myChart.data.datasets[0].data[i] = inputValue;
			}else {
				myChart.data.datasets[0].data[i] = inputValue;
				myChart.update();
			}
			
		}
		setTimeout(() => {
			$("#hex-val-total").val(parseFloat((Number($("#hex-val-01").val())+Number($("#hex-val-02").val())+Number($("#hex-val-03").val())+Number($("#hex-val-04").val())+Number($("#hex-val-05").val())+Number($("#hex-val-06").val()))/(6)).toFixed(2));	
		}, 100);
	}
	let prevTotalVal = 1;
	function totalValue(){
		let count = 6;
		const hexInputs = $(".hex-input");
		
		const totalVal = Number(parseFloat($("#hex-val-total").val()).toFixed(2));
		const allInputs = (Number($("#hex-val-01").val())+Number($("#hex-val-02").val())+Number($("#hex-val-03").val())+Number($("#hex-val-04").val())+Number($("#hex-val-05").val())+Number($("#hex-val-06").val()))/6;

		if($("#hex-val-total").val() ==="0"){
			for(let i = 0 ; i<hexInputs.length; i++){
				hexInputs[i].value = "0.00"
				myChart.data.datasets[0].data[i] = "0";
			}
		}else if($("#hex-val-total").val() ==="2"){
			for(let i = 0 ; i<hexInputs.length; i++){
				hexInputs[i].value = "2.00"
				myChart.data.datasets[0].data[i] = "2";
			}
		}else {
			if(totalVal<allInputs){
				for(let i = 0 ; i<hexInputs.length; i++){
					if(hexInputs[i].value === "0"){
						count--;
					}
				}
				
				for(let i = 0 ; i<hexInputs.length; i++){
					let inputVal = hexInputs[i].value;
					if(Number(inputVal) > 0){
						let inputVal = Number(hexInputs[i].value) - Number(parseFloat(Math.abs(prevTotalVal - totalVal)).toFixed(2))
						hexInputs[i].value = String(parseFloat(inputVal).toFixed(2));
						myChart.data.datasets[0].data[i] = inputVal;
						if(Number(inputVal) < 0){
							hexInputs[i].value = "0.00";
							
						}else if(Number(inputVal)>2){
							hexInputs[i].value = "2.00";
						}
					}
				}
			}else if(totalVal>allInputs){
				for(let i = 0 ; i<hexInputs.length; i++){
					if(hexInputs[i].value === "2"){
						count--;
					}
				}
				for(let i = 0 ; i<hexInputs.length; i++){
					let inputVal = hexInputs[i].value;
					if(Number(inputVal) < 2){
						let inputVal = Number(hexInputs[i].value)+Number(parseFloat(Math.abs(prevTotalVal - totalVal)).toFixed(2))
						hexInputs[i].value = String(parseFloat(inputVal).toFixed(2));
						myChart.data.datasets[0].data[i] = inputVal;
						if(Number(inputVal) < 0){
							hexInputs[i].value = "0.00";
						}else if(Number(inputVal)>2){
							hexInputs[i].value = "2.00"
						}
					}
				}
			
			}
			prevTotalVal = totalVal;
		}
		myChart.update();
	}
	// explane-area
	function mouseEnter(elem){
		const elemHtml = $(elem).html();
		if(elemHtml === "발열"){
			$("#explane-area").html("발열 : 제품을 낮은 온도로 유지해줄 발열제어능력을 의미합니다.\n\n0일 때 온전한 성능을 발휘할 수 있는 최소한의 쿨러만 설치되며, 2일 때 예산을 초과편성하지 않는 선에서의 최고의 쿨링성능을 제공합니다.")
		}else if(elemHtml ==="소재"){
			$("#explane-area").html("소재 : 하드웨어적 제품 가치를 의미합니다.\n\n강판의 종류, 두께, 강도, 열전도율, 베어링 방식, 방열판 구조, 쿨링솔루션 등을 의미합니다.\n\n0일 때 소재를 전혀 고려하지 않고 호환성만 검토하며\n\n2일 때 하드웨어적으로 완성에 가까운 제품을 선정하게 됩니다.")
		}else if(elemHtml === "소음"){
			$("#explane-area").html("소음 : 제품의 상세설명 상 표기 데시벨을 점수화하여 기록된 자료입니다.\n\nBeta버전으로, 실측 테스트가 진행되지 않아 알고리즘 연산식에서 배제됩니다.\n\n수치 변동에 따라 제품 선정 변경점이 존재하지 않습니다.")
		}else if(elemHtml === "QC"){
			$("#explane-area").html("QC : 제품의 결함율을 나타냅니다.\n\n단순한 출고 결함율만이 아닌 최근 해당 제품 혹은 제품의 제조사, 제품군의 라인업/칩셋 등의 이슈를 다룹니다.\n\n0일 때 당장의 리콜/판매금지 제품을 제외하곤 모든 가능성을 열어두며, 2일 때 이름값을 다소 지불하더라도 입증된 메이저 제품군만을 취급합니다.")
		}else if(elemHtml === "안정성"){
			$("#explane-area").html("안정성 : 제품의 성능을 온전하게 유지하고 수명을 올려줄 모든 수단을 의미합니다.\n\n0일 때 가격대비 퍼포먼스 표기 성능이 가장 높은 제품을 선택하고, 2일 때 제품의 체급을 낮춰서라도 프리미엄 라인업을 선정합니다.")
		}else if(elemHtml === "AS"){
			$("#explane-area").html("AS : 제품들의 사후처리 가능성을 나타냅니다.\n\n수리규정, 유통사 평판 등이 이에 해당합니다.\n0일 때 AS를 전혀 감안하지 않으며, 2일 때 AS의 가격가치를 제품 성능보다도 우선시합니다.")
		}else {
			$("#explane-area").html("가성비 : (깡통 독3사) 최소한의 기준치를 충족한 제품군들 중 성능만을 위해 예산을 소요합니다.\n가격대 성능비가 가장 좋지만 체급에 비해 종합 안정성이 떨어집니다.\n\n메인스트림 : (필수옵션 소나타)해당 예산대의 평균적인 제품군을 선정합니다. 예산 내의 이상적인 견적을 받을 수 있습니다.\n\n프리미엄 : (풀옵 경차)예산에 비해 과한 제품 종합 안정성을 보장합니다.\n각 라인업별 최고의 제품들만 선별하여 활용하겠지만, 성능은 돈값을 못한다는 이야기를 듣기 쉽습니다.");
		}
	}
	
	function q4ClickReset() {
		const hexInputs = $(".hex-input");
		for(let i = 0 ; i<hexInputs.length; i++){
			hexInputs[i].value = "1.00";
		}
		hexagonType();
	}
	function questionFourSaveBtn(){
		if($("#hex-val-01").val() === "1.00" && $("#hex-val-02").val() === "1.00" && $("#hex-val-03").val() === "1.00" && $("#hex-val-04").val() === "1.00" && $("#hex-val-05").val() === "1.00" && $("#hex-val-06").val() === "1.00"){
			if(confirm("변동사항이 없습니다! 평균값으로 진행할까요?")){
				let value = [];
				for(let i = 0 ; i<$(".hex-input").length; i++){
					let storageValue = [$(".hex-input")[i].value];
					value.push(storageValue);
				}
				sessionStorage.setItem("data-4",JSON.stringify(value))
				$(".q4-badge").html("Bu : check");
			}
		}else {
			let value = [];
			for(let i = 0 ; i<$(".hex-input").length; i++){
				let storageValue = [$(".hex-input")[i].value];
				value.push(storageValue);
			}
			sessionStorage.setItem("data-4",JSON.stringify(value));
			$(".q4-badge").html("Bu : check");
		}
	}
	// 5번질문
	let q5Answers = 0;
	function questionFiveBtn(el){
		if($(el).children().html() == "필요합니다"){
			q5Answers = 0;
			}else {
				q5Answers = 1;
			}
	}
	function questionFiveSaveBtn(){
		if($("#q5-answer1").prop("checked") || $("#q5-answer2").prop("checked")){
			if(q5Answers == 0){
				sessionStorage.setItem("data-4",0);
				$(".q5-badge").html("Wifi : 필요");
			}else {
				sessionStorage.setItem("data-4",1);
				$(".q5-badge").html("Wifi : 불필요");
			}
		}
	}
	// 6번질문
	let q6Answers = 0;
	function questionSixBtn(el){
		if($(el).children().html() == "Intel"){
			q6Answers = 0;
		}else if ($(el).children().html() == "AMD") {
			q6Answers = 1;
		}else {
			q6Answers = 2;
		}
	}
	function questionSixSaveBtn(){
		if($("#q6-answer1").prop("checked") || $("#q6-answer2").prop("checked") || $("#q6-answer3").prop("checked")){
			if(q6Answers == 0){
				sessionStorage.setItem("data-5",0);
				$(".q6-badge").html("CPU : Intel");
			}else if(q6Answers == 1){
				sessionStorage.setItem("data-5",1);
				$(".q6-badge").html("CPU : AMD");
			}else {
				sessionStorage.setItem("data-5",2);
				$(".q6-badge").html("CPU : 상관없음");
			}
		}
	}
	// 7번질문
	let q7Answers = 0;
	function questionSevenBtn(el){
		if($(el).children().html() == "필요합니다"){
			q7Answers = 0;
		}else if ($(el).children().html() == "상관없음") {
			q7Answers = 1;
		}else {
			q7Answers = 2;
		}
	}
	function questionSevenSaveBtn(){
		if($("#q7-answer1").prop("checked") || $("#q7-answer2").prop("checked") || $("#q7-answer3").prop("checked")){
			if(q7Answers == 0){
				sessionStorage.setItem("data-6",0);
				$(".q7-badge").html("GPU : 필요");
			}else if(q7Answers == 1){
				sessionStorage.setItem("data-6",1);
				$(".q7-badge").html("GPU : 상관없음");
			}else {
				sessionStorage.setItem("data-6",2);
				$(".q7-badge").html("GPU : 불필요");
			}
		}
	}
	// 8번질문
	let q8Answers = 0;
	function questionEightBtn(el){
		if($(el).children().html() == "선호합니다"){
			q8Answers = 0;
		}else if ($(el).children().html() == "선호하지않습니다") {
			q8Answers = 1;
		}else {
			q8Answers = 2;
		}
	}
	function questionEightSaveBtn(){
		if($("#q8-answer1").prop("checked") || $("#q8-answer2").prop("checked") || $("#q8-answer3").prop("checked")){
			if(q8Answers == 0){
				sessionStorage.setItem("data-6",0);
				$(".q8-badge").html("Aio : 선호");
			}else if(q8Answers == 1){
				sessionStorage.setItem("data-6",1);
				$(".q8-badge").html("Aio : 비선호");
			}else {
				sessionStorage.setItem("data-6",2);
				$(".q8-badge").html("Aio : 무관");
			}
		}
	}
	// 9번질문
	// 10번질문
	// 11번질문
	// 12번질문
	// 13번질문
	// 14번질문
	// 15번질문
	// 16번질문
	// 17번질문
	// 18번질문
	// 19번질문
	// 20번질문
</script>
</head>
<body>
	<%@ include file="./common/header.jsp" %>
	<div class="basic_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="side-empty"></div>
			<!-- 작업영역 -->

			<!-- 기본 선택 모달 -->
			<div class="modal fade" id="ESCA_modal" aria-hidden="true" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false">
				<div class="modal-dialog modal-lg modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header justify-content-center">
							<h5 class="modal-title">반갑습니다 현우의 컴퓨터 공방 입니다!</h5>
						</div>
						<div class="modal-body text-center">
							<h4 class="p-2">견적산출 기준을 정해주세요!</h4>
							<div class="text-center d-sm-flex align-items-center modal-btn-col new-btn">
								<button type="button" class="w-25 btn btn-primary modal-btn pb-0" onclick="javascript:modalNewBtn()">
									새로하기
								</button>
								<h5 class="w-75 ps-3 text-breaks">
									처음 이용하시거나 과거 견적산출이 필요 없으신 경우 새로 진행합니다.
								</h5>
							</div>
							<div class="text-center d-sm-flex align-items-center mt-2 modal-btn-col">
								<button type="button" class="w-25 btn btn-primary modal-btn pb-0" data-bs-target="#select-date" data-bs-toggle="modal">
									날짜선택
								</button>
								<h5 class="w-75 ps-3 text-breaks">
									<p>견적산출을 했던 날짜를 선택합니다.</p>
									<p>날짜 기준으로 다시 견적산출을 진행합니다.</p>
								</h5>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 날짜 선택 모달 -->
			<div class="modal fade" id="select-date" aria-hidden="true" aria-labelledby="select-date" tabindex="-1">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header text-center">
							<h1 class="modal-title fs-5">날짜 선택</h1>
						</div>
						<div class="modal-body">
							<div class="row">
								<div class="col-md">
									<p><div class="btn btn-primary pb-0" onclick="javascript:chooseDate()">날짜선택</div></p>
									<p><input type="text" class="form-control pb-0 bg-light" disabled id="date-input" onclick="javascript:chooseDate()"></input></p>
									<p><div class="btn btn-primary pb-0" onclick="javascript:chooseTime()">시간선택</div></p>
									<p><input type="text" class="form-control pb-0 bg-light" id="time-input" disabled></p>
									<small class="fz-6">시간 미선택시 00:00:00으로 입력됩니다</small>
								</div>
								<div class="col-md">
									<div id="date-chooser"></div>
									<div class="mt-2 p-2 pb-0 d-none" id="time-chooser">
										<input type="time" class="pb-0" value="13:33:31" step="1" onchange="javascript:changeTime()">
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
									<input type="text" class="pb-0 form-control bg-light" id="date-time-result" disabled>
								</div>
								<div class="col-md text-end">
									<button class="btn btn-primary pb-0 w-50" id="select-date-modal-start-btn" onclick="javascript:checkResult()">시작하기</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- ui 업데이트 시안 -->
			<div class="container main-box">
				<div class="d-flex mt-3 mb-5 rounded" id="wrapper">
					<!-- Sidebar-->
					<div class="border-end bg-white" id="sidebar-wrapper">
						<div class="sidebar-heading border-bottom bg-light ps-2">질문 목록</div>
						<ul class="list-group list-group-flush">
							<a class="list-group-item list-group-item-action list-group-item-primary p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="1">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 1번
									<div class="d-flex">
										<span class="badge bg-primary rounded-pill pt-2 pe-2 q1-badge me-1" bool="0"></span>
										<span class="badge bg-danger rounded-pill pt-2">필수</span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-primary p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="2">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 2번
									<div class="d-flex">
										<span class="badge bg-primary rounded-pill pt-2 pe-2 q2-badge me-1" bool="0"></span>
										<span class="badge bg-danger rounded-pill pt-2">필수</span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-primary p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="3">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 3번
									<div class="d-flex">
										<span class="badge bg-primary rounded-pill pt-2 pe-2 q3-badge me-1" bool="0"></span>
										<span class="badge bg-danger rounded-pill pt-2">필수</span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="4">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 4번
									<div class="d-flex">
										<span class="badge bg-primary rounded-pill pt-2 pe-2 q4-badge"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="5">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 5번
									<div class="d-flex">
										<span class="badge bg-primary rounded-pill pt-2 pe-2 q5-badge"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="6">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 6번
									<div class="d-flex">
										<span class="badge bg-primary rounded-pill pt-2 pe-2 q6-badge"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="7">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 7번
									<div class="d-flex">
										<span class="badge bg-primary rounded-pill pt-2 pe-2 q7-badge"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="8">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 8번
									<div class="d-flex">
										<span class="badge bg-primary rounded-pill pt-2 pe-2 q8-badge"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="9">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 9번
									<div class="d-flex">
										<span class="badge bg-primary rounded-pill pt-2 pe-2 q9-badge"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="10">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 10번
									<div class="d-flex">
										<span class="badge bg-primary rounded-pill pt-2 pe-2 q10-badge"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="11">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 11번
									<div class="d-flex">
										<span class="badge bg-primary rounded-pill pt-2 pe-2 q11-badge"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="12">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 12번
									<div class="d-flex">
										<span class="badge bg-primary rounded-pill pt-2 pe-2 q12-badge"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="13">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 13번
									<div class="d-flex">
										<span class="badge bg-primary rounded-pill pt-2 pe-2 q13-badge"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="14">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 14번
									<div class="d-flex">
										<span class="badge bg-primary rounded-pill pt-2 pe-2 q14-badge"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="15">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 15번
									<div class="d-flex">
										<span class="badge bg-primary rounded-pill pt-2 pe-2 q15-badge"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="16">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 16번
									<div class="d-flex">
										<span class="badge bg-primary rounded-pill pt-2 pe-2 q16-badge"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="17">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 17번
									<div class="d-flex">
										<span class="badge bg-primary rounded-pill pt-2 pe-2 q17-badge"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="18">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 18번
									<div class="d-flex">
										<span class="badge bg-primary rounded-pill pt-2 pe-2 q18-badge"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="19">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 19번
									<div class="d-flex">
										<span class="badge bg-primary rounded-pill pt-2 pe-2 q19-badge"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="20">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 20번
									<div class="d-flex">
										<span class="badge bg-primary rounded-pill pt-2 pe-2 q20-badge"></span>
									</div>
								</li>
							</a>
						</ul>
					</div>
					<!-- Page content wrapper-->
					<div id="page-content-wrapper" class="bg-white w-100">
						<!-- Top navigation-->
						<nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom navbar-header">
							<div class="container-fluid">
								<button class="btn btn-primary" id="sidebarToggle">목록 보기</button>
								<button type="button" class="btn btn-success" id="es-btn" onclick="javascript:sendAllData()">견적 산출</button>
							</div>
						</nav>
						<!-- Page content-->
						<div class="container-fluid q-box">
							<h1 class="mt-4">견적산출</h1>
							<div class="q-base fade show">
								<h2 class="mt-4">질문은 총 20개 이며 1~3번은 필수 질문입니다!</h2>
								<h3 class="mt-3">목록의 질문을 클릭해서 질문에 답해주세요!</h3>
								<h3 class="mt-3">답변 후 우측 상단에 있는 저장 버튼을 눌러주셔야 정상적으로</h3>
								<h3 class="mt-3">견적 산출이 진행됩니다.</h3>
							</div>
							<!-- 1번 질문 -->
							<div class="q-1 fade">
								<h2 class="mt-4 d-flex justify-content-between">
									<span>질문 1번</span>
									<button class="btn btn-primary q1-save-btn" onclick="javascript:questionOneSaveBtn()">저장</button>
								</h2>
								<h3 class="mt-3">OS(윈도우) 라이센스가 필요하신가요?</h3>
								<div class="mt-2 mb-5 row">
									<div class="col-xxl-2 question-col-3">
										<input type="radio" class="btn-check" name="btnradio" id="answer-a">
										<label class="btn btn-outline-secondary w-75" for="answer-a" val="1" qname="프리도스" onclick="javascript:questionOneBtns(this)" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Free Dos(OS 미설치) : 구매 후 바로 사용하실 수 없고 윈도우를 직접 설치하셔야 합니다. 최적화가 되어있지 않고, 드라이버가 담긴 USB를 제공합니다!"><p class="pt-2 m-0">프리도스</br>0원</p></label>
									</div>
									<div class="col-xxl-2 question-col-3">
										<input type="radio" class="btn-check" name="btnradio" id="answer-b">
										<label class="btn btn-outline-secondary w-75" for="answer-b" val="2" qname="COEM" onclick="javascript:questionOneBtns(this)" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="COEM(메인보드 귀속형) : 최적화 작업을 무상 진행합니다. 윈도우는 해당 PC를 폐기하거나 메인보드의 수명이 다하거나 당사 귀책 외의 사항으로 교체 시 라이선스를 재구매하셔야 합니다!"><p class="pt-2 m-0">COEM</br>150,000원</p></label>
									</div>
									<div class="col-xxl-2 question-col-3">
										<input type="radio" class="btn-check" name="btnradio" id="answer-c">
										<label class="btn btn-outline-secondary w-75" for="answer-c" val="3" qname="FPP" onclick="javascript:questionOneBtns(this)" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Fpp(라이센스 구매형) : 최적화 작업을 무상 진행합니다. 윈도우는 해당 PC를 폐기하거나 교체 할 경우 라이센스를 유지하고 다른 PC로 이전 가능합니다."><p class="pt-2 m-0">Fpp</br>180,000원</p></label>
									</div>
									<div class="col-md-6"></div>
								</div>
								<p class="mt-4 mb-0 q-1-p">최적화란?</p>
								<p class="q-1-p">윈도우 최적화, 드라이버 업데이트, 바이오스 설정 및 업데이트, 각 업데이트 내용은 이슈 없는 버전으로 리빌딩합니다.</p>
							</div>

							<!-- 2번 질문 -->
							<div class="q-2 fade">
								<h2 class="mt-4 d-flex justify-content-between">
									<span>질문 2번</span>
									<button class="btn btn-primary q2-save-btn" onclick="javascript:questionTwoSaveBtn()">저장</button>
								</h2>
								<h3 class="mt-3">본체에 투자하실 최대 한도는 얼마인가요? (최대 500만원)</h3>
								<div class="mt-2 mb-5 row">
									<div class="col-md">
										<div class="input-group has-validation text-end d-flex flex-end justify-content-center mb-5 calc-input-element">
											<input type="text" class="form-control input-field text-end w-50 first-q-input fs-5 pt-2" min="0" max="500" placeholder="ex) 300" id="can-pay-val" aria-describedby="inputGroupPrepend" required oninput="javascript:questionTwoBtns(this)"/>
											<span class="input-group-text fs-5 pt-2" id="inputGroupPrepend">만원</span>
										</div>
									</div>
									<div class="col-md-6"></div>
								</div>
							</div>

							<!-- 3번 질문 -->
							<div class="q-3 fade">
								<h2 class="mt-4 d-flex justify-content-between">
									<span>질문 3번</span>
									<button class="btn btn-primary q3-save-btn" onclick="javascript:questionThreeSaveBtn()">저장</button>
								</h2>
								<h3 class="mt-3">주 사용 목적을 선택해주세요 (다중선택 가능)</h3>
								<div class="row">
									<div class="col">
										<input class="form-control text-center q3-game-head" type="text" value="게임" disabled readonly>
									</div>
									<div class="col">
										<input class="form-control text-center q3-work-head" type="text" value="작업" disabled readonly>
									</div>
									<div class="col">
										<input class="form-control text-center q3-surf-head" type="text" value="서핑" disabled readonly>
									</div>
								</div>
								<div class="row mt-3">
									<div class="col text-center">
										<div class="list-group q3-game" processLgCd="01"></div>
									</div>
									<div class="col text-center">
										<div class="list-group q3-work" processLgCd="02"></div>
									</div>
									<div class="col text-center">
										<div class="list-group q3-surf" processLgCd="03">
											<button class="list-group-item list-group-item-action" type="button" id="PR999999" state="00" onclick="javascript:q3SurfBtn(this)">서핑</button>
										</div>
									</div>
								</div>
								<div class="q3-table-container mt-3">
									<table class="table table-secondary table-striped table-hover border q3-table" style="display: none;">
										<thead>
											<tr>
												<th scope="col" style="width: 15%;">장르</th>
												<th scope="col">이름</th>
												<th scope="col" style="width: 10%;">비중</th>
												<th scope="col" style="width: 7%;"></th>
											</tr>
										</thead>
										<tbody id="q3-tbody"></tbody>
									</table>
								</div>
							</div>

							<!-- 3번 질문 모달 -->
							<div class="modal fade" id="q3-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered">
									<div class="modal-content">
										<div class="modal-header">
											<h1 class="modal-title fs-5 q3-modal-title"></h1>
											<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="javascript:q3ModalCloseBtn()"></button>
										</div>
										<div class="modal-body" id="q3-modal-body">
											<table class="table">
												<thead>
													<tr>
														<input type="text" class="form-control" id="q3-modal-search" placeholder="검색어를 입력해주세요" oninput="javascript:searchLabel()">
													</tr>
													<tr>
														<th scope="col">
															이름
														</th>
													</tr>
												</thead>
												<tbody id="q3-modal-tbody">
												</tbody>
											</table>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="javascript:q3ModalCloseBtn()">닫기</button>
											<button type="button" class="btn btn-primary" data-bs-dismiss="modal" onclick="javascript:q3ModalSaveBtn()">저장</button>
										</div>
									</div>
								</div>
							</div>
							<!-- 4번질문 -->
							<div class="q-4 fade">
								<h2 class="mt-4 d-flex justify-content-between">
									<span>질문 4번</span>
									<button class="btn btn-primary q4-save-btn" onclick="javascript:questionFourSaveBtn()">저장</button>
								</h2>
								<h3 class="mt-3">예산을 세분화하여 편성 해주세요</h3>
								<div class="row">
									<div class="col-6">
										<div class="row">
											<div class="hex-container mb-4">
												<div class="hex m-4 mt-0 mb-0 d-flex justify-content-center">
													<svg fill="url(#gradient)" class="mt-4" width="90%" height="90%" viewBox="0 0 250 250" id="Flat" xmlns="http://www.w3.org/2000/svg">
														<defs>
															<linearGradient id="gradient" x1="0%" y1="0%" x2="0%" y2="100%">
															<stop offset="0%" style="stop-color: #C635ED;" />
															<stop offset="100%" style="stop-color: #955CE7;" />
															</linearGradient>
														</defs>
														<g id="SVGRepo_bgCarrier" stroke-width="0"></g>
														<g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
														<g id="SVGRepo_iconCarrier">
															<path d="M128,234.80127a12.00322,12.00322,0,0,1-5.90466-1.54395l-84-47.47827A12.01881,12.01881,0,0,1,32,175.33228V80.66772A12.019,12.019,0,0,1,38.09521,70.221l84.00013-47.47827a12.06282,12.06282,0,0,1,11.80932,0l84,47.47827A12.01881,12.01881,0,0,1,224,80.66772v94.66456a12.019,12.019,0,0,1-6.09521,10.44677l-84.00013,47.47827A12.00322,12.00322,0,0,1,128,234.80127Zm0-205.60889a4.00152,4.00152,0,0,0-1.96814.51465l-84,47.47827A4.00672,4.00672,0,0,0,40,80.66772v94.66456a4.00658,4.00658,0,0,0,2.032,3.48242L126.03186,226.293a4.0215,4.0215,0,0,0,3.93628,0l84-47.47827A4.00672,4.00672,0,0,0,216,175.33228V80.66772a4.00658,4.00658,0,0,0-2.032-3.48242L129.96814,29.707A4.00152,4.00152,0,0,0,128,29.19238Z"></path>
														</g>
													</svg>
													<div class="lines w-100">
														<div class="line l-one w-100"><svg width="93%" height="93%" viewBox="0 0 24.00 24.00" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="#bdbdbd" transform="rotate(0)"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <g id="Interface / Line_Xl"> <path id="Vector" d="M12 21V3" stroke="#a3a3a3" stroke-width="0.21600000000000003" stroke-linecap="round" stroke-linejoin="round"></path> </g> </g></svg></div>
														<div class="line l-two w-100" style="rotate: -74deg;"><svg width="93%" height="93%" viewBox="0 0 24.00 24.00" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="#bdbdbd" transform="rotate(-45)"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <g id="Interface / Line_Xl"> <path id="Vector" d="M12 21V3" stroke="#a3a3a3" stroke-width="0.21600000000000003" stroke-linecap="round" stroke-linejoin="round"></path> </g> </g></svg></div>
														<div class="line l-three w-100" style="rotate: 74deg;"><svg width="93%" height="93%" viewBox="0 0 24.00 24.00" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="#bdbdbd" transform="rotate(45)"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <g id="Interface / Line_Xl"> <path id="Vector" d="M12 21V3" stroke="#a3a3a3" stroke-width="0.21600000000000003" stroke-linecap="round" stroke-linejoin="round"></path> </g> </g></svg></div>
													</div>
													<canvas id="myChart"></canvas>
													<div class="hex-text first-hex-text w-100 d-flex justify-content-center">
														<div class="fs-4" onmouseenter="javascript:mouseEnter(this)">발열</div>
													</div>
													<div class="hex-text second-hex-text w-100 d-flex justify-content-between p-1">
														<div class="fs-4" onmouseenter="javascript:mouseEnter(this)">QC</div>
														<div class="fs-4" onmouseenter="javascript:mouseEnter(this)">소재</div>
													</div>
													<div class="hex-text third-hex-text w-100 d-flex justify-content-between ps-1">
														<div class="fs-4" onmouseenter="javascript:mouseEnter(this)">안정성</div>
														<div class="fs-4" onmouseenter="javascript:mouseEnter(this)">AS</div>
													</div>
													<div class="hex-text fourth-hex-text w-100 d-flex justify-content-center">
														<div class="fs-4" onmouseenter="javascript:mouseEnter(this)">소음</div>
													</div>
													<svg onclick="javascript:q4ClickReset()" class="reset-svg" fill="#000000" width="40px" height="40px" viewBox="-652.8 -652.8 3225.60 3225.60" xmlns="http://www.w3.org/2000/svg" stroke="#000000" stroke-width="65.28" transform="matrix(-1, 0, 0, -1, 0, 0)rotate(0)"><g id="SVGRepo_bgCarrier" stroke-width="0" transform="translate(0,0), scale(1)"><path transform="translate(-652.8, -652.8), scale(201.6)" fill="url(#gradient)" d="M9.166.33a2.25 2.25 0 00-2.332 0l-5.25 3.182A2.25 2.25 0 00.5 5.436v5.128a2.25 2.25 0 001.084 1.924l5.25 3.182a2.25 2.25 0 002.332 0l5.25-3.182a2.25 2.25 0 001.084-1.924V5.436a2.25 2.25 0 00-1.084-1.924L9.166.33z" strokewidth="0"></path></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round" stroke="#25b4dc " stroke-width="280.32"> <path d="M960 0v213.333c411.627 0 746.667 334.934 746.667 746.667S1371.627 1706.667 960 1706.667 213.333 1371.733 213.333 960c0-197.013 78.4-382.507 213.334-520.747v254.08H640V106.667H53.333V320h191.04C88.64 494.08 0 720.96 0 960c0 529.28 430.613 960 960 960s960-430.72 960-960S1489.387 0 960 0" fill-rule="evenodd"></path> </g><g id="SVGRepo_iconCarrier"> <path d="M960 0v213.333c411.627 0 746.667 334.934 746.667 746.667S1371.627 1706.667 960 1706.667 213.333 1371.733 213.333 960c0-197.013 78.4-382.507 213.334-520.747v254.08H640V106.667H53.333V320h191.04C88.64 494.08 0 720.96 0 960c0 529.28 430.613 960 960 960s960-430.72 960-960S1489.387 0 960 0" fill-rule="evenodd"></path> </g></svg>
												</div>
											</div>
										</div>
										<div class="row w-100 justify-content-center mt-3 ms-2 me-2 position-relative">
											<input type="range" class="form-range w-50" min="0" max="2" step="0.01" id="hex-val-total" onmouseenter="javascript:mouseEnter(this)" oninput="javascript:totalValue()">
											<label for="hex-val-total" class="form-label text-center ms-2" onmouseenter="javascript:mouseEnter(this)">가성비 <- 메인스트림 -> 프리미엄</label>
										</div>
									</div>
									<div class="col-6" id="hex-label">
										<div class="m-4 mt-0 mb-0">
											<div class="row">
												<div class="mb-3">
													<label for="explane-area" class="form-label fs-5">단어에 마우스를 올리면 이곳에 설명이 나옵니다!</label>
													<textarea class="form-control" id="explane-area" rows="15" disabled></textarea>
												</div>
											</div>
											<div class="row hex-input-type">
												<div class="col-6">
													<label for="hexFever" class="form-label w-100">
														<div class="input-group input-group">
															<span class="input-group-text w-50 justify-content-center" id="hex-form-01"><p class="pt-2 m-0" onmouseenter="javascript:mouseEnter(this)">발열</p></span>
															<input type="number" class="form-control text-center hex-input pt-3" aria-label="발열" aria-describedby="hex-form-01" id="hex-val-01" min="0.00" max="2.00" value="1.00" oninput="javascript:hexagonType()">
														</div>
													</label>
												</div>
												<div class="col-6">
													<label for="hexMaterial" class="form-label w-100">
														<div class="input-group input-group">
															<span class="input-group-text w-50 justify-content-center" id="hex-form-02"><p class="pt-2 m-0" onmouseenter="javascript:mouseEnter(this)">소재</p></span>
															<input type="number" class="form-control text-center hex-input pt-3" aria-label="소재" aria-describedby="hex-form-02" id="hex-val-02" min="0.00" max="2.00" value="1.00" oninput="javascript:hexagonType()">
														</div>
													</label>
												</div>
											</div>
											<div class="row">
												<div class="col-6">
													<label for="hexAs" class="form-label w-100">
														<div class="input-group input-group">
															<span class="input-group-text w-50 justify-content-center" id="hex-form-03"><p class="pt-2 m-0" onmouseenter="javascript:mouseEnter(this)">AS</p></span>
															<input type="number" class="form-control text-center hex-input pt-3" aria-label="AS" aria-describedby="hex-form-03" id="hex-val-03" min="0.00" max="2.00" value="1.00" oninput="javascript:hexagonType()">
														</div>
													</label>
												</div>
												<div class="col-6">
													<label for="hexNoise" class="form-label w-100">
														<div class="input-group input-group">
															<span class="input-group-text w-50 justify-content-center" id="hex-form-04"><p class="pt-2 m-0" onmouseenter="javascript:mouseEnter(this)">소음</p></span>
															<input type="number" class="form-control text-center hex-input pt-3" aria-label="소음" aria-describedby="hex-form-04" id="hex-val-04" min="0.00" max="2.00" value="1.00" oninput="javascript:hexagonType()">
														</div>
													</label>
												</div>
											</div>
											<div class="row">
												<div class="col-6">
													<label for="hexStability" class="form-label w-100">
														<div class="input-group input-group">
															<span class="input-group-text w-50 justify-content-center" id="hex-form-05"><p class="pt-2 m-0" onmouseenter="javascript:mouseEnter(this)">안정성</p></span>
															<input type="number" class="form-control text-center hex-input pt-3" aria-label="안정성" aria-describedby="hex-form-05" id="hex-val-05" min="0.00" max="2.00" value="1.00" oninput="javascript:hexagonType()">
														</div>
													</label>
												</div>
												<div class="col-6">
													<label for="hexQc" class="form-label w-100">
														<div class="input-group input-group">
															<span class="input-group-text w-50 justify-content-center" id="hex-form-06"><p class="pt-2 m-0" onmouseenter="javascript:mouseEnter(this)">QC</p></span>
															<input type="number" class="form-control text-center hex-input pt-3" aria-label="QC" aria-describedby="hex-form-06" id="hex-val-06" min="0.00" max="2.00" value="1.00" oninput="javascript:hexagonType()">
														</div>
													</label>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- 5번질문 -->
							<div class="q-5 fade">
								<h2 class="mt-4 d-flex justify-content-between">
									<span>질문 5번</span>
									<button class="btn btn-primary q5-save-btn" onclick="javascript:questionFiveSaveBtn()">저장</button>
								</h2>
								<h3 class="mt-3">WIFI, 블루투스 옵션이 포함된 PC가 필요하신가요?</h3>
								<div class="mt-3 mb-5 row">
									<div class="col-xxl-3">
										<input type="radio" class="btn-check" name="btnradio" id="q5-answer1">
										<label class="btn btn-outline-secondary w-75" for="q5-answer1" onclick="javascript:questionFiveBtn(this)"><p class="pt-1 m-0">필요합니다</p></label>
									</div>
									<div class="col-xxl-3">
										<input type="radio" class="btn-check" name="btnradio" id="q5-answer2">
										<label class="btn btn-outline-secondary w-75" for="q5-answer2" onclick="javascript:questionFiveBtn(this)"><p class="pt-1 m-0">필요없습니다</p></label>
									</div>
									<div class="col-md-6"></div>
								</div>
							</div>
							<!-- 6번질문 -->
							<div class="q-6 fade">
								<h2 class="mt-4 d-flex justify-content-between">
									<span>질문 6번</span>
									<button class="btn btn-primary q6-save-btn" onclick="javascript:questionSixSaveBtn()">저장</button>
								</h2>
								<h3 class="mt-3">선호하는 CPU 제조사를 선택해주세요</h3>
								<div class="mt-3 mb-5 row">
									<div class="col-xxl-2">
										<input type="radio" class="btn-check" name="btnradio" id="q6-answer1">
										<label class="btn btn-outline-secondary w-75" for="q6-answer1" onclick="javascript:questionSixBtn(this)"><p class="pt-1 m-0">Intel</p></label>
									</div>
									<div class="col-xxl-2">
										<input type="radio" class="btn-check" name="btnradio" id="q6-answer2">
										<label class="btn btn-outline-secondary w-75" for="q6-answer2" onclick="javascript:questionSixBtn(this)"><p class="pt-1 m-0">AMD</p></label>
									</div>
									<div class="col-xxl-2">
										<input type="radio" class="btn-check" name="btnradio" id="q6-answer3">
										<label class="btn btn-outline-secondary w-75" for="q6-answer3" onclick="javascript:questionSixBtn(this)"><p class="pt-1 m-0">상관없음</p></label>
									</div>
									<div class="col-md-6"></div>
								</div>
							</div>
							<!-- 7번질문 -->
							<div class="q-7 fade">
								<h2 class="mt-4 d-flex justify-content-between">
									<span>질문 7번</span>
									<button class="btn btn-primary q7-save-btn" onclick="javascript:questionSevenSaveBtn()">저장</button>
								</h2>
								<h3 class="mt-3">내장그래픽이 필요하십니까?</h3>
								<div class="mt-3 mb-5 row">
									<div class="col-xxl-2">
										<input type="radio" class="btn-check" name="btnradio" id="q7-answer1">
										<label class="btn btn-outline-secondary w-75" for="q7-answer1" onclick="javascript:questionSevenBtn(this)"><p class="pt-1 m-0">필요합니다</p></label>
									</div>
									<div class="col-xxl-2">
										<input type="radio" class="btn-check" name="btnradio" id="q7-answer2">
										<label class="btn btn-outline-secondary w-75" for="q7-answer2" onclick="javascript:questionSevenBtn(this)"><p class="pt-1 m-0">상관없음</p></label>
									</div>
									<div class="col-xxl-2">
										<input type="radio" class="btn-check" name="btnradio" id="q7-answer3">
										<label class="btn btn-outline-secondary w-75" for="q7-answer3" onclick="javascript:questionSevenBtn(this)"><p class="pt-1 m-0">필요없습니다</p></label>
									</div>
									<div class="col-md-6"></div>
								</div>
							</div>
							<!-- 8번질문 -->
							<div class="q-8 fade">
								<h2 class="mt-4 d-flex justify-content-between">
									<span>질문 8번</span>
									<button class="btn btn-primary q8-save-btn" onclick="javascript:questionEightSaveBtn()">저장</button>
								</h2>
								<h3 class="mt-3">수냉쿨러를 선호하십니까?</h3>
								<div class="mt-3 mb-5 row">
									<div class="col-xxl-2">
										<input type="radio" class="btn-check" name="btnradio" id="q8-answer1">
										<label class="btn btn-outline-secondary w-75 h-100" for="q8-answer1" onclick="javascript:questionEightBtn(this)"><p class="pt-1 m-0">선호합니다</p></label>
									</div>
									<div class="col-xxl-2">
										<input type="radio" class="btn-check" name="btnradio" id="q8-answer2">
										<label class="btn btn-outline-secondary w-75" for="q8-answer2" onclick="javascript:questionEightBtn(this)"><p class="pt-1 m-0">선호하지</br>않습니다</p></label>
									</div>
									<div class="col-xxl-2">
										<input type="radio" class="btn-check" name="btnradio" id="q8-answer3">
										<label class="btn btn-outline-secondary w-75 h-100" for="q8-answer3" onclick="javascript:questionEightBtn(this)"><p class="pt-1 m-0">상관없음</p></label>
									</div>
									<div class="col-md-6"></div>
								</div>
							</div>
							<!-- 9번질문 -->
							<!-- 10번질문 -->
							<!-- 11번질문 -->
							<!-- 12번질문 -->
							<!-- 13번질문 -->
							<!-- 14번질문 -->
							<!-- 15번질문 -->
							<!-- 16번질문 -->
							<!-- 17번질문 -->
							<!-- 18번질문 -->
							<!-- 19번질문 -->
							<!-- 20번질문 -->
						</div>
					</div>
				</div>
			</div>
			<!-- 빈 영역 -->
			<div class="side-empty" style="width: 10%!important;"></div>
		</div>
	</div>
	
	<%@ include file="./common/footer.jsp" %>
</body>
</html>
