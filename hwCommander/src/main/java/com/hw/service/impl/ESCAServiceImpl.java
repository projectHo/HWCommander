package com.hw.service.impl;

// 12.14 반올림 추가
import java.math.RoundingMode;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hw.dao.ProcessResourceDAO;
import com.hw.dao.ProductDAO;
import com.hw.model.EstimateCalculationResultPrivateDetailVO;
import com.hw.model.EstimateCalculationResultPrivateMasterVO;
import com.hw.model.PartsCaseHistoryVO;
import com.hw.model.PartsCaseVO;
import com.hw.model.PartsCoolerHistoryVO;
import com.hw.model.PartsCoolerVO;
import com.hw.model.PartsCpuHistoryVO;
import com.hw.model.PartsCpuVO;
import com.hw.model.PartsGpuHistoryVO;
import com.hw.model.PartsGpuVO;
import com.hw.model.PartsHddHistoryVO;
import com.hw.model.PartsMakerHistoryVO;
import com.hw.model.PartsMbHistoryVO;
import com.hw.model.PartsMbVO;
import com.hw.model.PartsPsuHistoryVO;
import com.hw.model.PartsPsuVO;
import com.hw.model.PartsRamHistoryVO;
import com.hw.model.PartsRamVO;
import com.hw.model.PartsSfHistoryVO;
import com.hw.model.PartsSsdHistoryVO;
import com.hw.model.PartsSsdVO;
import com.hw.model.ProcessResourceDetailHistoryVO;
import com.hw.model.ProductDetailVO;
import com.hw.model.ProductMasterVO;
import com.hw.service.ESCAService;
import com.hw.service.PartsService;
import com.hw.service.ProductService;

@Service
public class ESCAServiceImpl implements ESCAService {
	
	@Autowired
    private ProductDAO productDAO;
	
	@Autowired
    private ProcessResourceDAO processResourceDAO;
	
	@Autowired
    private PartsService partsService;
	
	/*--------------------------------------------------
	 - 견적산출로직
	 - Ver1.0
	*--------------------------------------------------*/
	@Override
	public EstimateCalculationResultPrivateMasterVO ESCA_VER_1_0(String urlText) {
		EstimateCalculationResultPrivateMasterVO estimateCalculationResultPrivateMasterVO = new EstimateCalculationResultPrivateMasterVO();
		estimateCalculationResultPrivateMasterVO.setErrChk(false); // 기본값 err false
		
		BigDecimal loopCnt = BigDecimal.ZERO;
		
		//임시로 적용(복수선택에서 무조건 복수)
//		urlText = "answer1<Price,3000000>|answer2<PR000003,60:PR000002,30:PR000001,10>|answer3<Fever,1.111:Meterial,1.222:AS,1.333:Noise,1.444:Stability,1.555:QC,1.666>|answer4<Wireless,0>|answer5<CPU,1>|answer6<GPU,1>|answer7<Aio,2>|answer8<main-color,:sub-color,>|answer9<RAM,1>|answer10<Bulk,2>|answer11<Ssd,3>|answer12<Metarial,[\"1\",\"4\",\"3\"]>|answer13<HDD,4:3>|answer14<Window,2>|answer15<Fan,1>|answer16<LED,[\"0\",\"2\"]>|answer17<null,null>|answer18<null,null>|answer19<null,null>|answer20<null,null>|etc<userId,root> |etc<targetDate,null>";

		// 임시로 적용(복수선택에서 무조건 단일선택)
//		urlText = "answer1<Price,3000000>|answer2<PR000003,100>|answer3<Fever,1.1:Meterial,1.2:AS,1.3:Noise,1.4:Stability,1.5:QC,1.6>|answer4<Wireless,1>|answer5<CPU,2>|answer6<GPU,2>|answer7<Aio,2>|answer8<main-color,:sub-color,>|answer9<RAM,2>|answer10<Bulk,3>|answer11<Ssd,3>|answer12<Metarial,["5"]>|answer13<HDD,5:null>|answer14<Window,2>|answer15<Fan,2>|answer16<LED,["3"]>|answer17<null,null>|answer18<null,null>|answer19<null,null>|answer20<null,null>|etc<userId,root> |etc<targetDate,null>";
		
		// 1, 2번 질문만 답변했을 때
		// 1번 5억이라고 일단 두자.. 제품이 걸러지니까..
		//urlText = "answer1<Price,500000000>|answer2<PR000003,100>|answer3<Fever,:Meterial,:AS,:Noise,:Stability,:QC,>|answer4<Wireless>|answer5<CPU>|answer6<GPU>|answer7<Aio>|answer8<main-color,:sub-color,>|answer9<RAM>|answer10<Bulk>|answer11<Ssd>|answer12<Metarial>|answer13<HDD>|answer14<Window>|answer15<Fan>|answer16<LED>|answer17<null,null>|answer18<null,null>|answer19<null,null>|answer20<null,null>|etc<userId,root>|etc<targetDate,null>";
		
		/*--------------------------------------------------
		 - 0. 견적산출 대상  List 선언 및 초기화
		*--------------------------------------------------*/
		List<PartsGpuHistoryVO> partsGpuHistoryVOList = null;
		List<PartsCpuHistoryVO> partsCpuHistoryVOList = null;
		List<PartsMbHistoryVO> partsMbHistoryVOList = null;
		List<PartsRamHistoryVO> partsRamHistoryVOList = null;
		List<PartsPsuHistoryVO> partsPsuHistoryVOList = null;
		List<PartsCaseHistoryVO> partsCaseHistoryVOList = null;
		List<PartsCoolerHistoryVO> partsCoolerHistoryVOList = null;
		List<PartsHddHistoryVO> partsHddHistoryVOList = null;
		List<PartsSsdHistoryVO> partsSsdHistoryVOList = null;
		List<PartsSfHistoryVO> partsSfHistoryVOList = null;
		List<PartsMakerHistoryVO> partsMakerHistoryVOList = null;
		List<ProcessResourceDetailHistoryVO> processResourceDetailHistoryVOList = null;
		
		/*--------------------------------------------------
		 - 0-1. 견적산출질문에 대한 답변 데이터 변수 선언 및 초기화
		*--------------------------------------------------*/
		BigDecimal answer1 = BigDecimal.ZERO;
		List<Map<String, String>> answer2 = new ArrayList<>();
		Map<String, BigDecimal> answer3 = new HashMap<>();
		Integer answer4 = null;
		Integer answer5 = null;
		Integer answer6 = null;
		Integer answer7 = null;
		List<Map<String, String>> answer8 = new ArrayList<>(); // 미구현이라고 함.
		Integer answer9 = null;
		Integer answer10 = null;
		Integer answer11 = null;
		Integer[] answer12 = null;
		Integer[] answer13 = null;
		Integer answer14 = null;
		Integer[] answer15 = null;
		List<Map<String, String>> answer16 = new ArrayList<>(); //프론트 미구현
		List<Map<String, String>> answer17 = new ArrayList<>(); //프론트 미구현
		List<Map<String, String>> answer18 = new ArrayList<>(); //프론트 미구현
		List<Map<String, String>> answer19 = new ArrayList<>(); //프론트 미구현
		
		// 업무공백 중 발생한 수정사항 질문 0번 추가
		Integer answer0 = null;
		String windowsName = null;
		int windowsPrice = 0;
		
		/*--------------------------------------------------
		 - 0-2. 견적산출 대상 시간 선언 및 초기화
		*--------------------------------------------------*/
		String targetDate = null;
		
		/*--------------------------------------------------
		 - 0-3. 견적산출 대상 유저 id 선언 및 초기화
		*--------------------------------------------------*/
		String targetUserId = null;
		
		/*--------------------------------------------------
		 - 0-4. 견적산출화면으로부터 넘어온 text 데이터화
		*--------------------------------------------------*/
		String[] urlTextArray = urlText.split("\\|");
		
		// 질문 19개, 견적산출 대상 유저id, 견적산출 대상시간, 0번질문 추가로 도합 22가 아닐 시 에러 return
		if(22 != urlTextArray.length) {
			String errMsg = "########## 견적산출 ERROR : 질문답변갯수가 안맞음 ㄲㅈ셈";
			
			System.out.println(errMsg);
			estimateCalculationResultPrivateMasterVO.setErrChk(true);
			estimateCalculationResultPrivateMasterVO.setErrMsg(errMsg);
			
			return estimateCalculationResultPrivateMasterVO;
		}
		
		// 1번질문
		String tempText = urlTextArray[0];
		tempText = tempText.replaceAll(" ", "");
		tempText = tempText.replaceAll("answer1", "");
		tempText = tempText.replaceAll("<", "");
		tempText = tempText.replaceAll(">", "");
		
		String[] nameValueArray = tempText.split(",");
		
		if(2 != nameValueArray.length) {
			String errMsg = "########## 견적산출 ERROR : 1번질문에 대한 답변데이터가 정상적으로 전달되지 않음";
			
			System.out.println(errMsg);
			estimateCalculationResultPrivateMasterVO.setErrChk(true);
			estimateCalculationResultPrivateMasterVO.setErrMsg(errMsg);
			
			return estimateCalculationResultPrivateMasterVO;
		}else {
			answer1 = new BigDecimal(nameValueArray[1]);
		}
		
		// 2번질문
		tempText = urlTextArray[1];
		tempText = tempText.replaceAll(" ", "");
		tempText = tempText.replaceAll("answer2", "");
		tempText = tempText.replaceAll("<", "");
		tempText = tempText.replaceAll(">", "");
		
		nameValueArray = tempText.split(":");
		
		if(1 > nameValueArray.length) {
			String errMsg = "########## 견적산출 ERROR : 2번질문에 대한 답변이 1개보다 적음";
			
			System.out.println(errMsg);
			estimateCalculationResultPrivateMasterVO.setErrChk(true);
			estimateCalculationResultPrivateMasterVO.setErrMsg(errMsg);
			
			return estimateCalculationResultPrivateMasterVO;
		}else {
			for(int i = 0; i < nameValueArray.length; i++) {
				String tempArray[] = nameValueArray[i].split(",");
				if(2 == tempArray.length) {
					Map<String, String> tempMap = new HashMap<>();
					tempMap.put("pr_id", tempArray[0]);
					tempMap.put("scale", tempArray[1]);
					answer2.add(tempMap);
				}
			}
		}
		
		
		if(0 == answer2.size()) {
			String errMsg = "########## 견적산출 ERROR : 2번질문 답변데이터가 없습니다.";
			
			System.out.println(errMsg);
			estimateCalculationResultPrivateMasterVO.setErrChk(true);
			estimateCalculationResultPrivateMasterVO.setErrMsg(errMsg);
			
			return estimateCalculationResultPrivateMasterVO;
		}
		
		// 3번질문
		tempText = urlTextArray[2];
		tempText = tempText.replaceAll(" ", "");
		
		// 답변을 하지 않았을 때 Front에서 넘기는 기본텍스트값
//		if(!"answer3<Fever,:Meterial,:AS,:Noise,:Stability,:QC,>".equals(tempText)) {
		if(!"answer3<Fever,null:Meterial,null:AS,null:Noise,null:Stability,null:QC,null>".equals(tempText)) {
			
			tempText = tempText.replaceAll("answer3", "");
			tempText = tempText.replaceAll("<", "");
			tempText = tempText.replaceAll(">", "");
			
			String[] tempTextArray = tempText.split(":");
			
			for(int i = 0; i < tempTextArray.length; i++) {
				String forText = tempTextArray[i];
				nameValueArray = forText.split(",");
				if(2 == nameValueArray.length) {
					answer3.put(nameValueArray[0], new BigDecimal(nameValueArray[1]));
				}
			}
		}else {
			// 답변 안했으면 null로 초기화
			answer3 = null;
		}
		
		// 4번질문
		tempText = urlTextArray[3];
		tempText = tempText.replaceAll(" ", "");
		
		// 답변을 하지 않았을 때 Front에서 넘기는 기본텍스트값
//		if(!"answer4<Wireless>".equals(tempText)) {
		if(!"answer4<Wireless,null>".equals(tempText)) {
			tempText = tempText.replaceAll("answer4", "");
			tempText = tempText.replaceAll("<", "");
			tempText = tempText.replaceAll(">", "");
			
			nameValueArray = tempText.split(",");
			
			answer4 = Integer.parseInt(nameValueArray[1]);
		}

		// 5번질문
		tempText = urlTextArray[4];
		tempText = tempText.replaceAll(" ", "");
		
		// 답변을 하지 않았을 때 Front에서 넘기는 기본텍스트값
//		if(!"answer5<CPU>".equals(tempText)) {
		if(!"answer5<CPU,null>".equals(tempText)) {
			tempText = tempText.replaceAll("answer5", "");
			tempText = tempText.replaceAll("<", "");
			tempText = tempText.replaceAll(">", "");
			
			nameValueArray = tempText.split(",");
			
			answer5 = Integer.parseInt(nameValueArray[1]);
		}
		
		// 6번질문
		tempText = urlTextArray[5];
		tempText = tempText.replaceAll(" ", "");
		
		// 답변을 하지 않았을 때 Front에서 넘기는 기본텍스트값
//		if(!"answer6<GPU>".equals(tempText)) {
		if(!"answer6<GPU,null>".equals(tempText)) {

			tempText = tempText.replaceAll("answer6", "");
			tempText = tempText.replaceAll("<", "");
			tempText = tempText.replaceAll(">", "");
			
			nameValueArray = tempText.split(",");
			
			answer6 = Integer.parseInt(nameValueArray[1]);
		}
		
		// 7번질문
		tempText = urlTextArray[6];
		tempText = tempText.replaceAll(" ", "");
		
		// 답변을 하지 않았을 때 Front에서 넘기는 기본텍스트값
//		if(!"answer7<Aio>".equals(tempText)) {
		if(!"answer7<Aio,null>".equals(tempText)) {

			tempText = tempText.replaceAll("answer7", "");
			tempText = tempText.replaceAll("<", "");
			tempText = tempText.replaceAll(">", "");
			
			nameValueArray = tempText.split(",");
			
			answer7 = Integer.parseInt(nameValueArray[1]);
		}
		
		// 8번질문 (미구현)
		if(!"answer8<main-color,null:sub-color,null>".equals(tempText)) {
		}
		
		// 9번질문
		tempText = urlTextArray[8];
		tempText = tempText.replaceAll(" ", "");
		
		// 답변을 하지 않았을 때 Front에서 넘기는 기본텍스트값
//		if(!"answer9<RAM>".equals(tempText)) {
		if(!"answer9<RAM,null>".equals(tempText)) {

			tempText = tempText.replaceAll("answer9", "");
			tempText = tempText.replaceAll("<", "");
			tempText = tempText.replaceAll(">", "");
			
			nameValueArray = tempText.split(",");
			
			answer9 = Integer.parseInt(nameValueArray[1]);
		}
		
		// 10번질문
		tempText = urlTextArray[9];
		tempText = tempText.replaceAll(" ", "");
		
		// 답변을 하지 않았을 때 Front에서 넘기는 기본텍스트값
//		if(!"answer10<Bulk>".equals(tempText)) {
		if(!"answer10<Bulk,null>".equals(tempText)) {

			tempText = tempText.replaceAll("answer10", "");
			tempText = tempText.replaceAll("<", "");
			tempText = tempText.replaceAll(">", "");
			
			nameValueArray = tempText.split(",");
			
			answer10 = Integer.parseInt(nameValueArray[1]);
		}
		
		// 11번질문
		tempText = urlTextArray[10];
		tempText = tempText.replaceAll(" ", "");
		
		// 답변을 하지 않았을 때 Front에서 넘기는 기본텍스트값
//		if(!"answer11<Ssd>".equals(tempText)) {
		if(!"answer11<Ssd,null>".equals(tempText)) {

			tempText = tempText.replaceAll("answer11", "");
			tempText = tempText.replaceAll("<", "");
			tempText = tempText.replaceAll(">", "");
			
			nameValueArray = tempText.split(",");
			
			answer11 = Integer.parseInt(nameValueArray[1]);
		}
		
		
		// 12번질문
		tempText = urlTextArray[11];
		tempText = tempText.replaceAll(" ", "");
		
		// 답변을 하지 않았을 때 Front에서 넘기는 기본텍스트값
//		if(!"answer12<Metarial>".equals(tempText)) {
		if(!"answer12<Metarial,null>".equals(tempText)) {

			tempText = tempText.replaceAll("answer12", "");
			tempText = tempText.replaceAll("<Metarial,", "");
			tempText = tempText.replaceAll(">", "");
			tempText = tempText.replaceAll("\\[", "");
			tempText = tempText.replaceAll("\\]", "");
			tempText = tempText.replaceAll("\"", "");
			
			nameValueArray = tempText.split(",");
			
			String[] tempTextArray = nameValueArray;
			answer12 = new Integer[tempTextArray.length];
			for(int i = 0; i < tempTextArray.length; i++) {
				answer12[i] = Integer.parseInt(tempTextArray[i]);
			}
		}
		
		
		// 13번질문
		tempText = urlTextArray[12];
		tempText = tempText.replaceAll(" ", "");
		
		// 답변을 하지 않았을 때 Front에서 넘기는 기본텍스트값
//		if(!"answer13<HDD>".equals(tempText)) {
		if(!"answer13<HDD,null>".equals(tempText)) {

			tempText = tempText.replaceAll("answer13", "");
			tempText = tempText.replaceAll("<HDD,", "");
			tempText = tempText.replaceAll(">", "");
			
			nameValueArray = tempText.split(":");
			
			if(2 != nameValueArray.length) {
				String errMsg = "########## 견적산출 ERROR : 13번질문에 대한 답변값이 2개가 아님(필요없음일 시 null 전송)";
				
				System.out.println(errMsg);
				estimateCalculationResultPrivateMasterVO.setErrChk(true);
				estimateCalculationResultPrivateMasterVO.setErrMsg(errMsg);
				
				return estimateCalculationResultPrivateMasterVO;
			}else {
				String[] tempTextArray = nameValueArray;
				answer13 = new Integer[tempTextArray.length];
				for(int i = 0; i < tempTextArray.length; i++) {
					answer13[i] = Integer.parseInt(tempTextArray[i]);
				}
			}
		}
		
		// 14번질문
		tempText = urlTextArray[13];
		tempText = tempText.replaceAll(" ", "");
		
		// 답변을 하지 않았을 때 Front에서 넘기는 기본텍스트값
//		if(!"answer14<Fan>".equals(tempText)) {
		if(!"answer14<Fan,null>".equals(tempText)) {

			tempText = tempText.replaceAll("answer14", "");
			tempText = tempText.replaceAll("<", "");
			tempText = tempText.replaceAll(">", "");
			
			nameValueArray = tempText.split(",");
			
			answer14 = Integer.parseInt(nameValueArray[1]);
		}
		
		// 15번질문
		
		tempText = urlTextArray[14];
		tempText = tempText.replaceAll(" ", "");
		
		// 답변을 하지 않았을 때 Front에서 넘기는 기본텍스트값
//		if(!"answer15<LED>".equals(tempText)) {
		if(!"answer15<LED,null>".equals(tempText)) {

			tempText = tempText.replaceAll("answer16", "");
			tempText = tempText.replaceAll("<LED,", "");
			tempText = tempText.replaceAll(">", "");
			tempText = tempText.replaceAll("\\[", "");
			tempText = tempText.replaceAll("\\]", "");
			tempText = tempText.replaceAll("\"", "");
			
			nameValueArray = tempText.split(",");
			
			String[] tempTextArray = nameValueArray;
			answer15 = new Integer[tempTextArray.length];
			for(int i = 0; i < tempTextArray.length; i++) {
				answer15[i] = Integer.parseInt(tempTextArray[i]);
			}
		}
		// 16번질문

		// 17번질문
		
		// 18번질문
		
		// 19번질문
		
		// 20번질문
		
		// etc(userId) index=19
		tempText = urlTextArray[19];
		tempText = tempText.replaceAll(" ", "");
		
		tempText = tempText.replaceAll("etc", "");
		tempText = tempText.replaceAll("<", "");
		tempText = tempText.replaceAll(">", "");
		
		nameValueArray = tempText.split(",");
		
		if(2 != nameValueArray.length) {
			String errMsg = "########## 견적산출 ERROR : userId 데이터전송 오류";
			
			System.out.println(errMsg);
			estimateCalculationResultPrivateMasterVO.setErrChk(true);
			estimateCalculationResultPrivateMasterVO.setErrMsg(errMsg);
			
			return estimateCalculationResultPrivateMasterVO;
		}else {
			targetUserId = nameValueArray[1];
		}
	
		// etc(targetDate) index=20
		tempText = urlTextArray[20];
		tempText = tempText.replaceAll(" ", "");
		
		tempText = tempText.replaceAll("etc", "");
		tempText = tempText.replaceAll("<", "");
		tempText = tempText.replaceAll(">", "");
		
		nameValueArray = tempText.split(",");
		
		if(2 != nameValueArray.length) {
			String errMsg = "########## 견적산출 ERROR : targetDate 데이터전송 오류";
			
			System.out.println(errMsg);
			estimateCalculationResultPrivateMasterVO.setErrChk(true);
			estimateCalculationResultPrivateMasterVO.setErrMsg(errMsg);
			
			return estimateCalculationResultPrivateMasterVO;
		}else {
			// 과거 견적산출로부터 넘어오지 않을 경우 문자열 "null"을 화면에서 뿌림.
			// 일반 견적산출이면 날짜는 targetDate = "null", 과거견적산출이면 targetDate에 반영
			// ex) '2023-07-25 23:10:22'
			if(!"null".equals(nameValueArray[1])) {
				targetDate = nameValueArray[1];
			}
		}
		
		// 업무공백 중 발생한 수정사항 질문 0번 추가
		tempText = urlTextArray[21];
		tempText = tempText.replaceAll(" ", "");
		tempText = tempText.replaceAll("answer0", "");
		tempText = tempText.replaceAll("<", "");
		tempText = tempText.replaceAll(">", "");
		
		nameValueArray = tempText.split(",");
		
		if(2 != nameValueArray.length) {
			String errMsg = "########## 견적산출 ERROR : 0번질문에 대한 답변데이터가 정상적으로 전달되지 않음";
			
			System.out.println(errMsg);
			estimateCalculationResultPrivateMasterVO.setErrChk(true);
			estimateCalculationResultPrivateMasterVO.setErrMsg(errMsg);
			
			return estimateCalculationResultPrivateMasterVO;
		}else {
			answer0 = Integer.parseInt(nameValueArray[1]);
		}
		
		
		/*--------------------------------------------------
		 - 0-5. 견적산출 대상  List 조회(각 부품 별 History 테이블 참조)
		*--------------------------------------------------*/
		partsGpuHistoryVOList = productDAO.getGpuHistoryAllListByTargetDate(targetDate);
		partsCpuHistoryVOList = productDAO.getCpuHistoryAllListByTargetDate(targetDate);
		partsMbHistoryVOList = productDAO.getMbHistoryAllListByTargetDate(targetDate);
		partsRamHistoryVOList = productDAO.getRamHistoryAllListByTargetDate(targetDate);
		partsPsuHistoryVOList = productDAO.getPsuHistoryAllListByTargetDate(targetDate);
		partsCaseHistoryVOList = productDAO.getCaseHistoryAllListByTargetDate(targetDate);
		partsCoolerHistoryVOList = productDAO.getCoolerHistoryAllListByTargetDate(targetDate);
		partsHddHistoryVOList = productDAO.getHddHistoryAllListByTargetDate(targetDate);
		partsSsdHistoryVOList = productDAO.getSsdHistoryAllListByTargetDate(targetDate);
		partsSfHistoryVOList = productDAO.getSfHistoryAllListByTargetDate(targetDate);
		partsMakerHistoryVOList = productDAO.getMakerHistoryAllListByTargetDate(targetDate);
		processResourceDetailHistoryVOList = processResourceDAO.getProcessResourceDetailHistoryAllListByTargetDate(targetDate);
		
		/*--------------------------------------------------
		 - 여기부터 견적산출 알고리즘  by-이해창 23.07.21
		 - 1. 다음 인수를 선언한다.
		 - α=1(gpu), β=1(cpu), γ=1(mb), k=1(cooler), p=1(case), q=1(psu), x=1(ram), y=1(ssd), ω=1(견적저장량)
		 - Variable Cost = VC = 1번질문의 예산 대입
		 - 3번 질문에 답변하지 않았을 경우 아래 5개의 수치는 1으로 등록한다.
		 - CQC = 유저 QC점수
		 - CSFT = 유저 안정성 점수
		 - CTH = 유저 발열 점수
		 - CAS = 유저 AS점수
		 - CMT = 유저 소재 점수
		*--------------------------------------------------*/
//		[이해창] [오후 4:25] 인덱스가 0부터 시작하죠 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ
//		[이해창] [오후 4:25] 이해했어요 저게 맞아요 그럼
//		[이해창] [오후 4:25] 전 인덱스가 1부터 시작한다고 생각하고 작성한거에요
		// 23.07.30 알고리즘 12번 근거로 초기값 변경처리함. 
		int α = 0;
		int β = 0;
		int γ = 0;
		int k = 0;
		int p = 0;
		int q = 0;
		int x = 0;
		int y = 0;
//		int ω = 0;
		// model object 생성 후 List로 저장하는 방식이 결과 추출하기 용이함.
		List<EstimateCalculationResultPrivateDetailVO> ω = new ArrayList<>();
		
		// 프론트에서 만단위 곱해서 보내주기때문에 백엔드에서 만단위 나눠서 대입함.
//		BigDecimal VC = answer1.divide(new BigDecimal("10000"));
		
//		07.29 VC와 Price 일원화 하기로 함 프론트에서 만 단위 곱해서 보내준 수 그대로 쓰기로 함.
		BigDecimal VC = answer1;
		
		BigDecimal CQC = new BigDecimal(1);
		BigDecimal CSFT = new BigDecimal(1);
		BigDecimal CTH = new BigDecimal(1);
		BigDecimal CAS = new BigDecimal(1);
		BigDecimal CMT = new BigDecimal(1);
		
		// 업무공백 중 발생한 수정사항 질문 0번 추가
		if(answer0 == 0) {
			windowsName = "프리도스";
			windowsPrice = 0;
		}else if(answer0 == 1) {
			windowsName = "COEM";
			windowsPrice = 150000;
			VC = VC.subtract(new BigDecimal(windowsPrice));
		}else {
			// answer0 == 2
			windowsName = "FPP";
			windowsPrice = 180000;
			VC = VC.subtract(new BigDecimal(windowsPrice));
		}
		
		// 3번질문 답변했을경우 세팅
		if(null != answer3) {
			//answer3<Fever,1.111:Meterial,1.222:AS,1.333:Noise,1.444:Stability,1.555:QC,1.666>
			// 발열, 소재, as, 소음, 안전성, qc
			// CTH, CMT, CAS, CSFT, CQC
			
			CQC = answer3.get("QC");
			CSFT = answer3.get("Stability");
			CTH = answer3.get("Fever");
			CAS = answer3.get("AS");
			CMT = answer3.get("Meterial");
			// 07.29 소음수치 beta에서 배제한다고 함.
//			?? = answer3.get("Noise");
		}
		
		/*--------------------------------------------------
		 - 2. 클라이언트가 4번에 답변하였을 경우 MB의 Wifi 값이 0(아니오)/1(네)인 MB제품을 
		 - 제외하곤 모든 MB제품을 소거한다.
		*--------------------------------------------------*/
		// 질문 
		// WIFI, 블루투스 옵션이 포함된 PC가 필요하신가요?
		// Front data 
		// answer4 -> 블루투스or와이파이 / 네! 필요해요!(0) , 아뇨! 필요없어요!(1) (최소 1개)
		
		// DB Column wifi(INT)
		// 0 없음
		// 1 있음
		
		if(null != answer4) {
			int checkWifiValue = 0;
			// Front에서는 1이 필요없음이고 0이 필요하다여서 실 DB 데이터에서는 1이 wifi 있는 제품이라 체크변수로 변환하여 동기화한다.
			if(0 == answer4) {
				checkWifiValue = 1;
			}
			
			// 변환결과 check 0 = 필요없음 / 1 = 필요함.
			for(int i = partsMbHistoryVOList.size()-1; i >= 0; i--) {
				if(checkWifiValue != partsMbHistoryVOList.get(i).getWifi()) {
					partsMbHistoryVOList.remove(i);
				}
			}
		}
		
		/*--------------------------------------------------
		 - 3. 클라이언트가 5번에 답변하였을 경우 CPU의 I/A값이 Intel(Intel)/AMD(AMD)
		 - /관계없음(상관없음)인 CPU제품을 제외하곤 모든 CPU제품을 소거한다.
		*--------------------------------------------------*/
		// 질문
		// 원하는 CPU 제조사가 있나요?
		// Front data 
		// answer5 -> cpu제조사 / Intel(0) , AMD(1) , 상관없음 혹은 잘 모름(2) (최소 1개)
		
		// DB Column ia_cd(VARCHAR 2, Code)
		// PRT009 : IA
		// 01 Intel
		// 02 AMD
		
		if(null != answer5 && 2 != answer5) {
			String checkIACodeValue = "01";
			if(1 == answer5) {
				checkIACodeValue = "02";
			}
			
			for(int i = partsCpuHistoryVOList.size()-1; i >= 0; i--) {
				if(!checkIACodeValue.equals(partsCpuHistoryVOList.get(i).getIaCd())) {
					partsCpuHistoryVOList.remove(i);
				}
			}
		}
		
		/*--------------------------------------------------
		 - 4. 클라이언트가 6번에 답변하였을 경우 CPU의 APU값이 0이 아닌(필요함)
		 - /관계없는(상관없음)/0인(필요하지 않음)인 CPU제품을 제외하곤 모든 CPU제품을
		 - 소거한다.
		*--------------------------------------------------*/
		// 질문
		// 내장그래픽이 필요하신가요?
		// Front data 
		// answer6 -> gpu(내장그래픽) / 필요합니다(0) , 필요하지 않아요(1) , 상관없어요(2) (최소 1개)
		
		// DB Column apu(VARCHAR 200)
		// 관리자 입력값
		
		if(null != answer6 && 2 != answer6) {
			for(int i = partsCpuHistoryVOList.size()-1; i >= 0; i--) {
				String apu = partsCpuHistoryVOList.get(i).getApu();
				
				// 관리자 과실 null check
				if(null == apu) {
					String errMsg = "########## 견적산출 ERROR : CPU ID "+partsCpuHistoryVOList.get(i).getId()+" 인 제품의 APU 정보가 null check 오류를 발생시켰습니다.";
					
					System.out.println(errMsg);
					estimateCalculationResultPrivateMasterVO.setErrChk(true);
					estimateCalculationResultPrivateMasterVO.setErrMsg(errMsg);
					
					return estimateCalculationResultPrivateMasterVO;
				}else {
					// 필요
					if(0 == answer6) {
						if("0".equals(apu)) {
							partsCpuHistoryVOList.remove(i);
						}
					}else if(1 == answer6) {
						if(!"0".equals(apu)) {
							partsCpuHistoryVOList.remove(i);
						}
					}
				}
			}
		}
		
		
		/*--------------------------------------------------
		 - 5. 클라이언트가 7번에 답변하였을 경우 Cooler의 AC/WC값이 AC(싫어요)/WC(좋아요)
		 - /관계없음(상관없음)인 Cooler제품을 제외하곤 모든 Cooler제품을 소거한다.
		*--------------------------------------------------*/
		// 질문
		// 수냉쿨러를 선호하시나요?
		// Front data 
		// answer7 -> Aio(수냉쿨러) / 좋아요!(0) , 싫어요!(1) , 상관없어요!(2) (최소 1개)
		
		// DB Column formula_cd(VARCHAR 2, Code)
		// PRT020 : formula
		// 01 AC
		// 02 WC
		
		if(null != answer7 && 2 != answer7) {
			String checkFormulaCodeValue = "01";
			
			if(0 == answer7) {
				checkFormulaCodeValue = "02";
			}
			
			for(int i = partsCoolerHistoryVOList.size()-1; i >= 0; i--) {
				if(!checkFormulaCodeValue.equals(partsCoolerHistoryVOList.get(i).getFormulaCd())) {
					partsCoolerHistoryVOList.remove(i);
				}
			}
		}
		
		/*--------------------------------------------------
		 - 6. 클라이언트가 9번에 답변하였을 경우 MB의 Mem Soc수치가 4(DDR4)/5(DDR5)
		 - /관계없음(상관없음)인 MB제품을 제외하곤 모든 MB제품을 소거한다.
		*--------------------------------------------------*/
		// 질문
		// 메모리(램)카드의 버전을 DDR4, DDR5 중에서 골라주세요!
		// Front data 
		// answer9 -> ram / DDR4(0) , DDR5(1) , 상관 없음(2) (최소 1개)
		
		// DB Column mem_soc_cd(VARCHAR 2, Code)
		// PRT024 : MEM SOC
		// 01 DDR2
		// 02 DDR3
		// 03 DDR4
		// 04 DDR5
		
		if(null != answer9 && 2 != answer9) {
			String checkMemSocCodeValue = "";
			
			if(0 == answer9) {
				checkMemSocCodeValue = "03";
			}else if(1 == answer9) {
				checkMemSocCodeValue = "04";
			}
			
			for(int i = partsMbHistoryVOList.size()-1; i >= 0; i--) {
				if(!checkMemSocCodeValue.equals(partsMbHistoryVOList.get(i).getMemSocCd())) {
					partsMbHistoryVOList.remove(i);
				}
			}
		}
		
		/*--------------------------------------------------
		 - 7. 클라이언트가 10번에 답변하였을 경우 MTBK값이 0혹은 2(벌크)/0혹은 1(멀티팩)
		 - /상관없음(둘다 좋음)/0(둘다 싫음)인 제품을 제외하곤 모든 제품을 소거한다.
		*--------------------------------------------------*/
		// 질문
		// 벌크나 멀티팩을 선호 하시나요?
		// Front data 
		// answer10 -> 벌크 혹은 멀티팩 / 벌크(0) , 멀티팩(1) , 둘다 좋음(2) , 둘다 싫음(3) (최소 1개)
		
		// DB Column multi_bulk(INT)
		// 관리자 입력값
		
		if(null != answer10 && 2 != answer10) {
			int checkMTBKValue = 2;
			
			if(1 == answer10) {
				checkMTBKValue = 1;
			}else if(3 == answer10) {
				checkMTBKValue = 0;
			}
			
			// 모든제품 for 돌려야함.
			for(int i = partsGpuHistoryVOList.size()-1; i >= 0; i--) {
				if(0 != partsGpuHistoryVOList.get(i).getMultiBulk()
						&& checkMTBKValue != partsGpuHistoryVOList.get(i).getMultiBulk()) {
					partsGpuHistoryVOList.remove(i);
				}
			}
			
			for(int i = partsCpuHistoryVOList.size()-1; i >= 0; i--) {
				if(0 != partsCpuHistoryVOList.get(i).getMultiBulk()
						&& checkMTBKValue != partsCpuHistoryVOList.get(i).getMultiBulk()) {
					partsCpuHistoryVOList.remove(i);
				}
			}
			
			for(int i = partsMbHistoryVOList.size()-1; i >= 0; i--) {
				if(0 != partsMbHistoryVOList.get(i).getMultiBulk()
						&& checkMTBKValue != partsMbHistoryVOList.get(i).getMultiBulk()) {
					partsMbHistoryVOList.remove(i);
				}
			}
			
			for(int i = partsRamHistoryVOList.size()-1; i >= 0; i--) {
				if(0 != partsRamHistoryVOList.get(i).getMultiBulk()
						&& checkMTBKValue != partsRamHistoryVOList.get(i).getMultiBulk()) {
					partsRamHistoryVOList.remove(i);
				}
			}
			
			for(int i = partsPsuHistoryVOList.size()-1; i >= 0; i--) {
				if(0 != partsPsuHistoryVOList.get(i).getMultiBulk()
						&& checkMTBKValue != partsPsuHistoryVOList.get(i).getMultiBulk()) {
					partsPsuHistoryVOList.remove(i);
				}
			}
			
			for(int i = partsCaseHistoryVOList.size()-1; i >= 0; i--) {
				if(0 != partsCaseHistoryVOList.get(i).getMultiBulk()
						&& checkMTBKValue != partsCaseHistoryVOList.get(i).getMultiBulk()) {
					partsCaseHistoryVOList.remove(i);
				}
			}
			
			for(int i = partsCoolerHistoryVOList.size()-1; i >= 0; i--) {
				if(0 != partsCoolerHistoryVOList.get(i).getMultiBulk()
						&& checkMTBKValue != partsCoolerHistoryVOList.get(i).getMultiBulk()) {
					partsCoolerHistoryVOList.remove(i);
				}
			}
			
			for(int i = partsHddHistoryVOList.size()-1; i >= 0; i--) {
				if(0 != partsHddHistoryVOList.get(i).getMultiBulk()
						&& checkMTBKValue != partsHddHistoryVOList.get(i).getMultiBulk()) {
					partsHddHistoryVOList.remove(i);
				}
			}
			
			for(int i = partsSsdHistoryVOList.size()-1; i >= 0; i--) {
				if(0 != partsSsdHistoryVOList.get(i).getMultiBulk()
						&& checkMTBKValue != partsSsdHistoryVOList.get(i).getMultiBulk()) {
					partsSsdHistoryVOList.remove(i);
				}
			}
			
			for(int i = partsSfHistoryVOList.size()-1; i >= 0; i--) {
				if(0 != partsSfHistoryVOList.get(i).getMultiBulk()
						&& checkMTBKValue != partsSfHistoryVOList.get(i).getMultiBulk()) {
					partsSfHistoryVOList.remove(i);
				}
			}
		}
		
		
		/*--------------------------------------------------
		 - 8. SSD의 DVOL값이 'VC>100에서 1024, VC=<100에서 512'(예산에 맞춰서)
		 - /256(256)/512(512)/1024(1TB)/2048(2TB)인 SSD제품을 제외하곤 모든 SSD제품을 
		 - 소거한다.
		*--------------------------------------------------*/
		// 질문
		// C드라이브(SSD)의 용량을 선택해주세요!
		// Front data 
		// answer11 -> ssd / 예산에 맞게(0) , 256GB(1) , 512GB(2) , 1024GB(1TB)(3) , 2048GB(2TB)(4) (최소 1개)
		
		// DB Column volume(INT)
		// 관리자 입력값
		
		for(int i = partsSsdHistoryVOList.size()-1; i >= 0; i--) {
			if(null == answer11
					|| 0 == answer11) {
				// 예산에맞게
//					if(VC.intValue() > 100) {
				// 07.29 VC와 Price 일원화 하기로 함 프론트에서 만 단위 곱해서 보내준 수 그대로 쓰기로 함.
				if(VC.intValue() > 1000000) {
					// 예산 100만원 초과면 1024 제외하고 모두 소거
					if(1024 != partsSsdHistoryVOList.get(i).getVolume()) {
						partsSsdHistoryVOList.remove(i);
					}
				}else {
					// 예산이 100만원 이하이면 512 제외하고 모두 소거
					if(512 != partsSsdHistoryVOList.get(i).getVolume()) {
						partsSsdHistoryVOList.remove(i);
					}
				}
			}
			
			if(null != answer11
					&& 1 == answer11) {
				// 256GB
				if(256 != partsSsdHistoryVOList.get(i).getVolume()) {
					partsSsdHistoryVOList.remove(i);
				}
			}
			
			if(null != answer11
					&& 2 == answer11) {
				// 512GB
				if(512 != partsSsdHistoryVOList.get(i).getVolume()) {
					partsSsdHistoryVOList.remove(i);
				}
			}
			
			if(null != answer11
					&& 3 == answer11) {
				// 1024GB
				if(1024 != partsSsdHistoryVOList.get(i).getVolume()) {
					partsSsdHistoryVOList.remove(i);
				}
			}
			
			if(null != answer11
					&& 4 == answer11) {
				// 2048GB
				if(2048 != partsSsdHistoryVOList.get(i).getVolume()) {
					partsSsdHistoryVOList.remove(i);
				}
			}
		}
		
		/*--------------------------------------------------
		 - 9. 0<Price=<VC*0.8 외의 모든 제품을 소거한다.
		*--------------------------------------------------*/
		// DB Column parts_price(INT)
		// 관리자 입력값
		
		// 07.29 VC와 Price 일원화 하기로 함 프론트에서 만 단위 곱해서 보내준 수 그대로 쓰기로 함.
		
		// 입력받은 그대로의 수
//		int checkPrice = VC.multiply(new BigDecimal("0.8")).setScale(0, BigDecimal.ROUND_HALF_UP).intValue();
		
		// x10000 한 수 
//		int checkPrice = VC.multiply(new BigDecimal("8000")).intValue();
		
		// 07.29 VC와 Price 일원화 하기로 함 프론트에서 만 단위 곱해서 보내준 수 그대로 쓰기로 함.
		int checkPrice = VC.multiply(new BigDecimal("0.8")).intValue();
		
		// 모든제품 for 돌려야함.
		for(int i = partsGpuHistoryVOList.size()-1; i >= 0; i--) {
			// 23.11.07 추가 gled_cd 00이 아닐때만 금액으로 소거로직 적용하지 않음 gled_cd = 00 = 내장그래픽
			if(!"00".equals(partsGpuHistoryVOList.get(i).getGledCd())) {
				if(0 >= partsGpuHistoryVOList.get(i).getPartsPrice()
						|| checkPrice < partsGpuHistoryVOList.get(i).getPartsPrice()) {
					partsGpuHistoryVOList.remove(i);
				}
			}
		}
		
		for(int i = partsCpuHistoryVOList.size()-1; i >= 0; i--) {
			if(0 >= partsCpuHistoryVOList.get(i).getPartsPrice()
					|| checkPrice < partsCpuHistoryVOList.get(i).getPartsPrice()) {
				partsCpuHistoryVOList.remove(i);
			}
		}
		
		for(int i = partsMbHistoryVOList.size()-1; i >= 0; i--) {
			if(0 >= partsMbHistoryVOList.get(i).getPartsPrice()
					|| checkPrice < partsMbHistoryVOList.get(i).getPartsPrice()) {
				partsMbHistoryVOList.remove(i);
			}
		}
		
		for(int i = partsRamHistoryVOList.size()-1; i >= 0; i--) {
			if(0 >= partsRamHistoryVOList.get(i).getPartsPrice()
					|| checkPrice < partsRamHistoryVOList.get(i).getPartsPrice()) {
				partsRamHistoryVOList.remove(i);
			}
		}
		
		for(int i = partsPsuHistoryVOList.size()-1; i >= 0; i--) {
			if(0 >= partsPsuHistoryVOList.get(i).getPartsPrice()
					|| checkPrice < partsPsuHistoryVOList.get(i).getPartsPrice()) {
				partsPsuHistoryVOList.remove(i);
			}
		}
		
		for(int i = partsCaseHistoryVOList.size()-1; i >= 0; i--) {
			if(0 >= partsCaseHistoryVOList.get(i).getPartsPrice()
					|| checkPrice < partsCaseHistoryVOList.get(i).getPartsPrice()) {
				partsCaseHistoryVOList.remove(i);
			}
		}
		
		for(int i = partsCoolerHistoryVOList.size()-1; i >= 0; i--) {
			if(0 >= partsCoolerHistoryVOList.get(i).getPartsPrice()
					|| checkPrice < partsCoolerHistoryVOList.get(i).getPartsPrice()) {
				partsCoolerHistoryVOList.remove(i);
			}
		}
		
		for(int i = partsHddHistoryVOList.size()-1; i >= 0; i--) {
			if(0 >= partsHddHistoryVOList.get(i).getPartsPrice()
					|| checkPrice < partsHddHistoryVOList.get(i).getPartsPrice()) {
				partsHddHistoryVOList.remove(i);
			}
		}
		
		for(int i = partsSsdHistoryVOList.size()-1; i >= 0; i--) {
			if(0 >= partsSsdHistoryVOList.get(i).getPartsPrice()
					|| checkPrice < partsSsdHistoryVOList.get(i).getPartsPrice()) {
				partsSsdHistoryVOList.remove(i);
			}
		}
		
		for(int i = partsSfHistoryVOList.size()-1; i >= 0; i--) {
			if(0 >= partsSfHistoryVOList.get(i).getPartsPrice()
					|| checkPrice < partsSfHistoryVOList.get(i).getPartsPrice()) {
				partsSfHistoryVOList.remove(i);
			}
		}
		
		/*--------------------------------------------------
		 - 10. 남은 GPU들의 GC를 평가한다.(11번의 value값 산출을 말함.)
		 - 
		 - 11. GC값과 CQC, CMT, CAS값을 토대로 동일 테이블에서 Price가 더 높고 Value가 
		 - 더 낮은 GPU모델을 소거한다.
 		 - * GPU Value = GC(GC)*(1+QC*0.1*CQC+GSV*0.001*CMT+AS(GPUAS)*CAS*0.001)
 		 - * 소거방법
		 - PRICE를 오름차순 정렬한다.
		 - 가장 위 제품부터 아래 제품과 Value를 비교한다.
		 - Value가 이전 결과보다 낮으면 소거한다.(value가 같고 가격이 다르면 이전 제품을 소거해야함. 이전 결과의 제품이 가격은 더 높은데 value가 같으니까.)
		 - 소거됐을 경우 이전 Value결과를 유지하고 다음 제품을 비교한다.
		 -
		 - 23.12.14 GPU Value 변경
		 - GPU Value = PR(GPU)*{1+f(GPUAS*AScustom)*g(GSV*소재custom)/보정수치}*{1-(QC*QCcustom)}
		 - = GC*{1+f(GPUAS*CAS)*g(GSV*CMT)/GPUCV}*{1-(QC*CQC)}
		*--------------------------------------------------*/
		
		// maker as_score -> gpu gpuas 값 이식
		for(int i = 0; i < partsMakerHistoryVOList.size(); i++) {
			for(int z = 0; z < partsGpuHistoryVOList.size(); z++) {
				if(partsMakerHistoryVOList.get(i).getId().equals(partsGpuHistoryVOList.get(z).getMakerId())) {
					partsGpuHistoryVOList.get(z).setGpuas(partsMakerHistoryVOList.get(i).getAsScore());
				}
			}
		}
		
		// process resource detail resource_score -> gpu mappingPrAndGcResourceScore 값 이식
		// answer2에서 배율도 곱해서 GC점수 산정해야함.
//		[이해창] [오후 12:22] 이거는 GC값이 비율에 따라 변경되는 수치가 연산된 결과인데 음
//		[이해창] [오후 12:22] 그 배그 30에 롤 70이면
//		[이해창] [오후 12:22] 배그 PR값에서 30곱하고 100나눈거랑
//		[이해창] [오후 12:22] 롤 PR값에서 70곱하고 100나눈값 두개 합친게
//		[이해창] [오후 12:22] GC값이에요
		for(int i = 0; i < partsGpuHistoryVOList.size(); i++) {
			String gcString = String.valueOf(partsGpuHistoryVOList.get(i).getGc());
			BigDecimal resultGC = BigDecimal.ZERO;
			
			for(int z = 0; z < processResourceDetailHistoryVOList.size(); z++) {
				ProcessResourceDetailHistoryVO processResourceDetailHistoryVO = processResourceDetailHistoryVOList.get(z);
				// G = GVA
				if("G".equals(processResourceDetailHistoryVO.getVariableChk())) {
					// 사용자 견적산출질문 2번 pr_id, scale 적용
					for(int an = 0; an < answer2.size(); an++) {
						// 0~100까지의 수 퍼센테이지로 변환
						BigDecimal scale = new BigDecimal(answer2.get(an).get("scale")).multiply(new BigDecimal("0.01"));
						String pr_id = answer2.get(an).get("pr_id");
						
						if(pr_id.equals(processResourceDetailHistoryVO.getId())
								&& gcString.equals(processResourceDetailHistoryVO.getResourceMappingValue())) {
							resultGC = resultGC.add(processResourceDetailHistoryVO.getResourceScore().multiply(scale));
						}
						
					}
				}
			}
			
			partsGpuHistoryVOList.get(i).setMappingPrAndGcResourceScore(resultGC);
		}
		
		// GSV 배열 데이터 작성
		BigDecimal[] gpuFBigDecimalArray = new BigDecimal[401];

		for(int i = 0; i < gpuFBigDecimalArray.length; i++){
			gpuFBigDecimalArray[i] = BigDecimal.ZERO;
		}

		gpuFBigDecimalArray[0] = new BigDecimal("1");
		gpuFBigDecimalArray[25] = new BigDecimal("160");
		gpuFBigDecimalArray[30] = new BigDecimal("560");
		gpuFBigDecimalArray[33] = new BigDecimal("576");
		gpuFBigDecimalArray[39] = new BigDecimal("592");
		gpuFBigDecimalArray[43] = new BigDecimal("656");
		gpuFBigDecimalArray[45] = new BigDecimal("752");
		gpuFBigDecimalArray[50] = new BigDecimal("768");
		gpuFBigDecimalArray[52] = new BigDecimal("784");
		gpuFBigDecimalArray[55] = new BigDecimal("800");
		gpuFBigDecimalArray[60] = new BigDecimal("816");
		gpuFBigDecimalArray[61] = new BigDecimal("832");
		gpuFBigDecimalArray[66] = new BigDecimal("848");
		gpuFBigDecimalArray[78] = new BigDecimal("928");
		gpuFBigDecimalArray[86] = new BigDecimal("944");
		gpuFBigDecimalArray[90] = new BigDecimal("960");
		gpuFBigDecimalArray[100] = new BigDecimal("1792");
		gpuFBigDecimalArray[104] = new BigDecimal("1840");
		gpuFBigDecimalArray[110] = new BigDecimal("2048");
		gpuFBigDecimalArray[122] = new BigDecimal("2064");
		gpuFBigDecimalArray[130] = new BigDecimal("2080");
		gpuFBigDecimalArray[400] = new BigDecimal("6400");

		int[] gpuFValues = {1, 160, 560, 576, 592, 656, 752, 768, 784, 800, 816, 832, 848, 928, 944, 960, 1792, 1840, 2048, 2064, 2080, 6400};
		int[] gpuFIndexes = {0, 25, 30, 33, 39, 43, 45, 50, 52, 55, 60, 61, 66, 78, 86, 90, 100, 104, 110, 122, 130, 400};
		for (int j = 0; j < gpuFIndexes.length - 1; j++) {
			int startIndex = gpuFIndexes[j];
			int endIndex = gpuFIndexes[j + 1];
			BigDecimal startValue = new BigDecimal(gpuFValues[j]);
			BigDecimal endValue = j + 1 < gpuFValues.length ? new BigDecimal(gpuFValues[j + 1]) : BigDecimal.ZERO;
			BigDecimal increment = endValue.subtract(startValue).divide(new BigDecimal(endIndex - startIndex), 3, BigDecimal.ROUND_HALF_UP);

			for(int i = startIndex + 1; i < endIndex; i++){
				gpuFBigDecimalArray[i] = startValue.add(increment.multiply(new BigDecimal(i - startIndex)));
			}
		}
		
		// GPUAS 배열 데이터 작성
		BigDecimal[] gpuGBigDecimalArray = new BigDecimal[401];

		for(int i = 0; i < gpuGBigDecimalArray.length; i++){
			gpuGBigDecimalArray[i] = BigDecimal.ZERO;
		}

		gpuGBigDecimalArray[0] = new BigDecimal("1");
		gpuGBigDecimalArray[10] = new BigDecimal("168");
		gpuGBigDecimalArray[20] = new BigDecimal("171");
		gpuGBigDecimalArray[40] = new BigDecimal("174");
		gpuGBigDecimalArray[52] = new BigDecimal("177");
		gpuGBigDecimalArray[55] = new BigDecimal("180");
		gpuGBigDecimalArray[70] = new BigDecimal("183");
		gpuGBigDecimalArray[80] = new BigDecimal("186");
		gpuGBigDecimalArray[85] = new BigDecimal("189");
		gpuGBigDecimalArray[100] = new BigDecimal("195");
		gpuGBigDecimalArray[110] = new BigDecimal("198");
		gpuGBigDecimalArray[140] = new BigDecimal("204");
		gpuGBigDecimalArray[170] = new BigDecimal("510");
		gpuGBigDecimalArray[200] = new BigDecimal("600");
		gpuGBigDecimalArray[400] = new BigDecimal("1200");

		int[] gpuGValues = {1, 168, 171, 174, 177, 180, 183, 186, 189, 195, 198, 204, 510, 600, 1200};
		int[] gpuGIndexes = {0, 10, 20, 40, 52, 55, 70, 80, 85, 100, 110, 140, 170, 200, 400};
		for (int j = 0; j < gpuGIndexes.length - 1; j++) {
			int startIndex = gpuGIndexes[j];
			int endIndex = gpuGIndexes[j + 1];
			BigDecimal startValue = new BigDecimal(gpuGValues[j]);
			BigDecimal endValue = j + 1 < gpuGValues.length ? new BigDecimal(gpuGValues[j + 1]) : BigDecimal.ZERO;
			BigDecimal increment = endValue.subtract(startValue).divide(new BigDecimal(endIndex - startIndex), 3, BigDecimal.ROUND_HALF_UP);

			for(int i = startIndex + 1; i < endIndex; i++){
				gpuGBigDecimalArray[i] = startValue.add(increment.multiply(new BigDecimal(i - startIndex)));
			}
		}
		
		// gpu value 연산
		for(int i = 0; i < partsGpuHistoryVOList.size(); i++) {
			PartsGpuHistoryVO partsGpuHistoryVO = partsGpuHistoryVOList.get(i);
			
			// init
			partsGpuHistoryVO.setGpuValue(new BigDecimal(0));
			BigDecimal QC = new BigDecimal(partsGpuHistoryVO.getQc());
			BigDecimal GSV = partsGpuHistoryVO.getGsv();
			BigDecimal GPUAS = new BigDecimal(partsGpuHistoryVO.getGpuas());
			BigDecimal GC = partsGpuHistoryVO.getMappingPrAndGcResourceScore();
			BigDecimal gpuOne = CAS.add(CMT).divide(BigDecimal.valueOf(2)).subtract(new BigDecimal("3.69003173099010")).pow(2).negate();
			BigDecimal gpuTwo = new BigDecimal("99.1219170095487").pow(2);
			BigDecimal gpuThree = gpuOne.add(gpuTwo);
			BigDecimal GPUCV =  new BigDecimal(Math.sqrt(gpuThree.doubleValue())).subtract(new BigDecimal("99.0532084158416")).divide(BigDecimal.valueOf(100)).setScale(6, BigDecimal.ROUND_HALF_UP);// 보정수치
			BigDecimal calculation1 = BigDecimal.ZERO;
			BigDecimal calculation2 = BigDecimal.ZERO;
			BigDecimal calculation3 = BigDecimal.ZERO;
			BigDecimal calculation4 = BigDecimal.ZERO;
			BigDecimal calculation5 = BigDecimal.ZERO;
			BigDecimal calculation6 = BigDecimal.ZERO;
			BigDecimal calculation7 = BigDecimal.ZERO;
			
			calculation1 = new BigDecimal("1").subtract(QC.multiply(CQC).multiply(new BigDecimal("0.1")));
			calculation2 = GSV.multiply(CAS).setScale(0, BigDecimal.ROUND_HALF_UP);
			if(0 == calculation2.compareTo(new BigDecimal("401"))) {
				calculation2 = new BigDecimal("400");
			}
			calculation3 = GPUAS.multiply(CMT).setScale(0, BigDecimal.ROUND_HALF_UP);
			if(0 == calculation3.compareTo(new BigDecimal("401"))) {
				calculation3 = new BigDecimal("400");
			}
			calculation4 = gpuFBigDecimalArray[calculation2.intValue()].multiply(gpuGBigDecimalArray[calculation3.intValue()]);
			calculation5 = new BigDecimal(Math.pow(calculation4.doubleValue(), 1.0 / 2.0)).multiply(GPUCV).setScale(6, BigDecimal.ROUND_HALF_UP);
			calculation6 = new BigDecimal("1").add(calculation5);
			calculation7 = GC.multiply(calculation6).multiply(calculation1).setScale(6, BigDecimal.ROUND_HALF_UP);
			
			partsGpuHistoryVO.setGpuValue(calculation7);
		}

//		기존  소거방법 폐기
//		BigDecimal maxValue = BigDecimal.ZERO;
//		for(int i = partsGpuHistoryVOList.size()-1; i >= 0; i--) {
//			if(i == partsGpuHistoryVOList.size()-1) {
//				maxValue = partsGpuHistoryVOList.get(i).getGpuValue();
//				continue;
//			}
//			
//			BigDecimal nowValue = partsGpuHistoryVOList.get(i).getGpuValue();
////			BigDecimal oldValue = partsGpuHistoryVOList.get(i+1).getGpuValue();
//			
////			 int compareResult = nowValue.compareTo(oldValue);
//			
//			int compareResult = nowValue.compareTo(maxValue);
//			
//			 System.out.println("######### 진행 index는 : "+i);
//			 System.out.println("######### now ID는 : "+partsGpuHistoryVOList.get(i).getId());
//			 System.out.println("######### old ID는 : "+partsGpuHistoryVOList.get(i+1).getId());
//			 System.out.println("######### nowValue : "+nowValue);
////			 System.out.println("######### oldValue : "+oldValue);
//			 System.out.println("######### maxValue : "+maxValue);
//			 
//			 if (compareResult < 0) {
//				 partsGpuHistoryVOList.remove(i);
//				 System.out.println("######### nowValue가 더 작아!!");
//			}else if(compareResult == 0) {
//				// value가 같음
//				System.out.println("######### nowValue == oldValue");
//				if(partsGpuHistoryVOList.get(i).getPartsPrice() != partsGpuHistoryVOList.get(i+1).getPartsPrice()) {
//					System.out.println("######### value는 같은데 가격이 더 비싸네? 죽어라.");
//					if(i+2 == partsGpuHistoryVOList.size()) {
//						partsGpuHistoryVOList.remove(i+1);
//					}else {
//						// 상위 index의 데이터가 한개가 아닐경우.
//						for(int z = i+1; z < partsGpuHistoryVOList.size(); z++) {
//							partsGpuHistoryVOList.remove(z);
//						}
//					}
//				}
//			}else if(compareResult > 0) {
//				maxValue = nowValue;
//				System.out.println("######### nowValue가 더 커!!!!");
//				if(i+2 == partsGpuHistoryVOList.size()) {
//					partsGpuHistoryVOList.remove(i+1);
//				}else {
//					for(int z = i+1; z < partsGpuHistoryVOList.size(); z++) {
//						partsGpuHistoryVOList.remove(z);
//					}
//				}
//			}
//		}

		
		
//		23.07.30 신규 소거방법 정리
//		i = 66
//		---회귀점1---
//		i=i-1
//		n=1
//		i=0일 경우 break
//		value(i) < value(i+n)
//		이면 회귀점1으로 귀환
//		---회귀점2---
//		value(i) >= value(i+n)
//		이면 i+n번 제품 소거
//		n=n+1
//		회귀점 2로 귀환
//		
//		회귀점이 뭐임?
//		회귀점 1은 단순인덱스, 2는 중첩반복을 뜻한다고 함.
//		중첩반복에서 아래로 제거하는일은 절대없음.
		
		
//		System.out.println("######### 소거 전 partsGpuHistoryVOList.size() : "+partsGpuHistoryVOList.size());
//		System.out.println("################# SYSO 결과출력 START #########################");
//		System.out.println("######### 순차적으로 index, id, parts_name, parts_price, gpuValue");
//		for(int i = 0; i < partsGpuHistoryVOList.size(); i++) {
//			System.out.print(i+", "+partsGpuHistoryVOList.get(i).getId()+", "+partsGpuHistoryVOList.get(i).getPartsName()+", "+partsGpuHistoryVOList.get(i).getPartsPrice()+", "+partsGpuHistoryVOList.get(i).getGpuValue());
//			System.out.println("");
//		}
//		System.out.println("################# SYSO 결과출력  END #########################");
		
		// Gpu 소거로직 START
		for(int i = partsGpuHistoryVOList.size()-1; i >= 1; i--) {
			// 23.11.07 추가 gled_cd 00이면 value소거로직 건너뛰도록 함. gled_cd = 00 = 내장그래픽
			if("00".equals(partsGpuHistoryVOList.get(i).getGledCd())) {
				continue;
			}
			
			int targetIndex = i-1;
			
			BigDecimal value1 = partsGpuHistoryVOList.get(targetIndex).getGpuValue();
			BigDecimal value2 = partsGpuHistoryVOList.get(targetIndex+1).getGpuValue();
			
			int compareResult1 = value1.compareTo(value2);
			
			if(compareResult1 < 0) {
				// value1 < value2
				continue;
			}
			
			// 중첩 반복(대상 인덱스로부터 위로 검증)
			int zTargetSize = partsGpuHistoryVOList.size();
			for(int z = targetIndex+1; z < zTargetSize; z++) {
				if(z == zTargetSize) {
					break;
				}
				BigDecimal value3 = partsGpuHistoryVOList.get(z).getGpuValue();
				
				int compareResult2 = value1.compareTo(value3);
				if(compareResult2 > 0 || compareResult2 == 0) {
					// value1 > value3 or value1 == value3
					partsGpuHistoryVOList.remove(z);
					--zTargetSize;
					--z;
				}
			}
		}
		
//		System.out.println("######### 소거 후 partsGpuHistoryVOList.size() : "+partsGpuHistoryVOList.size());
//		System.out.println("################# SYSO 결과출력 START #########################");
//		System.out.println("######### 순차적으로 index, id, parts_name, parts_price, gpuValue");
//		for(int i = 0; i < partsGpuHistoryVOList.size(); i++) {
//			System.out.print(i+", "+partsGpuHistoryVOList.get(i).getId()+", "+partsGpuHistoryVOList.get(i).getPartsName()+", "+partsGpuHistoryVOList.get(i).getPartsPrice()+", "+partsGpuHistoryVOList.get(i).getGpuValue());
//			System.out.println("");
//		}
//		System.out.println("################# SYSO 결과출력  END #########################");
		
		
		/*--------------------------------------------------
		 - 12. 남은 GPU의 개수를 limα라고 명명한다.
		 - α>limα라면 47번으로 해당 반복문을 Break한다.
		 - 
		 - 알고리즘 12의 말을 풀어보면 limα가 23일 때 23개의 gpu룰 index 0 부터 index 22까지
		 - 반복하라는 말이다. 47번으로 break 하라는 소리는 알고리즘 46번까지가 반복문의 종속범위라는 말이다.
		 - 따라서 알고리즘 1번의 α=1, β=1, γ=1, k=1, p=1, q=1, x=1, y=1, ω=1 초기선언을
		 - 1이 아닌 0으로 정정하며 앞으로 구현할 18번, 24번, 27번 , 33번, 39번, 42번, 45번,
		 - 46번의 변수초기화 값도 0으로 정정한다. 
		*--------------------------------------------------*/
		// 12번 시점에서 백업데이터. 추후 구현할 18번에서 롤백 할 백업데이터로 쓰인다.
		List<PartsCpuHistoryVO> partsCpuHistoryVOListAlgorithm12Backup = new ArrayList<>();
		List<PartsRamHistoryVO> partsRamHistoryVOListAlgorithm12Backup = new ArrayList<>();
		List<PartsCoolerHistoryVO> partsCoolerHistoryVOListAlgorithm12Backup = new ArrayList<>();
		List<PartsPsuHistoryVO> partsPsuHistoryVOListAlgorithm12Backup = new ArrayList<>();
		List<PartsCaseHistoryVO> partsCaseHistoryVOListAlgorithm12Backup = new ArrayList<>();
		List<PartsSsdHistoryVO> partsSsdHistoryVOListAlgorithm12Backup = new ArrayList<>();
		List<PartsMbHistoryVO> partsMbHistoryVOListAlgorithm12Backup = new ArrayList<>();
		BigDecimal VC12Backup = VC;

		for(int i = 0; i < partsCpuHistoryVOList.size(); i++) {
			partsCpuHistoryVOListAlgorithm12Backup.add(partsCpuHistoryVOList.get(i));
		}
		
		for(int i = 0; i < partsRamHistoryVOList.size(); i++) {
			partsRamHistoryVOListAlgorithm12Backup.add(partsRamHistoryVOList.get(i));
		}
		
		for(int i = 0; i < partsCoolerHistoryVOList.size(); i++) {
			partsCoolerHistoryVOListAlgorithm12Backup.add(partsCoolerHistoryVOList.get(i));
		}
		
		for(int i = 0; i < partsPsuHistoryVOList.size(); i++) {
			partsPsuHistoryVOListAlgorithm12Backup.add(partsPsuHistoryVOList.get(i));
		}
		
		for(int i = 0; i < partsCaseHistoryVOList.size(); i++) {
			partsCaseHistoryVOListAlgorithm12Backup.add(partsCaseHistoryVOList.get(i));
		}
		
		addListBySsd(partsSsdHistoryVOListAlgorithm12Backup, partsSsdHistoryVOList);
		
		for(int i = 0; i < partsMbHistoryVOList.size(); i++) {
			partsMbHistoryVOListAlgorithm12Backup.add(partsMbHistoryVOList.get(i));
		}
		
		int limα = partsGpuHistoryVOList.size();
		
		for(int gpuIndex = α; gpuIndex < limα; gpuIndex++) {
			/*--------------------------------------------------
			 - 12-1. 12번백업데이터 기준으로 데이터복원처리
			*--------------------------------------------------*/
			partsCpuHistoryVOList = new ArrayList<>();
			partsRamHistoryVOList = new ArrayList<>();
			partsCoolerHistoryVOList = new ArrayList<>();
			partsPsuHistoryVOList = new ArrayList<>();
			partsCaseHistoryVOList = new ArrayList<>();
			partsSsdHistoryVOList = new ArrayList<>();
			partsMbHistoryVOList = new ArrayList<>();
			VC = VC12Backup;

			for(int i = 0; i < partsCpuHistoryVOListAlgorithm12Backup.size(); i++) {
				partsCpuHistoryVOList.add(partsCpuHistoryVOListAlgorithm12Backup.get(i));
			}
			
			for(int i = 0; i < partsRamHistoryVOListAlgorithm12Backup.size(); i++) {
				partsRamHistoryVOList.add(partsRamHistoryVOListAlgorithm12Backup.get(i));
			}
			
			for(int i = 0; i < partsCoolerHistoryVOListAlgorithm12Backup.size(); i++) {
				partsCoolerHistoryVOList.add(partsCoolerHistoryVOListAlgorithm12Backup.get(i));
			}
			
			for(int i = 0; i < partsPsuHistoryVOListAlgorithm12Backup.size(); i++) {
				partsPsuHistoryVOList.add(partsPsuHistoryVOListAlgorithm12Backup.get(i));
			}
			
			for(int i = 0; i < partsCaseHistoryVOListAlgorithm12Backup.size(); i++) {
				partsCaseHistoryVOList.add(partsCaseHistoryVOListAlgorithm12Backup.get(i));
			}
			
			addListBySsd(partsSsdHistoryVOList, partsSsdHistoryVOListAlgorithm12Backup);
			
			for(int i = 0; i < partsMbHistoryVOListAlgorithm12Backup.size(); i++) {
				partsMbHistoryVOList.add(partsMbHistoryVOListAlgorithm12Backup.get(i));
			}
			
			/*--------------------------------------------------
			 - 13. VC = VC-α번째 GPU의 Price
			*--------------------------------------------------*/
			VC = VC.subtract(new BigDecimal(partsGpuHistoryVOList.get(gpuIndex).getPartsPrice()));
			
			/*--------------------------------------------------
			 - 14. GC(α번째 GPU의 GC)를 연산하여 MB를 제외한 
			 - 모든 제품의 Value를 계산한다.
			*--------------------------------------------------*/
			BigDecimal GC = partsGpuHistoryVOList.get(gpuIndex).getMappingPrAndGcResourceScore();
			
			/*--------------------------------------------------
			 - 14-1. CPU Value = CC(선정된 CPU)
			*--------------------------------------------------*/
//			for(int c = 0; c < partsCpuHistoryVOList.size(); c++) {
//				PartsCpuHistoryVO partsCpuHistoryVO = partsCpuHistoryVOList.get(c);
//				BigDecimal resultCC = BigDecimal.ZERO;
//				
//				for(int pr = 0; pr < processResourceDetailHistoryVOList.size(); pr++) {
//					ProcessResourceDetailHistoryVO processResourceDetailHistoryVO = processResourceDetailHistoryVOList.get(pr);
//					// C = CPU
//					if("C".equals(processResourceDetailHistoryVO.getVariableChk())
//							&& partsCpuHistoryVO.getId().equals(processResourceDetailHistoryVO.getResourceMappingValue())) {
//						resultCC = processResourceDetailHistoryVO.getResourceScore();
//					}
//				}
//				
//				partsCpuHistoryVO.setCpuValue(resultCC);
//			}
			
			// 23.08.07 2번질문 배율적용
			for(int c = 0; c < partsCpuHistoryVOList.size(); c++) {
				PartsCpuHistoryVO partsCpuHistoryVO = partsCpuHistoryVOList.get(c);
				BigDecimal resultCC = BigDecimal.ZERO;
				
				for(int pr = 0; pr < processResourceDetailHistoryVOList.size(); pr++) {
					ProcessResourceDetailHistoryVO processResourceDetailHistoryVO = processResourceDetailHistoryVOList.get(pr);
					// C = CPU
					if("C".equals(processResourceDetailHistoryVO.getVariableChk())) {
						// 사용자 견적산출질문 2번 pr_id, scale 적용
						for(int an = 0; an < answer2.size(); an++) {
							// 0~100까지의 수 퍼센테이지로 변환
							BigDecimal scale = new BigDecimal(answer2.get(an).get("scale")).multiply(new BigDecimal("0.01"));
							String pr_id = answer2.get(an).get("pr_id");
							
							if(pr_id.equals(processResourceDetailHistoryVO.getId())
									&& partsCpuHistoryVO.getId().equals(processResourceDetailHistoryVO.getResourceMappingValue())) {
								resultCC = resultCC.add(processResourceDetailHistoryVO.getResourceScore().multiply(scale));
							}
						}
					}
				}
				
				partsCpuHistoryVO.setCpuValue(resultCC);
			}
			
			/*--------------------------------------------------
			 - 14-2. RAM Value = CL(CL)+RVol(RVol)
			*--------------------------------------------------*/
//			for(int r = 0; r < partsRamHistoryVOList.size(); r++) {
//				PartsRamHistoryVO partsRamHistoryVO = partsRamHistoryVOList.get(r);
//				BigDecimal ramValue = BigDecimal.ZERO;
//				BigDecimal CL = BigDecimal.ZERO;
//				BigDecimal RV = BigDecimal.ZERO;
//				
//				for(int pr = 0; pr < processResourceDetailHistoryVOList.size(); pr++) {
//					ProcessResourceDetailHistoryVO processResourceDetailHistoryVO = processResourceDetailHistoryVOList.get(pr);
//					int resourceMappingValue = 0;
//					
//					// RV = ramVolume
//					if("RV".equals(processResourceDetailHistoryVO.getVariableChk())) {
//						try {
//							resourceMappingValue = Integer.parseInt(processResourceDetailHistoryVO.getResourceMappingValue());
//							if(resourceMappingValue == partsRamHistoryVO.getVolume()) {
//								RV = processResourceDetailHistoryVO.getResourceScore();
//							}
//						} catch (NumberFormatException e) {
//							String errMsg = "########## 견적산출 ERROR : process Resorce Detail data 중 ";
//							errMsg += " id : "+ processResourceDetailHistoryVO.getId();
//							errMsg += " seq : "+ processResourceDetailHistoryVO.getSeq();
//							errMsg += " 에 해당하는 resource_mapping_value를 정수화 시키는 중 오류가 발생했습니다.";
//							
//							System.out.println(errMsg);
//							estimateCalculationResultPrivateMasterVO.setErrChk(true);
//							estimateCalculationResultPrivateMasterVO.setErrMsg(errMsg);
//							
//							return estimateCalculationResultPrivateMasterVO;
//						}
//					}
//					
//					// RM = ramMaxRange
//					if("RM".equals(processResourceDetailHistoryVO.getVariableChk())) {
//						try {
//							resourceMappingValue = Integer.parseInt(processResourceDetailHistoryVO.getResourceMappingValue());
//							if(resourceMappingValue == partsRamHistoryVO.getCl()) {
//								CL = processResourceDetailHistoryVO.getResourceScore();
//							}
//						} catch (NumberFormatException e) {
//							String errMsg = "########## 견적산출 ERROR : process Resorce Detail data 중 ";
//							errMsg += " id : "+ processResourceDetailHistoryVO.getId();
//							errMsg += " seq : "+ processResourceDetailHistoryVO.getSeq();
//							errMsg += " 에 해당하는 resource_mapping_value를 정수화 시키는 중 오류가 발생했습니다.";
//							
//							System.out.println(errMsg);
//							estimateCalculationResultPrivateMasterVO.setErrChk(true);
//							estimateCalculationResultPrivateMasterVO.setErrMsg(errMsg);
//							
//							return estimateCalculationResultPrivateMasterVO;
//						}
//					}
//				}
//				
//				ramValue = CL.add(RV);
//				partsRamHistoryVO.setRamValue(ramValue);
//			}
			
			// 23.08.07 2번질문 배율적용
			for(int r = 0; r < partsRamHistoryVOList.size(); r++) {
				PartsRamHistoryVO partsRamHistoryVO = partsRamHistoryVOList.get(r);
				BigDecimal ramValue = BigDecimal.ZERO;
				BigDecimal CL = BigDecimal.ZERO;
				BigDecimal RV = BigDecimal.ZERO;
				
				for(int pr = 0; pr < processResourceDetailHistoryVOList.size(); pr++) {
					ProcessResourceDetailHistoryVO processResourceDetailHistoryVO = processResourceDetailHistoryVOList.get(pr);
					int resourceMappingValue = 0;
					
					// RV = ramVolume
					if("RV".equals(processResourceDetailHistoryVO.getVariableChk())) {
						// 사용자 견적산출질문 2번 pr_id, scale 적용
						for(int an = 0; an < answer2.size(); an++) {
							// 0~100까지의 수 퍼센테이지로 변환
							BigDecimal scale = new BigDecimal(answer2.get(an).get("scale")).multiply(new BigDecimal("0.01"));
							String pr_id = answer2.get(an).get("pr_id");
							
							try {
								resourceMappingValue = Integer.parseInt(processResourceDetailHistoryVO.getResourceMappingValue());
								if(pr_id.equals(processResourceDetailHistoryVO.getId())
										&& partsRamHistoryVO.getVolume() == resourceMappingValue) {
									RV = RV.add(processResourceDetailHistoryVO.getResourceScore().multiply(scale));
								}
							} catch (NumberFormatException e) {
								String errMsg = "########## 견적산출 ERROR : process Resorce Detail data 중 ";
								errMsg += " id : "+ processResourceDetailHistoryVO.getId();
								errMsg += " seq : "+ processResourceDetailHistoryVO.getSeq();
								errMsg += " 에 해당하는 resource_mapping_value를 정수화 시키는 중 오류가 발생했습니다.";
								
								System.out.println(errMsg);
								estimateCalculationResultPrivateMasterVO.setErrChk(true);
								estimateCalculationResultPrivateMasterVO.setErrMsg(errMsg);
								
								return estimateCalculationResultPrivateMasterVO;
							}
						}
					}
					
					// RM = ramMaxRange
					if("RM".equals(processResourceDetailHistoryVO.getVariableChk())) {
						// 사용자 견적산출질문 2번 pr_id, scale 적용
						for(int an = 0; an < answer2.size(); an++) {
							// 0~100까지의 수 퍼센테이지로 변환
							BigDecimal scale = new BigDecimal(answer2.get(an).get("scale")).multiply(new BigDecimal("0.01"));
							String pr_id = answer2.get(an).get("pr_id");
							
							try {
								resourceMappingValue = Integer.parseInt(processResourceDetailHistoryVO.getResourceMappingValue());
								
								if(pr_id.equals(processResourceDetailHistoryVO.getId())
										&& partsRamHistoryVO.getCl() == resourceMappingValue) {
									CL = CL.add(processResourceDetailHistoryVO.getResourceScore().multiply(scale));
								}
							} catch (NumberFormatException e) {
								String errMsg = "########## 견적산출 ERROR : process Resorce Detail data 중 ";
								errMsg += " id : "+ processResourceDetailHistoryVO.getId();
								errMsg += " seq : "+ processResourceDetailHistoryVO.getSeq();
								errMsg += " 에 해당하는 resource_mapping_value를 정수화 시키는 중 오류가 발생했습니다.";
								
								System.out.println(errMsg);
								estimateCalculationResultPrivateMasterVO.setErrChk(true);
								estimateCalculationResultPrivateMasterVO.setErrMsg(errMsg);
								
								return estimateCalculationResultPrivateMasterVO;
							}
						}
					}
				}
				
				ramValue = CL.add(RV);
				partsRamHistoryVO.setRamValue(ramValue);
			}
			
			/*--------------------------------------------------
			 - 14-3. Cooler Value = GC(조합된 견적에서의 GPU 칩셋)*0.05*{1+(ACAS+WCAS*6)*CAS*0.001+CNV*CQC*(-0.01)+STA*CSFT*0.001}
			 - 대입변수 변환
			 - [calculation1] GC*0.05
			 - [calculation2] WCAS*6
			 - [calculation3] [ACAS+calculation2]*CAS*0.001
			 - [calculation4] CNV*CQC*(-0.01)
			 - [calculation5] STA*CSFT*0.001
			 - [calculation6] 1+[calculation3]+[calculation4]+[calculation5]
			 - Cooler Value = [calculation1]*[calculation6]
			 - 
			 - 23.12.14 Cooler Value 변경
			 - CL Value = PR(CPU)*0.6*{1+f(CLAS*AScustom)*g(Thermal*발열custom)/보정수치}*{1-(QC*QCcustom)}
			 - 수식 잘못됨. 다시 전달받음.
			 - CL Value = PR(GPU)*0.03*{1+f(CLAS*AScustom)*g(Thermal*발열custom)/보정수치}*{1-(QC*QCcustom)}
			 - = GC*0.03*{1+f(CLAS*CAS)*g(Thermal*CTH)/COOLERCV}*{1-(QC*CQC)}
			*--------------------------------------------------*/
			// CLAS 배열 데이터 작성
			BigDecimal[] clFBigDecimalArray = new BigDecimal[401];

			for(int i = 0; i < clFBigDecimalArray.length; i++){
				clFBigDecimalArray[i] = BigDecimal.ZERO;
			}

			clFBigDecimalArray[0] = new BigDecimal("1");
			clFBigDecimalArray[12] = new BigDecimal("12");
			clFBigDecimalArray[24] = new BigDecimal("24");
			clFBigDecimalArray[36] = new BigDecimal("69");
			clFBigDecimalArray[60] = new BigDecimal("70");
			clFBigDecimalArray[72] = new BigDecimal("73");
			clFBigDecimalArray[96] = new BigDecimal("74");
			clFBigDecimalArray[120] = new BigDecimal("80");
			clFBigDecimalArray[144] = new BigDecimal("81");
			clFBigDecimalArray[192] = new BigDecimal("192");
			clFBigDecimalArray[400] = new BigDecimal("600");

			int[] clFValues = {1, 12, 24, 69, 70, 73, 74, 80, 81, 192, 600};
			int[] clFIndexes = {0, 12, 24, 36, 60, 72, 96, 120, 144, 192, 400};

			for (int j = 0; j < clFIndexes.length - 1; j++) {
				int startIndex = clFIndexes[j];
				int endIndex = clFIndexes[j + 1];
				BigDecimal startValue = new BigDecimal(clFValues[j]);
				BigDecimal endValue = j + 1 < clFValues.length ? new BigDecimal(clFValues[j + 1]) : BigDecimal.ZERO;
				BigDecimal increment = endValue.subtract(startValue).divide(new BigDecimal(endIndex - startIndex), 3, BigDecimal.ROUND_HALF_UP);

				for(int i = startIndex + 1; i < endIndex; i++){
					clFBigDecimalArray[i] = startValue.add(increment.multiply(new BigDecimal(i - startIndex)));
				}
			}
			// Thermal 배열 대이터 작성
			BigDecimal[] clGBigDecimalArray = new BigDecimal[401];

			for(int i = 0; i < clGBigDecimalArray.length; i++){
				clGBigDecimalArray[i] = BigDecimal.ZERO;
			}

			clGBigDecimalArray[0] = new BigDecimal("1");
			clGBigDecimalArray[40] = new BigDecimal("200");
			clGBigDecimalArray[55] = new BigDecimal("210");
			clGBigDecimalArray[60] = new BigDecimal("260");
			clGBigDecimalArray[65] = new BigDecimal("270");
			clGBigDecimalArray[72] = new BigDecimal("320");
			clGBigDecimalArray[75] = new BigDecimal("330");
			clGBigDecimalArray[80] = new BigDecimal("440");
			clGBigDecimalArray[83] = new BigDecimal("480");
			clGBigDecimalArray[90] = new BigDecimal("490");
			clGBigDecimalArray[92] = new BigDecimal("500");
			clGBigDecimalArray[110] = new BigDecimal("510");
			clGBigDecimalArray[120] = new BigDecimal("640");
			clGBigDecimalArray[130] = new BigDecimal("710");
			clGBigDecimalArray[144] = new BigDecimal("840");
			clGBigDecimalArray[150] = new BigDecimal("870");
			clGBigDecimalArray[166] = new BigDecimal("1200");
			clGBigDecimalArray[169] = new BigDecimal("1250");
			clGBigDecimalArray[180] = new BigDecimal("1450");
			clGBigDecimalArray[184] = new BigDecimal("1840");
			clGBigDecimalArray[400] = new BigDecimal("4000");

			int[] clGValues = {1, 200, 210, 260, 270, 320, 330, 440, 480, 490, 500, 510, 640, 710, 840, 870, 1200, 1250, 1450, 1840, 4000};
			int[] clGIndexes = {0, 40, 55, 60, 65, 72, 75, 80, 83, 90, 92, 110, 120, 130, 144, 150, 166, 169, 180, 184, 400};

			for (int j = 0; j < clGIndexes.length - 1; j++) {
				int startIndex = clGIndexes[j];
				int endIndex = clGIndexes[j + 1];
				BigDecimal startValue = new BigDecimal(clGValues[j]);
				BigDecimal endValue = j + 1 < clGValues.length ? new BigDecimal(clGValues[j + 1]) : BigDecimal.ZERO;
				BigDecimal increment = endValue.subtract(startValue).divide(new BigDecimal(endIndex - startIndex), 3, BigDecimal.ROUND_HALF_UP);

				for(int i = startIndex + 1; i < endIndex; i++){
					clGBigDecimalArray[i] = startValue.add(increment.multiply(new BigDecimal(i - startIndex)));
				}
			}

			for(int co = 0; co < partsCoolerHistoryVOList.size(); co++) {
				PartsCoolerHistoryVO partsCoolerHistoryVO = partsCoolerHistoryVOList.get(co);
				BigDecimal QC = new BigDecimal(partsCoolerHistoryVO.getQc());
				// CLAS = 12WCAS + ACAS
				BigDecimal CLAS = new BigDecimal("12")
						.multiply(new BigDecimal(partsCoolerHistoryVO.getWcas()))
						.add(new BigDecimal(partsCoolerHistoryVO.getAcas()));
				BigDecimal Thermal = new BigDecimal(partsCoolerHistoryVO.getThermal());
				BigDecimal clOne = CAS.add(CTH).divide(BigDecimal.valueOf(2)).subtract(new BigDecimal("4.66451733306545")).pow(2).negate();
				BigDecimal clTwo = new BigDecimal("4.84255185018178").pow(2);
				BigDecimal clThree = clOne.add(clTwo);
				BigDecimal COOLERCV =  new BigDecimal(Math.sqrt(clThree.doubleValue())).subtract(new BigDecimal("1.30099441629508")).divide(BigDecimal.valueOf(100)).setScale(6, BigDecimal.ROUND_HALF_UP); //보정수치
				BigDecimal calculation1 = BigDecimal.ZERO;
				BigDecimal calculation2 = BigDecimal.ZERO;
				BigDecimal calculation3 = BigDecimal.ZERO;
				BigDecimal calculation4 = BigDecimal.ZERO;
				BigDecimal calculation5 = BigDecimal.ZERO;
				BigDecimal calculation6 = BigDecimal.ZERO;
				BigDecimal calculation7 = BigDecimal.ZERO;
				BigDecimal calculation8 = BigDecimal.ZERO;
				
				calculation1 = QC.multiply(CQC).multiply(new BigDecimal("0.1"));
				calculation2 = new BigDecimal("1").subtract(calculation1);
				calculation3 = CLAS.multiply(CAS).setScale(0, BigDecimal.ROUND_HALF_UP);
				if(0 == calculation3.compareTo(new BigDecimal("401"))) {
					calculation3 = new BigDecimal("400");
				}
				calculation4 = Thermal.multiply(CTH).setScale(0, BigDecimal.ROUND_HALF_UP);
				if(0 == calculation4.compareTo(new BigDecimal("401"))) {
					calculation4 = new BigDecimal("400");
				}
				calculation5 				
				= clFBigDecimalArray[calculation3.intValue()]
						.multiply(clGBigDecimalArray[calculation4.intValue()]);
				calculation6 = new BigDecimal(Math.sqrt(calculation5.doubleValue())).multiply(COOLERCV).setScale(6, BigDecimal.ROUND_HALF_UP);
				calculation7 = new BigDecimal("1").add(calculation6);
				calculation8 = GC.multiply(new BigDecimal("0.03")).multiply(calculation7).multiply(calculation2);
				
				partsCoolerHistoryVO.setCoolerValue(calculation8);
			}
			
			/*--------------------------------------------------
			 - 14-4. PSU Value = PFM*GC(조합된 견적에서의 GPU 칩셋)*0.05*{1+(PFM*1.5+SFT)*CSFT*0.1+PFM*CMT*0.05+AS(PSUAS)*0.001*CAS}
			 - 대입변수 변환
			 - [calculation1] PFM*GC*0.05
			 - [calculation2] PFM*1.5+SFT
			 - [calculation3] [calculation2]*CSFT*0.1
			 - [calculation4] PFM*CMT*0.05
			 - [calculation5] AS(PSUAS)*0.001*CAS
			 - [calculation6] 1+[calculation3]+[calculation4]+[calculation5]
			 - Psu Value = [calculation1]*[calculation6]
			 - 
			 - 23.12.14 PSU Value 변경
			 - PSU = PR(GPU)*0.001157*PFM*{1+f(PSUAS*AScustom)*g(PFM*소재custom)*h(PFM*안정성custom)*i(SFT*안정성custom)/보정수치}*{1-(QC*QCcustom)}
			 - = GC*0.001157*PFM*{1+f(PSUAS*CAS)*g(PFM*CMT)*h(PFM*CSFT)*i(SFT*CSFT)/PSUCV}*{1-(QC*CQC)}
			*--------------------------------------------------*/
			
			// maker as_score -> psu psuas 값 이식
			for(int ma = 0; ma < partsMakerHistoryVOList.size(); ma++) {
				for(int z = 0; z < partsPsuHistoryVOList.size(); z++) {
					if(partsMakerHistoryVOList.get(ma).getId().equals(partsPsuHistoryVOList.get(z).getMakerId())) {
						partsPsuHistoryVOList.get(z).setPsuas(partsMakerHistoryVOList.get(ma).getAsScore());
					}
				}
			}
			// PSUAS 배열 데이터 작성
			BigDecimal[] psuFBigDecimalArray = new BigDecimal[401];

			for(int i = 0; i < psuFBigDecimalArray.length; i++){
				psuFBigDecimalArray[i] = BigDecimal.ZERO;
			}

			psuFBigDecimalArray[0] = new BigDecimal("1");
			psuFBigDecimalArray[25] = new BigDecimal("250");
			psuFBigDecimalArray[50] = new BigDecimal("420");
			psuFBigDecimalArray[55] = new BigDecimal("440");
			psuFBigDecimalArray[70] = new BigDecimal("630");
			psuFBigDecimalArray[85] = new BigDecimal("640");
			psuFBigDecimalArray[100] = new BigDecimal("660");
			psuFBigDecimalArray[110] = new BigDecimal("1060");
			psuFBigDecimalArray[140] = new BigDecimal("1300");
			psuFBigDecimalArray[170] = new BigDecimal("1550");
			psuFBigDecimalArray[200] = new BigDecimal("3000");
			psuFBigDecimalArray[400] = new BigDecimal("6000");

			int[] psuFValues = {1, 250, 420, 440, 630, 640, 660, 1060, 1300, 1550, 3000, 6000};
			int[] psuFIndexes = {0, 25, 50, 55, 70, 85, 100, 110, 140, 170, 200, 400};
			for (int j = 0; j < psuFIndexes.length - 1; j++) {
				int startIndex = psuFIndexes[j];
				int endIndex = psuFIndexes[j + 1];
				BigDecimal startValue = new BigDecimal(psuFValues[j]);
				BigDecimal endValue = j + 1 < psuFValues.length ? new BigDecimal(psuFValues[j + 1]) : BigDecimal.ZERO;
				BigDecimal increment = endValue.subtract(startValue).divide(new BigDecimal(endIndex - startIndex), 3, BigDecimal.ROUND_HALF_UP);

				for(int i = startIndex + 1; i < endIndex; i++){
					psuFBigDecimalArray[i] = startValue.add(increment.multiply(new BigDecimal(i - startIndex)));
				}
			}
			// PFM(소재) 배열 데이터 작성
			BigDecimal[] psuGBigDecimalArray = new BigDecimal[401];

			for(int i = 0; i < psuGBigDecimalArray.length; i++){
				psuGBigDecimalArray[i] = BigDecimal.ZERO;
			}

			psuGBigDecimalArray[0] = new BigDecimal("1");
			psuGBigDecimalArray[22] = new BigDecimal("330");
			psuGBigDecimalArray[26] = new BigDecimal("390");
			psuGBigDecimalArray[29] = new BigDecimal("1095");
			psuGBigDecimalArray[35] = new BigDecimal("1245");
			psuGBigDecimalArray[44] = new BigDecimal("1260");
			psuGBigDecimalArray[52] = new BigDecimal("1290");
			psuGBigDecimalArray[58] = new BigDecimal("1305");
			psuGBigDecimalArray[59] = new BigDecimal("1320");
			psuGBigDecimalArray[66] = new BigDecimal("1335");
			psuGBigDecimalArray[69] = new BigDecimal("1350");
			psuGBigDecimalArray[70] = new BigDecimal("1365");
			psuGBigDecimalArray[71] = new BigDecimal("1380");
			psuGBigDecimalArray[80] = new BigDecimal("1410");
			psuGBigDecimalArray[88] = new BigDecimal("1425");
			psuGBigDecimalArray[91] = new BigDecimal("1440");
			psuGBigDecimalArray[92] = new BigDecimal("1470");
			psuGBigDecimalArray[118] = new BigDecimal("1590");
			psuGBigDecimalArray[132] = new BigDecimal("1980");
			psuGBigDecimalArray[138] = new BigDecimal("2070");
			psuGBigDecimalArray[142] = new BigDecimal("2130");
			psuGBigDecimalArray[160] = new BigDecimal("2400");
			psuGBigDecimalArray[182] = new BigDecimal("2730");
			psuGBigDecimalArray[184] = new BigDecimal("3300");
			psuGBigDecimalArray[400] = new BigDecimal("7050");

			int[] psuGValues = {1, 330, 390, 1095, 1245, 1260, 1290, 1305, 1320, 1335, 1350, 1365, 1380, 1410, 1425, 1440, 1470, 1590, 1980, 2070, 2130, 2400, 2730, 3300, 7050};
			int[] psuGIndexes = {0, 22, 26, 29, 35, 44, 52, 58, 59, 66, 69, 70, 71, 80, 88, 91, 92, 118, 132, 138, 142, 160, 182, 184, 400};
			for (int j = 0; j < psuGIndexes.length - 1; j++) {
				int startIndex = psuGIndexes[j];
				int endIndex = psuGIndexes[j + 1];
				BigDecimal startValue = new BigDecimal(psuGValues[j]);
				BigDecimal endValue = j + 1 < psuGValues.length ? new BigDecimal(psuGValues[j + 1]) : BigDecimal.ZERO;
				BigDecimal increment = endValue.subtract(startValue).divide(new BigDecimal(endIndex - startIndex), 3, BigDecimal.ROUND_HALF_UP);

				for(int i = startIndex + 1; i < endIndex; i++){
					psuGBigDecimalArray[i] = startValue.add(increment.multiply(new BigDecimal(i - startIndex)));
				}
			}
			// PSM(안정성) 배열 데이터 작성
			BigDecimal[] psuHBigDecimalArray = new BigDecimal[401];

			for(int i = 0; i < psuHBigDecimalArray.length; i++){
				psuHBigDecimalArray[i] = BigDecimal.ZERO;
			}

			psuHBigDecimalArray[0] = new BigDecimal("1");
			psuHBigDecimalArray[22] = new BigDecimal("110");
			psuHBigDecimalArray[26] = new BigDecimal("260");
			psuHBigDecimalArray[29] = new BigDecimal("265");
			psuHBigDecimalArray[35] = new BigDecimal("275");
			psuHBigDecimalArray[44] = new BigDecimal("280");
			psuHBigDecimalArray[52] = new BigDecimal("285");
			psuHBigDecimalArray[58] = new BigDecimal("295");
			psuHBigDecimalArray[59] = new BigDecimal("300");
			psuHBigDecimalArray[66] = new BigDecimal("330");
			psuHBigDecimalArray[69] = new BigDecimal("380");
			psuHBigDecimalArray[70] = new BigDecimal("385");
			psuHBigDecimalArray[71] = new BigDecimal("390");
			psuHBigDecimalArray[80] = new BigDecimal("420");
			psuHBigDecimalArray[88] = new BigDecimal("450");
			psuHBigDecimalArray[91] = new BigDecimal("455");
			psuHBigDecimalArray[92] = new BigDecimal("460");
			psuHBigDecimalArray[118] = new BigDecimal("465");
			psuHBigDecimalArray[132] = new BigDecimal("660");
			psuHBigDecimalArray[138] = new BigDecimal("670");
			psuHBigDecimalArray[142] = new BigDecimal("740");
			psuHBigDecimalArray[160] = new BigDecimal("745");
			psuHBigDecimalArray[182] = new BigDecimal("755");
			psuHBigDecimalArray[184] = new BigDecimal("920");
			psuHBigDecimalArray[400] = new BigDecimal("3000");

			int[] psuHValues = {1, 110, 260, 265, 275, 280, 285, 295, 300, 330, 380, 385, 390, 420, 450, 455, 460, 465, 660, 670, 740, 745, 755, 920, 3000};
			int[] psuHIndexes = {0, 22, 26, 29, 35, 44, 52, 58, 59, 66, 69, 70, 71, 80, 88, 91, 92, 118, 132, 138, 142, 160, 182, 184, 400};
			for (int j = 0; j < psuHIndexes.length - 1; j++) {
				int startIndex = psuHIndexes[j];
				int endIndex = psuHIndexes[j + 1];
				BigDecimal startValue = new BigDecimal(psuHValues[j]);
				BigDecimal endValue = j + 1 < psuHValues.length ? new BigDecimal(psuHValues[j + 1]) : BigDecimal.ZERO;
				BigDecimal increment = endValue.subtract(startValue).divide(new BigDecimal(endIndex - startIndex), 3, BigDecimal.ROUND_HALF_UP);

				for(int i = startIndex + 1; i < endIndex; i++){
					psuHBigDecimalArray[i] = startValue.add(increment.multiply(new BigDecimal(i - startIndex)));
				}
			}
			// SFT 배열 데이터 작성
			BigDecimal[] psuZBigDecimalArray = new BigDecimal[401];

			for(int i = 0; i < psuZBigDecimalArray.length; i++){
				psuZBigDecimalArray[i] = BigDecimal.ZERO;
			}

			psuZBigDecimalArray[0] = new BigDecimal("1");
			psuZBigDecimalArray[27] = new BigDecimal("459");
			psuZBigDecimalArray[32] = new BigDecimal("935");
			psuZBigDecimalArray[36] = new BigDecimal("1445");
			psuZBigDecimalArray[48] = new BigDecimal("1462");
			psuZBigDecimalArray[54] = new BigDecimal("1479");
			psuZBigDecimalArray[55] = new BigDecimal("1496");
			psuZBigDecimalArray[56] = new BigDecimal("1513");
			psuZBigDecimalArray[59] = new BigDecimal("1530");
			psuZBigDecimalArray[61] = new BigDecimal("1547");
			psuZBigDecimalArray[64] = new BigDecimal("1564");
			psuZBigDecimalArray[68] = new BigDecimal("1581");
			psuZBigDecimalArray[72] = new BigDecimal("1615");
			psuZBigDecimalArray[96] = new BigDecimal("1632");
			psuZBigDecimalArray[97] = new BigDecimal("1649");
			psuZBigDecimalArray[99] = new BigDecimal("1683");
			psuZBigDecimalArray[110] = new BigDecimal("1717");
			psuZBigDecimalArray[112] = new BigDecimal("1734");
			psuZBigDecimalArray[118] = new BigDecimal("1785");
			psuZBigDecimalArray[122] = new BigDecimal("2176");
			psuZBigDecimalArray[136] = new BigDecimal("2193");
			psuZBigDecimalArray[144] = new BigDecimal("2210");
			psuZBigDecimalArray[194] = new BigDecimal("2567");
			psuZBigDecimalArray[198] = new BigDecimal("2584");
			psuZBigDecimalArray[400] = new BigDecimal("5700");

			int[] psuZValues = {1, 459, 935, 1445, 1462, 1479, 1496, 1513, 1530, 1547, 1564, 1581, 1615, 1632, 1649, 1683, 1717, 1734, 1785, 2176, 2193, 2210, 2567, 2584, 5700};
			int[] psuZIndexes = {0, 27, 32, 36, 48, 54, 55, 56, 59, 61, 64, 68, 72, 96, 97, 99, 110, 112, 118, 122, 136, 144, 194, 198, 400};
			for (int j = 0; j < psuZIndexes.length - 1; j++) {
				int startIndex = psuZIndexes[j];
				int endIndex = psuZIndexes[j + 1];
				BigDecimal startValue = new BigDecimal(psuZValues[j]);
				BigDecimal endValue = j + 1 < psuZValues.length ? new BigDecimal(psuZValues[j + 1]) : BigDecimal.ZERO;
				BigDecimal increment = endValue.subtract(startValue).divide(new BigDecimal(endIndex - startIndex), 3, BigDecimal.ROUND_HALF_UP);

				for(int i = startIndex + 1; i < endIndex; i++){
					psuZBigDecimalArray[i] = startValue.add(increment.multiply(new BigDecimal(i - startIndex)));
				}
			}
			for(int ps = 0; ps < partsPsuHistoryVOList.size(); ps++) {
				PartsPsuHistoryVO partsPsuHistoryVO = partsPsuHistoryVOList.get(ps);
				BigDecimal QC = new BigDecimal(partsPsuHistoryVO.getQc());
				BigDecimal SFT = partsPsuHistoryVO.getSft();
				BigDecimal PFM = partsPsuHistoryVO.getPfm();
				BigDecimal PSUAS = new BigDecimal(partsPsuHistoryVO.getPsuas());
				BigDecimal psuOne = CAS.add(CMT).add(CSFT).add(CSFT).divide(BigDecimal.valueOf(4)).subtract(new BigDecimal("1.93961451569933")).pow(2).negate();
				BigDecimal psuTwo = new BigDecimal("5.07397370455103").pow(2);
				BigDecimal psuThree = psuOne.add(psuTwo);
				BigDecimal PSUCV =  new BigDecimal(Math.sqrt(psuThree.doubleValue())).subtract(new BigDecimal("4.68861436726927")).divide(BigDecimal.valueOf(100)).setScale(8, BigDecimal.ROUND_HALF_UP);// 보정수치
				
				// 23.12.18 가성비 제품 선택 시 과도한 PSU제품 선택에 의한 밸류 기본값 조정 - 임시방편으로 수행됨. 추후 뻥파워 이슈 제품을 거를 방법 선정해야함.
				// BigDecimal customCheck = CMT.add(CSFT).add(CAS);
				// if(customCheck.compareTo(BigDecimal.ZERO) == 0) {
				// 	PFM = BigDecimal.ZERO;
				// }
				
				BigDecimal calculation1 = BigDecimal.ZERO;
				BigDecimal calculation2 = BigDecimal.ZERO;
				BigDecimal calculation3 = BigDecimal.ZERO;
				BigDecimal calculation4 = BigDecimal.ZERO;
				BigDecimal calculation5 = BigDecimal.ZERO;
				BigDecimal calculation6 = BigDecimal.ZERO;
				BigDecimal calculation7 = BigDecimal.ZERO;
				BigDecimal calculation8 = BigDecimal.ZERO;
				BigDecimal calculation9 = BigDecimal.ZERO;
				BigDecimal calculation10 = BigDecimal.ZERO;
				
				calculation1 = QC.multiply(CQC).multiply(new BigDecimal("0.1"));
				calculation2 = new BigDecimal("1").subtract(calculation1);
				calculation3 = SFT.multiply(CSFT).setScale(0, BigDecimal.ROUND_HALF_UP);
				if(0 == calculation3.compareTo(new BigDecimal("401"))) {
					calculation3 = new BigDecimal("400");
				}
				calculation4 = PFM.multiply(CSFT).setScale(0, BigDecimal.ROUND_HALF_UP);
				if(0 == calculation4.compareTo(new BigDecimal("401"))) {
					calculation4 = new BigDecimal("400");
				}
				calculation5 = PFM.multiply(CMT).setScale(0, BigDecimal.ROUND_HALF_UP);
				if(0 == calculation5.compareTo(new BigDecimal("401"))) {
					calculation5 = new BigDecimal("400");
				}
				calculation6 = PSUAS.multiply(CAS).setScale(0, BigDecimal.ROUND_HALF_UP);
				if(0 == calculation6.compareTo(new BigDecimal("401"))) {
					calculation6 = new BigDecimal("400");
				}
				calculation7			
				= psuFBigDecimalArray[calculation6.intValue()]
						.multiply(psuGBigDecimalArray[calculation5.intValue()])
						.multiply(psuHBigDecimalArray[calculation4.intValue()])
						.multiply(psuZBigDecimalArray[calculation3.intValue()]);
				calculation8 = new BigDecimal(Math.pow(calculation7.doubleValue(), 1.0 / 4.0)).multiply(PSUCV).setScale(6, BigDecimal.ROUND_HALF_UP);
				calculation9 = new BigDecimal("1").add(calculation8);
				calculation10 = GC.multiply(new BigDecimal("0.001157"))
						.multiply(PFM)
						.multiply(calculation9)
						.multiply(calculation2);
				
				partsPsuHistoryVO.setPsuValue(calculation10);
				
			}
			
			/*--------------------------------------------------
			 - 14-5. CASE Value = GC(조합된 견적에서의 GPU 칩셋)*0.1*{1+AS(CASEAS)*0.1*CAS+Cool*0.001*CTH+END*(-0.1)*CQC+ADAP*0.05*CMT}
			 - 대입변수 변환
			 - [calculation1] GC*0.1
			 - [calculation2] AS(CASEAS)*0.1*CAS
			 - [calculation3] Cool*0.001*CTH
			 - [calculation4] END*(-0.1)*CQC
			 - [calculation5] ADAP*0.05*CMT
			 - [calculation6] 1+[calculation2]+[calculation3]+[calculation4]+[calculation5]
			 - Case Value = [calculation1]*[calculation6]
			 - 
			 - 23.12.14 CASE Value 변경
			 - CASE = PR(GPU)*0.04*{1+f(CASEAS*AScustom)*g(ADAP*소재custom)*h(Cool*발열custom)/보정수치}*{1-(QC*QCcustom)}
			 - = GC*0.04*{1+f(CASEAS*CAS)*g(ADAP*CMT)*h(Cool*CTH)/보정수치}*{1-(QC*CQC)}
			*--------------------------------------------------*/
			
			// maker as_score -> case caseas 값 이식
			for(int ma = 0; ma < partsMakerHistoryVOList.size(); ma++) {
				for(int z = 0; z < partsCaseHistoryVOList.size(); z++) {
					if(partsMakerHistoryVOList.get(ma).getId().equals(partsCaseHistoryVOList.get(z).getMakerId())) {
						partsCaseHistoryVOList.get(z).setCaseas(partsMakerHistoryVOList.get(ma).getAsScore());
					}
				}
			}
			// CASEAS 배열 데이터 작성
			BigDecimal[] caseFBigDecimalArray = new BigDecimal[401];

			for(int i = 0; i < caseFBigDecimalArray.length; i++){
				caseFBigDecimalArray[i] = BigDecimal.ZERO;
			}

			caseFBigDecimalArray[0] = new BigDecimal("1");
			caseFBigDecimalArray[40] = new BigDecimal("7600");
			caseFBigDecimalArray[55] = new BigDecimal("16340");
			caseFBigDecimalArray[70] = new BigDecimal("16530");
			caseFBigDecimalArray[80] = new BigDecimal("16720");
			caseFBigDecimalArray[85] = new BigDecimal("16910");
			caseFBigDecimalArray[100] = new BigDecimal("17100");
			caseFBigDecimalArray[110] = new BigDecimal("19000");
			caseFBigDecimalArray[140] = new BigDecimal("21850");
			caseFBigDecimalArray[170] = new BigDecimal("22040");
			caseFBigDecimalArray[200] = new BigDecimal("26600");
			caseFBigDecimalArray[400] = new BigDecimal("53200");

			int[] caseFValues = {1, 7600, 16340, 16530, 16720, 16910, 17100, 19000, 21850, 22040, 26600, 53200};
			int[] caseFIndexes = {0, 40, 55, 70, 80, 85, 100, 110, 140, 170, 200, 400};
			for (int j = 0; j < caseFIndexes.length - 1; j++) {
				int startIndex = caseFIndexes[j];
				int endIndex = caseFIndexes[j + 1];
				BigDecimal startValue = new BigDecimal(caseFValues[j]);
				BigDecimal endValue = j + 1 < caseFValues.length ? new BigDecimal(caseFValues[j + 1]) : BigDecimal.ZERO;
				BigDecimal increment = endValue.subtract(startValue).divide(new BigDecimal(endIndex - startIndex), 3, BigDecimal.ROUND_HALF_UP);

				for(int i = startIndex + 1; i < endIndex; i++){
					caseFBigDecimalArray[i] = startValue.add(increment.multiply(new BigDecimal(i - startIndex)));
				}
			}
			// ADAP 배열 데이터 작성
			BigDecimal[] caseGBigDecimalArray = new BigDecimal[401];

			for(int i = 0; i < caseGBigDecimalArray.length; i++){
				caseGBigDecimalArray[i] = BigDecimal.ZERO;
			}

			caseGBigDecimalArray[0] = new BigDecimal("1");
			caseGBigDecimalArray[7] = new BigDecimal("2058");
			caseGBigDecimalArray[13] = new BigDecimal("13818");
			caseGBigDecimalArray[14] = new BigDecimal("14112");
			caseGBigDecimalArray[16] = new BigDecimal("14406");
			caseGBigDecimalArray[21] = new BigDecimal("14700");
			caseGBigDecimalArray[25] = new BigDecimal("14994");
			caseGBigDecimalArray[26] = new BigDecimal("15288");
			caseGBigDecimalArray[31] = new BigDecimal("15582");
			caseGBigDecimalArray[32] = new BigDecimal("15876");
			caseGBigDecimalArray[35] = new BigDecimal("16170");
			caseGBigDecimalArray[39] = new BigDecimal("16464");
			caseGBigDecimalArray[41] = new BigDecimal("16758");
			caseGBigDecimalArray[42] = new BigDecimal("17052");
			caseGBigDecimalArray[50] = new BigDecimal("17346");
			caseGBigDecimalArray[52] = new BigDecimal("17640");
			caseGBigDecimalArray[62] = new BigDecimal("23814");
			caseGBigDecimalArray[70] = new BigDecimal("24108");
			caseGBigDecimalArray[78] = new BigDecimal("24402");
			caseGBigDecimalArray[82] = new BigDecimal("32340");
			caseGBigDecimalArray[400] = new BigDecimal("161700");

			int[] caseGValues = {1, 2058, 13818, 14112, 14406, 14700, 14994, 15288, 15582, 15876, 16170, 16464, 16758, 17052, 17346, 17640, 23814, 24108, 24402, 32340, 161700};
			int[] caseGIndexes = {0, 7, 13, 14, 16, 21, 25, 26, 31, 32, 35, 39, 41, 42, 50, 52, 62, 70, 78, 82, 400};
			for (int j = 0; j < caseGIndexes.length - 1; j++) {
				int startIndex = caseGIndexes[j];
				int endIndex = caseGIndexes[j + 1];
				BigDecimal startValue = new BigDecimal(caseGValues[j]);
				BigDecimal endValue = j + 1 < caseGValues.length ? new BigDecimal(caseGValues[j + 1]) : BigDecimal.ZERO;
				BigDecimal increment = endValue.subtract(startValue).divide(new BigDecimal(endIndex - startIndex), 3, BigDecimal.ROUND_HALF_UP);

				for(int i = startIndex + 1; i < endIndex; i++){
					caseGBigDecimalArray[i] = startValue.add(increment.multiply(new BigDecimal(i - startIndex)));
				}
			}
			// Cool 배열 데이터 작성
			BigDecimal[] caseHBigDecimalArray = new BigDecimal[401];

			for(int i = 0; i < caseHBigDecimalArray.length; i++){
				caseHBigDecimalArray[i] = BigDecimal.ZERO;
			}

			caseHBigDecimalArray[0] = new BigDecimal("1");
			caseHBigDecimalArray[12] = new BigDecimal("2220");
			caseHBigDecimalArray[17] = new BigDecimal("4255");
			caseHBigDecimalArray[19] = new BigDecimal("4440");
			caseHBigDecimalArray[22] = new BigDecimal("5550");
			caseHBigDecimalArray[24] = new BigDecimal("5735");
			caseHBigDecimalArray[29] = new BigDecimal("5920");
			caseHBigDecimalArray[34] = new BigDecimal("6105");
			caseHBigDecimalArray[38] = new BigDecimal("6290");
			caseHBigDecimalArray[44] = new BigDecimal("6475");
			caseHBigDecimalArray[45] = new BigDecimal("8325");
			caseHBigDecimalArray[48] = new BigDecimal("8880");
			caseHBigDecimalArray[50] = new BigDecimal("10175");
			caseHBigDecimalArray[58] = new BigDecimal("12025");
			caseHBigDecimalArray[62] = new BigDecimal("12210");
			caseHBigDecimalArray[68] = new BigDecimal("12395");
			caseHBigDecimalArray[70] = new BigDecimal("12580");
			caseHBigDecimalArray[76] = new BigDecimal("12765");
			caseHBigDecimalArray[90] = new BigDecimal("16650");
			caseHBigDecimalArray[96] = new BigDecimal("17760");
			caseHBigDecimalArray[100] = new BigDecimal("18500");
			caseHBigDecimalArray[124] = new BigDecimal("22940");
			caseHBigDecimalArray[136] = new BigDecimal("30155");
			caseHBigDecimalArray[140] = new BigDecimal("30340");
			caseHBigDecimalArray[400] = new BigDecimal("79180");

			int[] caseHValues = {1, 2220, 4255, 4440, 5550, 5735, 5920, 6105, 6290, 6475, 8325, 8880, 10175, 12025, 12210, 12395, 12580, 12765, 16650, 17760, 18500, 22940, 30155, 30340, 79180};
			int[] caseHIndexes = {0, 12, 17, 19, 22, 24, 29, 34, 38, 44, 45, 48, 50, 58, 62, 68, 70, 76, 90, 96, 100, 124, 136, 140, 400};
			for (int j = 0; j < caseHIndexes.length - 1; j++) {
				int startIndex = caseHIndexes[j];
				int endIndex = caseHIndexes[j + 1];
				BigDecimal startValue = new BigDecimal(caseHValues[j]);
				BigDecimal endValue = j + 1 < caseHValues.length ? new BigDecimal(caseHValues[j + 1]) : BigDecimal.ZERO;
				BigDecimal increment = endValue.subtract(startValue).divide(new BigDecimal(endIndex - startIndex), 3, BigDecimal.ROUND_HALF_UP);

				for(int i = startIndex + 1; i < endIndex; i++){
					caseHBigDecimalArray[i] = startValue.add(increment.multiply(new BigDecimal(i - startIndex)));
				}
			}

			for(int ca = 0; ca < partsCaseHistoryVOList.size(); ca++) {
				PartsCaseHistoryVO partsCaseHistoryVO = partsCaseHistoryVOList.get(ca);
				BigDecimal QC = new BigDecimal(partsCaseHistoryVO.getQc());
				BigDecimal COOL = partsCaseHistoryVO.getCool();
				BigDecimal ADAP = partsCaseHistoryVO.getAdap();
				BigDecimal CASEAS = new BigDecimal(partsCaseHistoryVO.getCaseas());
				BigDecimal caseOne = CAS.add(CMT).add(CTH).divide(BigDecimal.valueOf(3)).subtract(new BigDecimal("3.89419544969697")).pow(2).negate();
				BigDecimal caseTwo = new BigDecimal("303.072584544466").pow(2);
				BigDecimal caseThree = caseOne.add(caseTwo);
				BigDecimal CASECV =  new BigDecimal(Math.sqrt(caseThree.doubleValue())).subtract(new BigDecimal("303.047565151515")).divide(BigDecimal.valueOf(100)).setScale(8, BigDecimal.ROUND_HALF_UP);// 보정수치
				
				BigDecimal calculation1 = BigDecimal.ZERO;
				BigDecimal calculation2 = BigDecimal.ZERO;
				BigDecimal calculation3 = BigDecimal.ZERO;
				BigDecimal calculation4 = BigDecimal.ZERO;
				BigDecimal calculation5 = BigDecimal.ZERO;
				BigDecimal calculation6 = BigDecimal.ZERO;
				BigDecimal calculation7 = BigDecimal.ZERO;
				BigDecimal calculation8 = BigDecimal.ZERO;
				BigDecimal calculation9 = BigDecimal.ZERO;
				
				calculation1 = QC.multiply(CQC).multiply(new BigDecimal("0.1"));
				calculation2 = new BigDecimal("1").subtract(calculation1);
				calculation3 = COOL.multiply(CTH).setScale(0, BigDecimal.ROUND_HALF_UP);
				if(0 == calculation3.compareTo(new BigDecimal("401"))) {
					calculation3 = new BigDecimal("400");
				}
				calculation4 = ADAP.multiply(CMT).setScale(0, BigDecimal.ROUND_HALF_UP);
				if(0 == calculation4.compareTo(new BigDecimal("401"))) {
					calculation4 = new BigDecimal("400");
				}
				calculation5 = CASEAS.multiply(CAS).setScale(0, BigDecimal.ROUND_HALF_UP);
				if(0 == calculation5.compareTo(new BigDecimal("401"))) {
					calculation5 = new BigDecimal("400");
				}
				calculation6			
				= caseFBigDecimalArray[calculation5.intValue()]
						.multiply(caseGBigDecimalArray[calculation4.intValue()])
						.multiply(caseHBigDecimalArray[calculation3.intValue()]);
				calculation7 = new BigDecimal(Math.pow(calculation6.doubleValue(), 1.0 / 3.0)).multiply(CASECV).setScale(6, BigDecimal.ROUND_HALF_UP);
				calculation8 = new BigDecimal("1").add(calculation7);
				calculation9 = GC.multiply(new BigDecimal("0.04"))
						.multiply(calculation8)
						.multiply(calculation2);
				
				partsCaseHistoryVO.setCaseValue(calculation9);
			}
			
			/*--------------------------------------------------
			 - 14-6. SSD Value = Basic*GC(조합되 견적에서의 GPU 칩셋)*0.0006*{1+War*0.01*CAS+FNC*0.001*CMT+CMF*(-0.1)*CQC+RLB*0.001*CSFT}
			 - 대입변수 변환
			 - [calculation1] Basic*GC*0.0006
			 - [calculation2] War*0.01*CAS
			 - [calculation3] FNC*0.001*CMT
			 - [calculation4] CMF*(-0.1)*CQC
			 - [calculation5] RLB*0.001*CSFT
			 - [calculation6] 1+[calculation2]+[calculation3]+[calculation4]+[calculation5]
			 - Ssd Value = [calculation1]*[calculation6] 
			 - 
			 - 23.12.14 SSD Value 변경
			 - SSD = PR(GPU)*0.001245*Basic*{1+f(FNC*소재custom)*g(WAR*AScustom)*h(RLB*안정성custom)/보정수치}*{1-(QC*QCcustom)}
			 - = GC*0.001245*Basic*{1+f(FNC*CMT)*g(WAR*CAS)*h(RLB*CSFT)/SSDCV}*{1-(QC*CQC)}
			*--------------------------------------------------*/
			// FNC 배열 데이터 작성
			BigDecimal[] ssdFBigDecimalArray = new BigDecimal[401];

			for(int i = 0; i < ssdFBigDecimalArray.length; i++){
				ssdFBigDecimalArray[i] = BigDecimal.ZERO;
			}

			ssdFBigDecimalArray[0] = new BigDecimal("1");
			ssdFBigDecimalArray[21] = new BigDecimal("672");
			ssdFBigDecimalArray[22] = new BigDecimal("768");
			ssdFBigDecimalArray[25] = new BigDecimal("896");
			ssdFBigDecimalArray[30] = new BigDecimal("960");
			ssdFBigDecimalArray[35] = new BigDecimal("1056");
			ssdFBigDecimalArray[37] = new BigDecimal("1120");
			ssdFBigDecimalArray[39] = new BigDecimal("1216");
			ssdFBigDecimalArray[41] = new BigDecimal("1312");
			ssdFBigDecimalArray[42] = new BigDecimal("1376");
			ssdFBigDecimalArray[44] = new BigDecimal("1440");
			ssdFBigDecimalArray[45] = new BigDecimal("1472");
			ssdFBigDecimalArray[49] = new BigDecimal("1504");
			ssdFBigDecimalArray[50] = new BigDecimal("1536");
			ssdFBigDecimalArray[51] = new BigDecimal("1568");
			ssdFBigDecimalArray[60] = new BigDecimal("1920");
			ssdFBigDecimalArray[70] = new BigDecimal("2240");
			ssdFBigDecimalArray[74] = new BigDecimal("2368");
			ssdFBigDecimalArray[78] = new BigDecimal("2496");
			ssdFBigDecimalArray[82] = new BigDecimal("2528");
			ssdFBigDecimalArray[84] = new BigDecimal("2688");
			ssdFBigDecimalArray[90] = new BigDecimal("2720");
			ssdFBigDecimalArray[98] = new BigDecimal("4768");
			ssdFBigDecimalArray[102] = new BigDecimal("4800");
			ssdFBigDecimalArray[400] = new BigDecimal("19200");

			int[] ssdFValues = {1, 672, 768, 896, 960, 1056, 1120, 1216, 1312, 1376, 1440, 1472, 1504, 1536, 1568, 1920, 2240, 2368, 2496, 2528, 2688, 2720, 4768, 4800, 19200};
			int[] ssdFIndexes = {0, 21, 22, 25, 30, 35, 37, 39, 41, 42, 44, 45, 49, 50, 51, 60, 70, 74, 78, 82, 84, 90, 98, 102, 400};
			for (int j = 0; j < ssdFIndexes.length - 1; j++) {
				int startIndex = ssdFIndexes[j];
				int endIndex = ssdFIndexes[j + 1];
				BigDecimal startValue = new BigDecimal(ssdFValues[j]);
				BigDecimal endValue = j + 1 < ssdFValues.length ? new BigDecimal(ssdFValues[j + 1]) : BigDecimal.ZERO;
				BigDecimal increment = endValue.subtract(startValue).divide(new BigDecimal(endIndex - startIndex), 3, BigDecimal.ROUND_HALF_UP);

				for(int i = startIndex + 1; i < endIndex; i++){
					ssdFBigDecimalArray[i] = startValue.add(increment.multiply(new BigDecimal(i - startIndex)));
				}
			}
			// WAR 배열 데이터 작성
			BigDecimal[] ssdGBigDecimalArray = new BigDecimal[401];

			for(int i = 0; i < ssdGBigDecimalArray.length; i++){
				ssdGBigDecimalArray[i] = BigDecimal.ZERO;
			}

			ssdGBigDecimalArray[0] = new BigDecimal("1");
			ssdGBigDecimalArray[12] = new BigDecimal("270");
			ssdGBigDecimalArray[24] = new BigDecimal("285");
			ssdGBigDecimalArray[36] = new BigDecimal("288");
			ssdGBigDecimalArray[48] = new BigDecimal("291");
			ssdGBigDecimalArray[60] = new BigDecimal("294");
			ssdGBigDecimalArray[72] = new BigDecimal("297");
			ssdGBigDecimalArray[96] = new BigDecimal("384");
			ssdGBigDecimalArray[120] = new BigDecimal("390");
			ssdGBigDecimalArray[400] = new BigDecimal("1320");

			int[] ssdGValues = {1, 270, 285, 288, 291, 294, 297, 384, 390, 1320};
			int[] ssdGIndexes = {0, 12, 24, 36, 48, 60, 72, 96, 120, 400};
			for (int j = 0; j < ssdGIndexes.length - 1; j++) {
				int startIndex = ssdGIndexes[j];
				int endIndex = ssdGIndexes[j + 1];
				BigDecimal startValue = new BigDecimal(ssdGValues[j]);
				BigDecimal endValue = j + 1 < ssdGValues.length ? new BigDecimal(ssdGValues[j + 1]) : BigDecimal.ZERO;
				BigDecimal increment = endValue.subtract(startValue).divide(new BigDecimal(endIndex - startIndex), 3, BigDecimal.ROUND_HALF_UP);

				for(int i = startIndex + 1; i < endIndex; i++){
					ssdGBigDecimalArray[i] = startValue.add(increment.multiply(new BigDecimal(i - startIndex)));
				}
			}
			// RLB 배열 데이터 작성
			BigDecimal[] ssdHBigDecimalArray = new BigDecimal[401];

			for(int i = 0; i < ssdHBigDecimalArray.length; i++){
				ssdHBigDecimalArray[i] = BigDecimal.ZERO;
			}

			ssdHBigDecimalArray[0] = new BigDecimal("1");
			ssdHBigDecimalArray[25] = new BigDecimal("589");
			ssdHBigDecimalArray[29] = new BigDecimal("608");
			ssdHBigDecimalArray[33] = new BigDecimal("665");
			ssdHBigDecimalArray[40] = new BigDecimal("684");
			ssdHBigDecimalArray[41] = new BigDecimal("703");
			ssdHBigDecimalArray[43] = new BigDecimal("1786");
			ssdHBigDecimalArray[44] = new BigDecimal("1805");
			ssdHBigDecimalArray[47] = new BigDecimal("1824");
			ssdHBigDecimalArray[50] = new BigDecimal("1843");
			ssdHBigDecimalArray[51] = new BigDecimal("1862");
			ssdHBigDecimalArray[58] = new BigDecimal("2033");
			ssdHBigDecimalArray[66] = new BigDecimal("2052");
			ssdHBigDecimalArray[80] = new BigDecimal("2071");
			ssdHBigDecimalArray[82] = new BigDecimal("2185");
			ssdHBigDecimalArray[86] = new BigDecimal("2204");
			ssdHBigDecimalArray[88] = new BigDecimal("2223");
			ssdHBigDecimalArray[94] = new BigDecimal("2242");
			ssdHBigDecimalArray[100] = new BigDecimal("2299");
			ssdHBigDecimalArray[102] = new BigDecimal("2318");
			ssdHBigDecimalArray[400] = new BigDecimal("9120");

			int[] ssdHValues = {1, 589, 608, 665, 684, 703, 1786, 1805, 1824, 1843, 1862, 2033, 2052, 2071, 2185, 2204, 2223, 2242, 2299, 2318, 9120};
			int[] ssdHIndexes = {0, 25, 29, 33, 40, 41, 43, 44, 47, 50, 51, 58, 66, 80, 82, 86, 88, 94, 100, 102, 400};
			for (int j = 0; j < ssdHIndexes.length - 1; j++) {
				int startIndex = ssdHIndexes[j];
				int endIndex = ssdHIndexes[j + 1];
				BigDecimal startValue = new BigDecimal(ssdHValues[j]);
				BigDecimal endValue = j + 1 < ssdHValues.length ? new BigDecimal(ssdHValues[j + 1]) : BigDecimal.ZERO;
				BigDecimal increment = endValue.subtract(startValue).divide(new BigDecimal(endIndex - startIndex), 3, BigDecimal.ROUND_HALF_UP);

				for(int i = startIndex + 1; i < endIndex; i++){
					ssdHBigDecimalArray[i] = startValue.add(increment.multiply(new BigDecimal(i - startIndex)));
				}
			}

			for(int ss = 0; ss < partsSsdHistoryVOList.size(); ss++) {
				PartsSsdHistoryVO partsSsdHistoryVO = partsSsdHistoryVOList.get(ss);
				BigDecimal QC = new BigDecimal(partsSsdHistoryVO.getQc());
				BigDecimal RLB = partsSsdHistoryVO.getRlb();
				BigDecimal WAR = new BigDecimal(partsSsdHistoryVO.getWar()).multiply(new BigDecimal("12"));
				BigDecimal FNC = new BigDecimal(partsSsdHistoryVO.getFnc());
				BigDecimal ssdOne = CAS.add(CMT).add(CSFT).divide(BigDecimal.valueOf(3)).subtract(new BigDecimal("3.54346273182768")).pow(2).negate();
				BigDecimal ssdTwo = new BigDecimal("26.4850395509368").pow(2);
				BigDecimal ssdThree = ssdOne.add(ssdTwo);
				BigDecimal SSDCV =  new BigDecimal(Math.sqrt(ssdThree.doubleValue())).subtract(new BigDecimal("26.2469272845953")).divide(BigDecimal.valueOf(100)).setScale(8, BigDecimal.ROUND_HALF_UP);// 보정수치
				BigDecimal BASIC = partsSsdHistoryVO.getBasic();
				BigDecimal calculation1 = BigDecimal.ZERO;
				BigDecimal calculation2 = BigDecimal.ZERO;
				BigDecimal calculation3 = BigDecimal.ZERO;
				BigDecimal calculation4 = BigDecimal.ZERO;
				BigDecimal calculation5 = BigDecimal.ZERO;
				BigDecimal calculation6 = BigDecimal.ZERO;
				BigDecimal calculation7 = BigDecimal.ZERO;
				BigDecimal calculation8 = BigDecimal.ZERO;
				BigDecimal calculation9 = BigDecimal.ZERO;
				
				// 23.12.18 가성비 제품 선택 시 과도한 PSU제품 선택에 의한 밸류 기본값 조정 - 임시방편으로 수행됨. 추후 뻥파워 이슈 제품을 거를 방법 선정해야함.
				// BigDecimal customCheck = CMT.add(CSFT).add(CAS);
				// if(customCheck.compareTo(BigDecimal.ZERO) == 0) {
				// 	BASIC = BigDecimal.ZERO;
				// }
				
				calculation1 = QC.multiply(CQC).multiply(new BigDecimal("0.1"));
				calculation2 = new BigDecimal("1").subtract(calculation1);
				calculation3 = RLB.multiply(CSFT).setScale(0, BigDecimal.ROUND_HALF_UP);
				if(0 == calculation3.compareTo(new BigDecimal("401"))) {
					calculation3 = new BigDecimal("400");
				}
				calculation4 = WAR.multiply(CAS).setScale(0, BigDecimal.ROUND_HALF_UP);
				if(0 == calculation4.compareTo(new BigDecimal("401"))) {
					calculation4 = new BigDecimal("400");
				}
				calculation5 = FNC.multiply(CMT).setScale(0, BigDecimal.ROUND_HALF_UP);
				if(0 == calculation5.compareTo(new BigDecimal("401"))) {
					calculation5 = new BigDecimal("400");
				}
				calculation6 				
				= ssdFBigDecimalArray[calculation5.intValue()]
						.multiply(ssdGBigDecimalArray[calculation4.intValue()])
						.multiply(ssdHBigDecimalArray[calculation3.intValue()]);
				calculation7 = new BigDecimal(Math.pow(calculation6.doubleValue(), 1.0 / 3.0)).multiply(SSDCV).setScale(6, BigDecimal.ROUND_HALF_UP); 
				calculation8 = new BigDecimal("1").add(calculation7);
				calculation9 = GC.multiply(new BigDecimal("0.001245"))
						.multiply(BASIC)
						.multiply(calculation8)
						.multiply(calculation2)
						.setScale(6, BigDecimal.ROUND_HALF_UP);

				partsSsdHistoryVO.setSsdValue(calculation9);
			}
			
			/*--------------------------------------------------
			 - 15.  MB를 제외한 모든 테이블에서 Value가 더 낮음과 동시에 Price가 더 높은 
			 - (완벽한 하위 호환에 있는)제품이 있는 경우 하위 호환 제품을 소거한다.
			 - 
			 - gpu 소거로직과 동일함.
			 - 모든 부품별로 돌려야함.(mb 제외)
			*--------------------------------------------------*/
			
			/*--------------------------------------------------
			 - 15-1. CPU Value 기준 소거처리부 
			*--------------------------------------------------*/
			for(int i = partsCpuHistoryVOList.size()-1; i >= 1; i--) {
				int targetIndex = i-1;
				
				BigDecimal value1 = partsCpuHistoryVOList.get(targetIndex).getCpuValue();
				BigDecimal value2 = partsCpuHistoryVOList.get(targetIndex+1).getCpuValue();
				
				int compareResult1 = value1.compareTo(value2);
				
				if(compareResult1 < 0) {
					// value1 < value2
					continue;
				}
				
				// 중첩 반복(대상 인덱스로부터 위로 검증)
				int zTargetSize = partsCpuHistoryVOList.size();
				for(int z = targetIndex+1; z < zTargetSize; z++) {
					if(z == zTargetSize) {
						break;
					}
					BigDecimal value3 = partsCpuHistoryVOList.get(z).getCpuValue();
					
					int compareResult2 = value1.compareTo(value3);
					if(compareResult2 > 0 || compareResult2 == 0) {
						// value1 > value3 or value1 == value3
						partsCpuHistoryVOList.remove(z);
						--zTargetSize;
						--z;
					}
				}
			}
			
			/*--------------------------------------------------
			 - 15-2. RAM Value 기준 소거처리부 
			*--------------------------------------------------*/

			// ram value 소거법 적용 전 로직 추가(mem_soc_cd : PRT024) 23.10.10
//			MEM SOC	01	DDR2
//			MEM SOC	02	DDR3
//			MEM SOC	03	DDR4
//			MEM SOC	04	DDR5

			List<PartsRamHistoryVO> PRT024_03_List = new ArrayList<>();
			List<PartsRamHistoryVO> PRT024_04_List = new ArrayList<>();
			List<PartsRamHistoryVO> ramEtcList = new ArrayList<>();
			// etc 01, 02
			
			for(int i = 0; i < partsRamHistoryVOList.size(); i++) {
				if("03".equals(partsRamHistoryVOList.get(i).getMemSocCd())) {
					PRT024_03_List.add(partsRamHistoryVOList.get(i));
				}else if("04".equals(partsRamHistoryVOList.get(i).getMemSocCd())) {
					PRT024_04_List.add(partsRamHistoryVOList.get(i));
				}else {
					ramEtcList.add(partsRamHistoryVOList.get(i));
				}
			}
			
			valueEraseProcessingByRam(PRT024_03_List);
			valueEraseProcessingByRam(PRT024_04_List);
			valueEraseProcessingByRam(ramEtcList);
			
			partsRamHistoryVOList = new ArrayList<>();
			
			for(int i = 0; i < PRT024_03_List.size(); i++) {
				partsRamHistoryVOList.add(PRT024_03_List.get(i));
			}
			
			for(int i = 0; i < PRT024_04_List.size(); i++) {
				partsRamHistoryVOList.add(PRT024_04_List.get(i));
			}
			
			for(int i = 0; i < ramEtcList.size(); i++) {
				partsRamHistoryVOList.add(ramEtcList.get(i));
			}
			
			// test 23.09.15
//			if(partsGpuHistoryVOList.get(gpuIndex).getId().equals("GPU000169")
//					) {
//				System.out.println("################# 드러오냐 #########################");
//			}
			
			
			/*--------------------------------------------------
			 - 15-4. Psu Value 기준 소거처리부 
			 - 23.12.17 소거 조건추가
			*--------------------------------------------------*/
			
			BigDecimal zeroPsuCheck = BigDecimal.ZERO;
			BigDecimal customPsuCheck = CSFT.add(CAS).add(CMT);
			
			if(zeroPsuCheck.compareTo(customPsuCheck) > 0) {
				
			
				for(int i = partsPsuHistoryVOList.size()-1; i >= 1; i--) {
					int targetIndex = i-1;
					
					BigDecimal value1 = partsPsuHistoryVOList.get(targetIndex).getPsuValue();
					BigDecimal value2 = partsPsuHistoryVOList.get(targetIndex+1).getPsuValue();
					
					int compareResult1 = value1.compareTo(value2);
					
					if(compareResult1 < 0) {
						// value1 < value2
						continue;
					}
					
					// 중첩 반복(대상 인덱스로부터 위로 검증)
					int zTargetSize = partsPsuHistoryVOList.size();
					for(int z = targetIndex+1; z < zTargetSize; z++) {
						if(z == zTargetSize) {
							break;
						}
						BigDecimal value3 = partsPsuHistoryVOList.get(z).getPsuValue();
						
						int compareResult2 = value1.compareTo(value3);
						if(compareResult2 > 0 || compareResult2 == 0) {
							// value1 > value3 or value1 == value3
							partsPsuHistoryVOList.remove(z);
							--zTargetSize;
							--z;
						}
					}
				}
			}
			
			/*--------------------------------------------------
			 - 15-5. Case Value 기준 소거처리부 
			 - 23.12.17 소거 조건추가
			*--------------------------------------------------*/
			
			BigDecimal zeroCaseCheck = BigDecimal.ZERO;
			BigDecimal customCaseCheck = CTH.add(CAS).add(CMT);
			
			if(zeroCaseCheck.compareTo(customCaseCheck) > 0) {
			
				for(int i = partsCaseHistoryVOList.size()-1; i >= 1; i--) {
					int targetIndex = i-1;
					
					BigDecimal value1 = partsCaseHistoryVOList.get(targetIndex).getCaseValue();
					BigDecimal value2 = partsCaseHistoryVOList.get(targetIndex+1).getCaseValue();
					
					int compareResult1 = value1.compareTo(value2);
					
					if(compareResult1 < 0) {
						// value1 < value2
						continue;
					}
					
					// 중첩 반복(대상 인덱스로부터 위로 검증)
					int zTargetSize = partsCaseHistoryVOList.size();
					for(int z = targetIndex+1; z < zTargetSize; z++) {
						if(z == zTargetSize) {
							break;
						}
						BigDecimal value3 = partsCaseHistoryVOList.get(z).getCaseValue();
						
						int compareResult2 = value1.compareTo(value3);
						if(compareResult2 > 0 || compareResult2 == 0) {
							// value1 > value3 or value1 == value3
							partsCaseHistoryVOList.remove(z);
							--zTargetSize;
							--z;
						}
					}
				}
			}
			
			
			/*--------------------------------------------------
			 - 15-6. Ssd Value 기준 소거처리부 
			 - 23.12.17 소거 조건추가
			*--------------------------------------------------*/
			
			// ssd value 소거법 적용 전 로직 추가(scs_cd : PRT008) 23.10.06
//			PRT008
//			SCS	01	SATA3
//			SCS	02	PCIe 2.0
//			SCS	03	PCIe 3.0
//			SCS	04	PCIe 4.0
//			SCS	05	PCIe 5.0

//			List<PartsSsdHistoryVO> PRT008_01_List = new ArrayList<>();
//			List<PartsSsdHistoryVO> PRT008_03_List = new ArrayList<>();
//			List<PartsSsdHistoryVO> PRT008_04_List = new ArrayList<>();
//			List<PartsSsdHistoryVO> PRT008_05_List = new ArrayList<>();
//			List<PartsSsdHistoryVO> etcList = new ArrayList<>();
//			// 02 = etc
//			
//			for(int i = 0; i < partsSsdHistoryVOList.size(); i++) {
//				if("01".equals(partsSsdHistoryVOList.get(i).getScsCd())) {
//					PRT008_01_List.add(partsSsdHistoryVOList.get(i));
//				}else if("03".equals(partsSsdHistoryVOList.get(i).getScsCd())) {
//					PRT008_03_List.add(partsSsdHistoryVOList.get(i));
//				}else if("04".equals(partsSsdHistoryVOList.get(i).getScsCd())) {
//					PRT008_04_List.add(partsSsdHistoryVOList.get(i));
//				}else if("05".equals(partsSsdHistoryVOList.get(i).getScsCd())) {
//					PRT008_05_List.add(partsSsdHistoryVOList.get(i));
//				}else {
//					etcList.add(partsSsdHistoryVOList.get(i));
//				}
//			}
//			
//			// PRT008_01_List 소거
//			valueEraseProcessingBySsd(PRT008_01_List);
//			
//			// PRT008_03_List 소거
//			valueEraseProcessingBySsd(PRT008_03_List);
//			
//			// PRT008_04_List 소거
//			valueEraseProcessingBySsd(PRT008_04_List);
//			
//			// PRT008_05_List 소거
//			valueEraseProcessingBySsd(PRT008_05_List);
//			
//			// etcList 소거
//			valueEraseProcessingBySsd(etcList);
			
			// ssd value 소거법 적용 전 로직 추가(volume : code 아님. 정수형 데이터 발주처 제공) 23.10.09
//			[SSD] / [DVOL]
//					256
//					512
//					1024
//					2048
//					4096

			// 아이 시발 scs_cd랑 volume이랑 경우의 수 각각 둬서 리스트업 해야함.. 23.10.10
			
			BigDecimal zeroSsdCheck = BigDecimal.ZERO;
			BigDecimal customSsdCheck = CSFT.add(CAS).add(CMT);
			
			if(zeroSsdCheck.compareTo(customSsdCheck) > 0) {
				
				List<PartsSsdHistoryVO> PRT008_01and256_List = new ArrayList<>();
				List<PartsSsdHistoryVO> PRT008_01and512_List = new ArrayList<>();
				List<PartsSsdHistoryVO> PRT008_01and1024_List = new ArrayList<>();
				List<PartsSsdHistoryVO> PRT008_01and2048_List = new ArrayList<>();
				List<PartsSsdHistoryVO> PRT008_01and4096_List = new ArrayList<>();
				List<PartsSsdHistoryVO> PRT008_03and256_List = new ArrayList<>();
				List<PartsSsdHistoryVO> PRT008_03and512_List = new ArrayList<>();
				List<PartsSsdHistoryVO> PRT008_03and1024_List = new ArrayList<>();
				List<PartsSsdHistoryVO> PRT008_03and2048_List = new ArrayList<>();
				List<PartsSsdHistoryVO> PRT008_03and4096_List = new ArrayList<>();
				List<PartsSsdHistoryVO> PRT008_04and256_List = new ArrayList<>();
				List<PartsSsdHistoryVO> PRT008_04and512_List = new ArrayList<>();
				List<PartsSsdHistoryVO> PRT008_04and1024_List = new ArrayList<>();
				List<PartsSsdHistoryVO> PRT008_04and2048_List = new ArrayList<>();
				List<PartsSsdHistoryVO> PRT008_04and4096_List = new ArrayList<>();
				List<PartsSsdHistoryVO> PRT008_05and256_List = new ArrayList<>();
				List<PartsSsdHistoryVO> PRT008_05and512_List = new ArrayList<>();
				List<PartsSsdHistoryVO> PRT008_05and1024_List = new ArrayList<>();
				List<PartsSsdHistoryVO> PRT008_05and2048_List = new ArrayList<>();
				List<PartsSsdHistoryVO> PRT008_05and4096_List = new ArrayList<>();
				
				List<PartsSsdHistoryVO> ssdEtcList = new ArrayList<>();
				
				for(int i = 0; i < partsSsdHistoryVOList.size(); i++) {
					if("01".equals(partsSsdHistoryVOList.get(i).getScsCd())) {
						if(256 == partsSsdHistoryVOList.get(i).getVolume()) {
							PRT008_01and256_List.add(partsSsdHistoryVOList.get(i));
						}else if(512 == partsSsdHistoryVOList.get(i).getVolume()) {
							PRT008_01and512_List.add(partsSsdHistoryVOList.get(i));
						}else if(1024 == partsSsdHistoryVOList.get(i).getVolume()) {
							PRT008_01and1024_List.add(partsSsdHistoryVOList.get(i));
						}else if(2048 == partsSsdHistoryVOList.get(i).getVolume()) {
							PRT008_01and2048_List.add(partsSsdHistoryVOList.get(i));
						}else if(4096 == partsSsdHistoryVOList.get(i).getVolume()) {
							PRT008_01and4096_List.add(partsSsdHistoryVOList.get(i));
						}else {
							ssdEtcList.add(partsSsdHistoryVOList.get(i));
						}
					}else if("03".equals(partsSsdHistoryVOList.get(i).getScsCd())) {
						if(256 == partsSsdHistoryVOList.get(i).getVolume()) {
							PRT008_03and256_List.add(partsSsdHistoryVOList.get(i));
						}else if(512 == partsSsdHistoryVOList.get(i).getVolume()) {
							PRT008_03and512_List.add(partsSsdHistoryVOList.get(i));
						}else if(1024 == partsSsdHistoryVOList.get(i).getVolume()) {
							PRT008_03and1024_List.add(partsSsdHistoryVOList.get(i));
						}else if(2048 == partsSsdHistoryVOList.get(i).getVolume()) {
							PRT008_03and2048_List.add(partsSsdHistoryVOList.get(i));
						}else if(4096 == partsSsdHistoryVOList.get(i).getVolume()) {
							PRT008_03and4096_List.add(partsSsdHistoryVOList.get(i));
						}else {
							ssdEtcList.add(partsSsdHistoryVOList.get(i));
						}
					}else if("04".equals(partsSsdHistoryVOList.get(i).getScsCd())) {
						if(256 == partsSsdHistoryVOList.get(i).getVolume()) {
							PRT008_04and256_List.add(partsSsdHistoryVOList.get(i));
						}else if(512 == partsSsdHistoryVOList.get(i).getVolume()) {
							PRT008_04and512_List.add(partsSsdHistoryVOList.get(i));
						}else if(1024 == partsSsdHistoryVOList.get(i).getVolume()) {
							PRT008_04and1024_List.add(partsSsdHistoryVOList.get(i));
						}else if(2048 == partsSsdHistoryVOList.get(i).getVolume()) {
							PRT008_04and2048_List.add(partsSsdHistoryVOList.get(i));
						}else if(4096 == partsSsdHistoryVOList.get(i).getVolume()) {
							PRT008_04and4096_List.add(partsSsdHistoryVOList.get(i));
						}else {
							ssdEtcList.add(partsSsdHistoryVOList.get(i));
						}
					}else if("05".equals(partsSsdHistoryVOList.get(i).getScsCd())) {
						if(256 == partsSsdHistoryVOList.get(i).getVolume()) {
							PRT008_05and256_List.add(partsSsdHistoryVOList.get(i));
						}else if(512 == partsSsdHistoryVOList.get(i).getVolume()) {
							PRT008_05and512_List.add(partsSsdHistoryVOList.get(i));
						}else if(1024 == partsSsdHistoryVOList.get(i).getVolume()) {
							PRT008_05and1024_List.add(partsSsdHistoryVOList.get(i));
						}else if(2048 == partsSsdHistoryVOList.get(i).getVolume()) {
							PRT008_05and2048_List.add(partsSsdHistoryVOList.get(i));
						}else if(4096 == partsSsdHistoryVOList.get(i).getVolume()) {
							PRT008_05and4096_List.add(partsSsdHistoryVOList.get(i));
						}else {
							ssdEtcList.add(partsSsdHistoryVOList.get(i));
						}
					}else {
						ssdEtcList.add(partsSsdHistoryVOList.get(i));
					}
				}
				
				valueEraseProcessingBySsd(PRT008_01and256_List);
				valueEraseProcessingBySsd(PRT008_01and512_List);
				valueEraseProcessingBySsd(PRT008_01and1024_List);
				valueEraseProcessingBySsd(PRT008_01and2048_List);
				valueEraseProcessingBySsd(PRT008_01and4096_List);
				valueEraseProcessingBySsd(PRT008_03and256_List);
				valueEraseProcessingBySsd(PRT008_03and512_List);
				valueEraseProcessingBySsd(PRT008_03and1024_List);
				valueEraseProcessingBySsd(PRT008_03and2048_List);
				valueEraseProcessingBySsd(PRT008_03and4096_List);
				valueEraseProcessingBySsd(PRT008_04and256_List);
				valueEraseProcessingBySsd(PRT008_04and512_List);
				valueEraseProcessingBySsd(PRT008_04and1024_List);
				valueEraseProcessingBySsd(PRT008_04and2048_List);
				valueEraseProcessingBySsd(PRT008_04and4096_List);
				valueEraseProcessingBySsd(PRT008_05and256_List);
				valueEraseProcessingBySsd(PRT008_05and512_List);
				valueEraseProcessingBySsd(PRT008_05and1024_List);
				valueEraseProcessingBySsd(PRT008_05and2048_List);
				valueEraseProcessingBySsd(PRT008_05and4096_List);
				valueEraseProcessingBySsd(ssdEtcList);
				
				// 각각 소거 후 리스트화
				partsSsdHistoryVOList = new ArrayList<>();
				
				// 기존리스트에 결과리스트 삽입
				addListBySsd(partsSsdHistoryVOList, PRT008_01and256_List);
				addListBySsd(partsSsdHistoryVOList, PRT008_01and512_List);
				addListBySsd(partsSsdHistoryVOList, PRT008_01and1024_List);
				addListBySsd(partsSsdHistoryVOList, PRT008_01and2048_List);
				addListBySsd(partsSsdHistoryVOList, PRT008_01and4096_List);
				addListBySsd(partsSsdHistoryVOList, PRT008_03and256_List);
				addListBySsd(partsSsdHistoryVOList, PRT008_03and512_List);
				addListBySsd(partsSsdHistoryVOList, PRT008_03and1024_List);
				addListBySsd(partsSsdHistoryVOList, PRT008_03and2048_List);
				addListBySsd(partsSsdHistoryVOList, PRT008_03and4096_List);
				addListBySsd(partsSsdHistoryVOList, PRT008_04and256_List);
				addListBySsd(partsSsdHistoryVOList, PRT008_04and512_List);
				addListBySsd(partsSsdHistoryVOList, PRT008_04and1024_List);
				addListBySsd(partsSsdHistoryVOList, PRT008_04and2048_List);
				addListBySsd(partsSsdHistoryVOList, PRT008_04and4096_List);
				addListBySsd(partsSsdHistoryVOList, PRT008_05and256_List);
				addListBySsd(partsSsdHistoryVOList, PRT008_05and512_List);
				addListBySsd(partsSsdHistoryVOList, PRT008_05and1024_List);
				addListBySsd(partsSsdHistoryVOList, PRT008_05and2048_List);
				addListBySsd(partsSsdHistoryVOList, PRT008_05and4096_List);
				addListBySsd(partsSsdHistoryVOList, ssdEtcList);
				
			}

			/*--------------------------------------------------
			 - 16. BN이 α번째 GPU>CPU인 CPU제품들을 모두 소거한다. 
			*--------------------------------------------------*/
			int gpuBn = partsGpuHistoryVOList.get(gpuIndex).getBn();
			
			for(int i = partsCpuHistoryVOList.size()-1; i >= 0; i--) {
				if(gpuBn > partsCpuHistoryVOList.get(i).getBn()) {
					partsCpuHistoryVOList.remove(i);
				}
			}
			
			/*--------------------------------------------------
			 - 16-1. 선택된 GPU가 gled_cd = 00 = APU 일 때
			 - CPU List에서 apu column과 값이 같지 않은 경우 소거처리
			 - 23.11.07 추가 
			*--------------------------------------------------*/
			if("00".equals(partsGpuHistoryVOList.get(gpuIndex).getGledCd())) {
				String gpuName = partsGpuHistoryVOList.get(gpuIndex).getPartsName();
				
				for(int i = partsCpuHistoryVOList.size()-1; i >= 0; i--) {
					if(!gpuName.equals(partsCpuHistoryVOList.get(i).getApu())) {
						partsCpuHistoryVOList.remove(i);
					}
				}
			}
			
			/*--------------------------------------------------
			 - 17. VC=<Price인 CPU제품을 모두 소거한다. 
			*--------------------------------------------------*/
			for(int i = partsCpuHistoryVOList.size()-1; i >= 0; i--) {
				BigDecimal cpuPrice = new BigDecimal(partsCpuHistoryVOList.get(i).getPartsPrice());
				int compareResult = VC.compareTo(cpuPrice);
				if(compareResult < 0 || compareResult == 0) {
					partsCpuHistoryVOList.remove(i);
				}
			}
			
			/*--------------------------------------------------
			 - 18. 남은 CPU의 개수를 limβ라고 한다.
			 - limβ<β라면 아래 변수 정렬 후 12번으로 돌아간다.
			 - (소거된 제품도 12번 시점으로 롤백한다.)
			 - VC=VC+α번째 GPU의 Price
			 - α=α+1, β=1, γ=1, k=1, p=1, q=1, x=1, y=1
			 - (α는 반복문 기준 index이므로 따로 +1을 하지 않아도 반복문 넘기면 자연히
			 - 인덱스가 상승하므로 처리하지 않는다.)
			 - limβ>=β라면 연산을 이어간다.
			 - VC=VC-β번째 CPU의 Price이다.
			*--------------------------------------------------*/
			// 18번 시점에서 백업데이터. 추후 구현할 24번에서 롤백 할 백업데이터로 쓰인다.
			List<PartsMbHistoryVO> partsMbHistoryVOListAlgorithm18Backup = new ArrayList<>();
			List<PartsCoolerHistoryVO> partsCoolerHistoryVOListAlgorithm18Backup = new ArrayList<>();
			List<PartsCaseHistoryVO> partsCaseHistoryVOListAlgorithm18Backup = new ArrayList<>();
			List<PartsPsuHistoryVO> partsPsuHistoryVOListAlgorithm18Backup = new ArrayList<>();
			List<PartsRamHistoryVO> partsRamHistoryVOListAlgorithm18Backup = new ArrayList<>();
			List<PartsSsdHistoryVO> partsSsdHistoryVOListAlgorithm18Backup = new ArrayList<>();
			BigDecimal VC18Backup = VC;

			for(int i = 0; i < partsMbHistoryVOList.size(); i++) {
				partsMbHistoryVOListAlgorithm18Backup.add(partsMbHistoryVOList.get(i));
			}
			
			for(int i = 0; i < partsCoolerHistoryVOList.size(); i++) {
				partsCoolerHistoryVOListAlgorithm18Backup.add(partsCoolerHistoryVOList.get(i));
			}
			
			for(int i = 0; i < partsCaseHistoryVOList.size(); i++) {
				partsCaseHistoryVOListAlgorithm18Backup.add(partsCaseHistoryVOList.get(i));
			}
			
			for(int i = 0; i < partsPsuHistoryVOList.size(); i++) {
				partsPsuHistoryVOListAlgorithm18Backup.add(partsPsuHistoryVOList.get(i));
			}
			
			for(int i = 0; i < partsRamHistoryVOList.size(); i++) {
				partsRamHistoryVOListAlgorithm18Backup.add(partsRamHistoryVOList.get(i));
			}
			
			addListBySsd(partsSsdHistoryVOListAlgorithm18Backup, partsSsdHistoryVOList);
			
			int limβ = partsCpuHistoryVOList.size();
			
			if(limβ <= β) {
				// limβ<β라면 아래 변수 정렬 후 12번으로 돌아간다. -> limβ<=β
				
//				VC = VC.add(new BigDecimal(partsGpuHistoryVOList.get(gpuIndex).getPartsPrice()));
				β = 0;
				γ = 0;
				k = 0;
				p = 0;
				q = 0;
				x = 0;
				y = 0;
				
				continue; // 13번 처음 for 다음 gpuIndex 진행
			}
			
			// limβ>=β라면 연산을 이어간다. -> limβ>β
			for(int cpuIndex = β; cpuIndex < limβ; cpuIndex++) {
				/*--------------------------------------------------
				 - 18-1. 18번백업데이터 기준으로 데이터복원처리
				*--------------------------------------------------*/
				partsMbHistoryVOList = new ArrayList<>();
				partsCoolerHistoryVOList = new ArrayList<>();
				partsCaseHistoryVOList = new ArrayList<>();
				partsPsuHistoryVOList = new ArrayList<>();
				partsRamHistoryVOList = new ArrayList<>();
				partsSsdHistoryVOList = new ArrayList<>();
				VC = VC18Backup;
				
				for(int i = 0; i < partsMbHistoryVOListAlgorithm18Backup.size(); i++) {
					partsMbHistoryVOList.add(partsMbHistoryVOListAlgorithm18Backup.get(i));
				}
				
				for(int i = 0; i < partsCoolerHistoryVOListAlgorithm18Backup.size(); i++) {
					partsCoolerHistoryVOList.add(partsCoolerHistoryVOListAlgorithm18Backup.get(i));
				}
				
				for(int i = 0; i < partsCaseHistoryVOListAlgorithm18Backup.size(); i++) {
					partsCaseHistoryVOList.add(partsCaseHistoryVOListAlgorithm18Backup.get(i));
				}
				
				for(int i = 0; i < partsPsuHistoryVOListAlgorithm18Backup.size(); i++) {
					partsPsuHistoryVOList.add(partsPsuHistoryVOListAlgorithm18Backup.get(i));
				}
				
				for(int i = 0; i < partsRamHistoryVOListAlgorithm18Backup.size(); i++) {
					partsRamHistoryVOList.add(partsRamHistoryVOListAlgorithm18Backup.get(i));
				}
				
				addListBySsd(partsSsdHistoryVOList, partsSsdHistoryVOListAlgorithm18Backup);
				
				/*--------------------------------------------------
				 - 18-2. 현재 진행 cpu Index의 가격 빼기
				*--------------------------------------------------*/
				VC = VC.subtract(new BigDecimal(partsCpuHistoryVOList.get(cpuIndex).getPartsPrice()));
				
				/*--------------------------------------------------
				 - 18-3. Thermal이 β번째 CPU+CTH*5>Cooler인 모든 Cooler제품을 소거한다.
				*--------------------------------------------------*/

				
				
				BigDecimal cpu_thermal = new BigDecimal(partsCpuHistoryVOList.get(cpuIndex).getThermal());
				BigDecimal algorithm26TargetData = CTH.multiply(new BigDecimal("5")).add(cpu_thermal);
				for(int i = partsCoolerHistoryVOList.size()-1; i >= 0; i--) {
					BigDecimal Thermal = new BigDecimal(partsCoolerHistoryVOList.get(i).getThermal());
					int compareResult = algorithm26TargetData.compareTo(Thermal);
					if(compareResult > 0) {
						partsCoolerHistoryVOList.remove(i);
					}
				}
				

				
				
				/*--------------------------------------------------
				 - 18-4. Cooler Value 기준 소거처리부 
				*--------------------------------------------------*/
				// cooler value 소거법 적용 전 로직 추가(formula_cd : PRT020) 23.10.06
//				PRT020
//				formula	01	AC
//				formula	02	WC
				

				List<PartsCoolerHistoryVO> PRT020_01_List = new ArrayList<>();
				List<PartsCoolerHistoryVO> PRT020_02_List = new ArrayList<>();
				// etc 취급안함.
				
				for(int i = 0; i < partsCoolerHistoryVOList.size(); i++) {
					if("01".equals(partsCoolerHistoryVOList.get(i).getFormulaCd())) {
						PRT020_01_List.add(partsCoolerHistoryVOList.get(i));
					}else {
						PRT020_02_List.add(partsCoolerHistoryVOList.get(i));
					}
				}
				
				// PRT020_01_List 소거
				valueEraseProcessingByCooler(PRT020_01_List);
				
				// PRT020_02_List 소거
				valueEraseProcessingByCooler(PRT020_02_List);
				
				// PRT020_01_List, PRT020_02_List 각각 소거 후 리스트화
				partsCoolerHistoryVOList = new ArrayList<>();
				
				for(int i = 0; i < PRT020_01_List.size(); i++) {
					partsCoolerHistoryVOList.add(PRT020_01_List.get(i));
				}
				
				for(int i = 0; i < PRT020_02_List.size(); i++) {
					partsCoolerHistoryVOList.add(PRT020_02_List.get(i));
				}
					
				
				
				/*--------------------------------------------------
				 - 19. CC(β번째 선택된 CPU)를 계산하여 MB테이블의 모든 제품 Value를 계산한다.
				 - MB Value = CPU Value*0.4*(1+AS(MBAS)*0.001*CAS+Port*0.001*CMT+BIOS*0.0001*CSFT)
				 - 대입변수 변환
				 - [calculation1] CPU Value*0.4
				 - [calculation2] MBAS*0.001*CAS
				 - [calculation3] Port*0.001*CMT
				 - [calculation4] BIOS*0.0001*CSFT
				 - [calculation5] 1+[calculation2]+[calculation3]+[calculation4]
				 - Mb Value = [calculation1]*[calculation5]
				 -
				 - 23.12.14 MB Value 변경
				 - MB Value = PR(GPU)*0.03*{1+f(MBAS*AScustom)*g(PORT*소재custom)*h(BIOS*안정성custom)/보정수치}*{1-(QC*QCcustom)}
				 - = GC*0.03*{1+f(MBAS*CAS)*g(PORT*CMT)*h(BIOS*CSFT)/MBCV}*{1-(QC*CQC)}
				 - 수식 잘못됨. 다시 전달받음.
				 - MB Value = PR(CPU)*0.6*{1+f(MBAS*AScustom)*g(PORT*소재custom)*h(BIOS*안정성custom)/보정수치}*{1-(QC*QCcustom)}
				 - = CC*0.6*{1+f(MBAS*CAS)*g(PORT*CMT)*h(BIOS*CSFT)/MBCV}*{1-(QC*CQC)}
				*--------------------------------------------------*/
				BigDecimal CC = partsCpuHistoryVOList.get(cpuIndex).getCpuValue();
				
				// maker as_score -> mbas 값 이식
				for(int ma = 0; ma < partsMakerHistoryVOList.size(); ma++) {
					for(int z = 0; z < partsMbHistoryVOList.size(); z++) {
						if(partsMakerHistoryVOList.get(ma).getId().equals(partsMbHistoryVOList.get(z).getMakerId())) {
							partsMbHistoryVOList.get(z).setMbas(partsMakerHistoryVOList.get(ma).getAsScore());
						}
					}
				}
				
				// MBAS 배열 데이터 작성
				BigDecimal[] mbFBigDecimalArray = new BigDecimal[401];

				for(int i = 0; i < mbFBigDecimalArray.length; i++){
					mbFBigDecimalArray[i] = BigDecimal.ZERO;
				}

				mbFBigDecimalArray[0] = new BigDecimal("1");
				mbFBigDecimalArray[55] = new BigDecimal("1750");
				mbFBigDecimalArray[70] = new BigDecimal("2375");
				mbFBigDecimalArray[85] = new BigDecimal("2400");
				mbFBigDecimalArray[100] = new BigDecimal("2425");
				mbFBigDecimalArray[110] = new BigDecimal("2750");
				mbFBigDecimalArray[140] = new BigDecimal("3500");
				mbFBigDecimalArray[170] = new BigDecimal("3750");
				mbFBigDecimalArray[200] = new BigDecimal("5000");
				mbFBigDecimalArray[400] = new BigDecimal("9500");

				int[] mbFValues = {1, 1750, 2375, 2400, 2425, 2750, 3500, 3750, 5000, 9500};
				int[] mdFIndexes = {0, 55, 70, 85, 100, 110, 140, 170, 200, 400};
				for (int j = 0; j < mdFIndexes.length - 1; j++) {
					int startIndex = mdFIndexes[j];
					int endIndex = mdFIndexes[j + 1];
					BigDecimal startValue = new BigDecimal(mbFValues[j]);
					BigDecimal endValue = j + 1 < mbFValues.length ? new BigDecimal(mbFValues[j + 1]) : BigDecimal.ZERO;
					BigDecimal increment = endValue.subtract(startValue).divide(new BigDecimal(endIndex - startIndex), 3, BigDecimal.ROUND_HALF_UP);

					for(int i = startIndex + 1; i < endIndex; i++){
						mbFBigDecimalArray[i] = startValue.add(increment.multiply(new BigDecimal(i - startIndex)));
					}
				}

				//PORT 배열 데이터 작성
				BigDecimal[] mbGBigDecimalArray = new BigDecimal[401];

				for(int i = 0; i < mbGBigDecimalArray.length; i++){
					mbGBigDecimalArray[i] = BigDecimal.ZERO;
				}

				mbGBigDecimalArray[0] = new BigDecimal("1");
				mbGBigDecimalArray[22] = new BigDecimal("770");
				mbGBigDecimalArray[25] = new BigDecimal("1085");
				mbGBigDecimalArray[29] = new BigDecimal("1190");
				mbGBigDecimalArray[35] = new BigDecimal("1225");
				mbGBigDecimalArray[39] = new BigDecimal("1260");
				mbGBigDecimalArray[40] = new BigDecimal("1330");
				mbGBigDecimalArray[41] = new BigDecimal("1575");
				mbGBigDecimalArray[44] = new BigDecimal("1610");
				mbGBigDecimalArray[50] = new BigDecimal("1645");
				mbGBigDecimalArray[52] = new BigDecimal("1820");
				mbGBigDecimalArray[58] = new BigDecimal("2030");
				mbGBigDecimalArray[69] = new BigDecimal("2380");
				mbGBigDecimalArray[70] = new BigDecimal("2450");
				mbGBigDecimalArray[71] = new BigDecimal("2485");
				mbGBigDecimalArray[78] = new BigDecimal("2730");
				mbGBigDecimalArray[80] = new BigDecimal("2800");
				mbGBigDecimalArray[82] = new BigDecimal("2870");
				mbGBigDecimalArray[100] = new BigDecimal("3500");
				mbGBigDecimalArray[104] = new BigDecimal("4830");
				mbGBigDecimalArray[138] = new BigDecimal("5775");
				mbGBigDecimalArray[142] = new BigDecimal("5810");
				mbGBigDecimalArray[400] = new BigDecimal("15820");

				int[] mbGValues = {1, 770, 1085, 1190, 1225, 1260, 1330, 1575, 1610, 1645, 1820, 2030, 2380, 2450, 2485, 2730, 2800, 2870, 3500, 4830, 5775, 5810, 15820};
				int[] mdGIndexes = {0, 22, 25, 29, 35, 39, 40, 41, 44, 50, 52, 58, 69, 70, 71, 78, 80, 82, 100, 104, 138, 142, 400};
				for (int j = 0; j < mdGIndexes.length - 1; j++) {
					int startIndex = mdGIndexes[j];
					int endIndex = mdGIndexes[j + 1];
					BigDecimal startValue = new BigDecimal(mbGValues[j]);
					BigDecimal endValue = j + 1 < mbGValues.length ? new BigDecimal(mbGValues[j + 1]) : BigDecimal.ZERO;
					BigDecimal increment = endValue.subtract(startValue).divide(new BigDecimal(endIndex - startIndex), 3, BigDecimal.ROUND_HALF_UP);

					for(int i = startIndex + 1; i < endIndex; i++){
						mbGBigDecimalArray[i] = startValue.add(increment.multiply(new BigDecimal(i - startIndex)));
					}
				}

				//BIOS 배열 데이터 작성
				
				BigDecimal[] mbHBigDecimalArray = new BigDecimal[401];

				for(int i = 0; i < mbHBigDecimalArray.length; i++){
					mbHBigDecimalArray[i] = BigDecimal.ZERO;
				}

				mbHBigDecimalArray[0] = new BigDecimal("1");
				mbHBigDecimalArray[25] = new BigDecimal("240");
				mbHBigDecimalArray[29] = new BigDecimal("552");
				mbHBigDecimalArray[33] = new BigDecimal("564");
				mbHBigDecimalArray[39] = new BigDecimal("576");
				mbHBigDecimalArray[40] = new BigDecimal("588");
				mbHBigDecimalArray[45] = new BigDecimal("600");
				mbHBigDecimalArray[50] = new BigDecimal("612");
				mbHBigDecimalArray[51] = new BigDecimal("624");
				mbHBigDecimalArray[52] = new BigDecimal("636");
				mbHBigDecimalArray[54] = new BigDecimal("648");
				mbHBigDecimalArray[58] = new BigDecimal("660");
				mbHBigDecimalArray[66] = new BigDecimal("672");
				mbHBigDecimalArray[69] = new BigDecimal("684");
				mbHBigDecimalArray[71] = new BigDecimal("696");
				mbHBigDecimalArray[78] = new BigDecimal("708");
				mbHBigDecimalArray[80] = new BigDecimal("720");
				mbHBigDecimalArray[90] = new BigDecimal("1080");
				mbHBigDecimalArray[102] = new BigDecimal("1224");
				mbHBigDecimalArray[104] = new BigDecimal("1236");
				mbHBigDecimalArray[108] = new BigDecimal("1260");
				mbHBigDecimalArray[138] = new BigDecimal("1656");
				mbHBigDecimalArray[142] = new BigDecimal("1668");
				mbHBigDecimalArray[400] = new BigDecimal("4692");

				int[] mbHValues = {1, 240, 552, 564, 576, 588, 600, 612, 624, 636, 648, 660, 672, 684, 696, 708, 720, 1080, 1224, 1236, 1260, 1656, 1668, 4692};
				int[] mdHIndexes = {0, 25, 29, 33, 39, 40, 45, 50, 51, 52, 54, 58, 66, 69, 71, 78, 80, 90, 102, 104, 108, 138, 142, 400};
				for (int j = 0; j < mdHIndexes.length - 1; j++) {
					int startIndex = mdHIndexes[j];
					int endIndex = mdHIndexes[j + 1];
					BigDecimal startValue = new BigDecimal(mbHValues[j]);
					BigDecimal endValue = j + 1 < mbHValues.length ? new BigDecimal(mbHValues[j + 1]) : BigDecimal.ZERO;
					BigDecimal increment = endValue.subtract(startValue).divide(new BigDecimal(endIndex - startIndex), 3, BigDecimal.ROUND_HALF_UP);

					for(int i = startIndex + 1; i < endIndex; i++){
						mbHBigDecimalArray[i] = startValue.add(increment.multiply(new BigDecimal(i - startIndex)));
					}
				}
				for(int mb = 0; mb < partsMbHistoryVOList.size(); mb++) {
					PartsMbHistoryVO partsMbHistoryVO = partsMbHistoryVOList.get(mb);
					BigDecimal mbValue = BigDecimal.ZERO;
					BigDecimal MBAS = new BigDecimal(partsMbHistoryVO.getMbas());
					BigDecimal PORT = new BigDecimal(partsMbHistoryVO.getPort());
					BigDecimal BIOS = new BigDecimal(partsMbHistoryVO.getBios());
					BigDecimal QC = new BigDecimal(partsMbHistoryVO.getQc());
					BigDecimal mbOne = CAS.add(CMT).add(CSFT).divide(BigDecimal.valueOf(3)).subtract(new BigDecimal("2.42195519383753")).pow(2).negate();
					BigDecimal mbTwo = new BigDecimal("28.1279551670743").pow(2);
					BigDecimal mbThree = mbOne.add(mbTwo);
					BigDecimal MVCV =  new BigDecimal(Math.sqrt(mbThree.doubleValue())).subtract(new BigDecimal("28.0234900560224")).divide(BigDecimal.valueOf(100)).setScale(8, BigDecimal.ROUND_HALF_UP);// 보정수치
					BigDecimal calculation1 = BigDecimal.ZERO;
					BigDecimal calculation2 = BigDecimal.ZERO;
					BigDecimal calculation3 = BigDecimal.ZERO;
					BigDecimal calculation4 = BigDecimal.ZERO;
					BigDecimal calculation5 = BigDecimal.ZERO;
					BigDecimal calculation6 = BigDecimal.ZERO;
					BigDecimal calculation7 = BigDecimal.ZERO;
					BigDecimal calculation8 = BigDecimal.ZERO;
					BigDecimal calculation9 = BigDecimal.ZERO;
					
					calculation1 = QC.multiply(CQC).multiply(new BigDecimal("0.1"));
					calculation2 = new BigDecimal("1").subtract(calculation1);
					calculation3 = MBAS.multiply(CAS).setScale(0, BigDecimal.ROUND_HALF_UP);
					if(0 == calculation3.compareTo(new BigDecimal("401"))) {
						calculation3 = new BigDecimal("400");
					}
					calculation4 = PORT.multiply(CMT).setScale(0, BigDecimal.ROUND_HALF_UP);
					if(0 == calculation4.compareTo(new BigDecimal("401"))) {
						calculation4 = new BigDecimal("400");
					}
					calculation5 = BIOS.multiply(CSFT).setScale(0, BigDecimal.ROUND_HALF_UP);
					if(0 == calculation5.compareTo(new BigDecimal("401"))) {
						calculation5 = new BigDecimal("400");
					}
					
					calculation6 
					= mbFBigDecimalArray[calculation3.intValue()]
							.multiply(mbGBigDecimalArray[calculation4.intValue()])
							.multiply(mbHBigDecimalArray[calculation5.intValue()]);
					calculation7 = new BigDecimal(Math.pow(calculation6.doubleValue(), 1.0 / 3.0)).multiply(MVCV).setScale(6, BigDecimal.ROUND_HALF_UP);
					calculation8 = new BigDecimal("1").add(calculation7);
					calculation9 = CC
							.multiply(new BigDecimal("0.6"))
							.multiply(calculation8)
							.multiply(calculation2);
					
					partsMbHistoryVO.setMbValue(calculation9);
				}
				
				
				
				/*--------------------------------------------------
				 - 21. VC=<Price인 MB제품을 모두 소거한다.
				*--------------------------------------------------*/
				for(int i = partsMbHistoryVOList.size()-1; i >= 0; i--) {
					BigDecimal mbPrice = new BigDecimal(partsMbHistoryVOList.get(i).getPartsPrice());
					int compareResult = VC.compareTo(mbPrice);
					if(compareResult < 0 || compareResult == 0) {
						partsMbHistoryVOList.remove(i);
					}
				}
				
				/*--------------------------------------------------
				 - 22. CPU SOC가 β번째 CPU의 수치와 다른 MB를 모두 소거한다.
				*--------------------------------------------------*/
				String cpuSocCd = partsCpuHistoryVOList.get(cpuIndex).getCpuSocCd();
				for(int i = partsMbHistoryVOList.size()-1; i >= 0; i--) {
					if(!partsMbHistoryVOList.get(i).getCpuSocCd().equals(cpuSocCd)) {
						partsMbHistoryVOList.remove(i);
					}
				}
				
				/*--------------------------------------------------
				 - 23. VRM Range가 β번째 CPU*(1+CSFT)>MB인 모든 MB제품을 소거한다.
				 - 여기서 CPU가 뭐임?
				 - 오기재.. CC라고 함.
				 - ㄴㄴ vrm range라고 함.
				*--------------------------------------------------*/
				BigDecimal cpu_vrmRange = partsCpuHistoryVOList.get(cpuIndex).getVrmRange();
				BigDecimal algorithm23TargetData = cpu_vrmRange.multiply(new BigDecimal("1").add(CSFT));
				for(int i = partsMbHistoryVOList.size()-1; i >= 0; i--) {
					BigDecimal mbVrmRange = partsMbHistoryVOList.get(i).getVrmRange();
					int compareResult = algorithm23TargetData.compareTo(mbVrmRange);
					if(compareResult > 0) {
						partsMbHistoryVOList.remove(i);
					}
				}
				
				/*--------------------------------------------------
				 - 23-1. LIM VRM이 β번째 CPU의 VRM Range보다 낮은 모든 제품을 소거한다.
				 - LIM VRM = MB
				 - 23.10.11 추가
				*--------------------------------------------------*/
				for(int i = partsMbHistoryVOList.size()-1; i >= 0; i--) {
					BigDecimal mbLimVrm = new BigDecimal(partsMbHistoryVOList.get(i).getLimVrm());
					int compareResult = cpu_vrmRange.compareTo(mbLimVrm);
					if(compareResult > 0) {
						partsMbHistoryVOList.remove(i);
					}
				}
				
				/*--------------------------------------------------
				 - 23-2. 선택된 CPU의 cl_soc ⊂ COOLER cl_soc가 아닌 모든 제품을 소거한다.
				 - cl_soc = 14자리수 2진법 (최소 4자리)
				 - 23.11.07 추가
				*--------------------------------------------------*/
				String cpuClSoc = String.format("%014d", Integer.parseInt(partsCpuHistoryVOList.get(cpuIndex).getClSoc()));
				int cpuClSoc1 = Integer.parseInt(cpuClSoc.substring(0, 1));
				int cpuClSoc2 = Integer.parseInt(cpuClSoc.substring(1, 2));
				int cpuClSoc3 = Integer.parseInt(cpuClSoc.substring(2, 3));
				int cpuClSoc4 = Integer.parseInt(cpuClSoc.substring(3, 4));
				int cpuClSoc5 = Integer.parseInt(cpuClSoc.substring(4, 5));
				int cpuClSoc6 = Integer.parseInt(cpuClSoc.substring(5, 6));
				int cpuClSoc7 = Integer.parseInt(cpuClSoc.substring(6, 7));
				int cpuClSoc8 = Integer.parseInt(cpuClSoc.substring(7, 8));
				int cpuClSoc9 = Integer.parseInt(cpuClSoc.substring(8, 9));
				int cpuClSoc10 = Integer.parseInt(cpuClSoc.substring(9, 10));
				int cpuClSoc11 = Integer.parseInt(cpuClSoc.substring(10, 11));
				int cpuClSoc12 = Integer.parseInt(cpuClSoc.substring(11, 12));
				int cpuClSoc13 = Integer.parseInt(cpuClSoc.substring(12, 13));
				int cpuClSoc14 = Integer.parseInt(cpuClSoc.substring(13, 14));
				
				for(int i = partsCoolerHistoryVOList.size()-1; i >= 0; i--) {
					String coolerClSoc = String.format("%014d", Integer.parseInt(partsCoolerHistoryVOList.get(i).getClSoc()));
					int coolerClSoc1 = Integer.parseInt(coolerClSoc.substring(0, 1));
					int coolerClSoc2 = Integer.parseInt(coolerClSoc.substring(1, 2));
					int coolerClSoc3 = Integer.parseInt(coolerClSoc.substring(2, 3));
					int coolerClSoc4 = Integer.parseInt(coolerClSoc.substring(3, 4));
					int coolerClSoc5 = Integer.parseInt(coolerClSoc.substring(4, 5));
					int coolerClSoc6 = Integer.parseInt(coolerClSoc.substring(5, 6));
					int coolerClSoc7 = Integer.parseInt(coolerClSoc.substring(6, 7));
					int coolerClSoc8 = Integer.parseInt(coolerClSoc.substring(7, 8));
					int coolerClSoc9 = Integer.parseInt(coolerClSoc.substring(8, 9));
					int coolerClSoc10 = Integer.parseInt(coolerClSoc.substring(9, 10));
					int coolerClSoc11 = Integer.parseInt(coolerClSoc.substring(10, 11));
					int coolerClSoc12 = Integer.parseInt(coolerClSoc.substring(11, 12));
					int coolerClSoc13 = Integer.parseInt(coolerClSoc.substring(12, 13));
					int coolerClSoc14 = Integer.parseInt(coolerClSoc.substring(13, 14));
					
					int subset = 0;

					//같은 자릿수에 대해서 쿨러의 인자가 같거나 더 커야함
					if(cpuClSoc1 <= coolerClSoc1) {
						subset = 1;
					}
					
					if(cpuClSoc2 <= coolerClSoc2) {
						subset = 1;
					}
					
					if(cpuClSoc3 <= coolerClSoc3) {
						subset = 1;
					}
					
					if(cpuClSoc4 <= coolerClSoc4) {
						subset = 1;
					}
					
					if(cpuClSoc4 <= coolerClSoc4) {
						subset = 1;
					}
					
					if(cpuClSoc5 <= coolerClSoc5) {
						subset = 1;
					}
					
					if(cpuClSoc6 <= coolerClSoc6) {
						subset = 1;
					}
					
					if(cpuClSoc7 <= coolerClSoc7) {
						subset = 1;
					}
					
					if(cpuClSoc8 <= coolerClSoc8) {
						subset = 1;
					}
					
					if(cpuClSoc9 <= coolerClSoc9) {
						subset = 1;
					}
					
					if(cpuClSoc10 <= coolerClSoc10) {
						subset = 1;
					}
					
					if(cpuClSoc11 <= coolerClSoc11) {
						subset = 1;
					}
					
					if(cpuClSoc12 <= coolerClSoc12) {
						subset = 1;
					}
					
					if(cpuClSoc13 <= coolerClSoc13) {
						subset = 1;
					}
					
					if(cpuClSoc14 <= coolerClSoc14) {
						subset = 1;
					}
					
					if(subset == 0) {
						partsCoolerHistoryVOList.remove(i);
					}
				}
				
				/*--------------------------------------------------
				 - 20. MB테이블에서 Value가 더 낮음과 동시에 Price가 더 높은
				 - (완벽한 하위 호환에 있는)제품이 있는 경우 하위 호환 제품을 소거한다.  
				*--------------------------------------------------*/
				for(int i = partsMbHistoryVOList.size()-1; i >= 1; i--) {
					int targetIndex = i-1;
					
					BigDecimal value1 = partsMbHistoryVOList.get(targetIndex).getMbValue();
					BigDecimal value2 = partsMbHistoryVOList.get(targetIndex+1).getMbValue();
					
					int compareResult1 = value1.compareTo(value2);
					
					if(compareResult1 < 0) {
						// value1 < value2
						continue;
					}
					
					// 중첩 반복(대상 인덱스로부터 위로 검증)
					int zTargetSize = partsMbHistoryVOList.size();
					for(int z = targetIndex+1; z < zTargetSize; z++) {
						if(z == zTargetSize) {
							break;
						}
						BigDecimal value3 = partsMbHistoryVOList.get(z).getMbValue();
						
						int compareResult2 = value1.compareTo(value3);
						if(compareResult2 > 0 || compareResult2 == 0) {
							// value1 > value3 or value1 == value3
							partsMbHistoryVOList.remove(z);
							--zTargetSize;
							--z;
						}
					}
				}
				
				/*--------------------------------------------------
				 - 24. 남은 MB제품의 개수를 limγ라 한다.
				 - limγ<γ라면 아래 변수 정렬 후 18번으로 돌아간다.
				 - (소거된 제품도 18번 시점으로 롤백한다.)
				 - VC=VC+β번째 CPU의 Price
				 - β=β+1, γ=1, k=1, p=1, q=1, x=1, y=1
				 - limγ>=γ라면 연산을 이어나간다.
				 - VC=VC-γ번째 MB의 Price이다.
				*--------------------------------------------------*/
				// 24번 시점에서 백업데이터. 추후 구현할 27번에서 롤백 할 백업데이터로 쓰인다.
				List<PartsCoolerHistoryVO> partsCoolerHistoryVOListAlgorithm24Backup = new ArrayList<>();
				List<PartsCaseHistoryVO> partsCaseHistoryVOListAlgorithm24Backup = new ArrayList<>();
				List<PartsPsuHistoryVO> partsPsuHistoryVOListAlgorithm24Backup = new ArrayList<>();
				List<PartsRamHistoryVO> partsRamHistoryVOListAlgorithm24Backup = new ArrayList<>();
				List<PartsSsdHistoryVO> partsSsdHistoryVOListAlgorithm24Backup = new ArrayList<>();
				BigDecimal VC24Backup = VC;
				
				for(int i = 0; i < partsCoolerHistoryVOList.size(); i++) {
					partsCoolerHistoryVOListAlgorithm24Backup.add(partsCoolerHistoryVOList.get(i));
				}
				
				for(int i = 0; i < partsCaseHistoryVOList.size(); i++) {
					partsCaseHistoryVOListAlgorithm24Backup.add(partsCaseHistoryVOList.get(i));
				}
				
				for(int i = 0; i < partsPsuHistoryVOList.size(); i++) {
					partsPsuHistoryVOListAlgorithm24Backup.add(partsPsuHistoryVOList.get(i));
				}
				
				for(int i = 0; i < partsRamHistoryVOList.size(); i++) {
					partsRamHistoryVOListAlgorithm24Backup.add(partsRamHistoryVOList.get(i));
				}
				
				addListBySsd(partsSsdHistoryVOListAlgorithm24Backup, partsSsdHistoryVOList);
				
				int limγ = partsMbHistoryVOList.size();
				
				if(limγ <= γ) {
					// limγ<γ라면 아래 변수 정렬 후 18번으로 돌아간다. -> limγ<=γ
					
//					VC = VC.add(new BigDecimal(partsCpuHistoryVOList.get(cpuIndex).getPartsPrice()));
					γ = 0;
					k = 0;
					p = 0;
					q = 0;
					x = 0;
					y = 0;
					
					continue; // 18번 처음 for 다음 cpu Index 진행
				}
				
				// limγ>=γ라면 연산을 이어간다. -> limγ>γ
				for(int mbIndex = γ; mbIndex < limγ; mbIndex++) {
					// test 23.08.31
//					if(gpuIndex == 0 && cpuIndex == 0 && mbIndex == 2) {
//						System.out.println("################# SYSO 결과출력 START #########################");
//					}
					
					// test 23.09.15
//					if(partsGpuHistoryVOList.get(gpuIndex).getId().equals("GPU000169")
//							&& partsCpuHistoryVOList.get(cpuIndex).getId().equals("CPU000002")
//							&& partsMbHistoryVOList.get(mbIndex).getId().equals("MB000002")
////							&& partsCoolerHistoryVOList.get(coolerIndex).getId().equals("COOLER000005")
//							) {
//						System.out.println("################# 드러오냐 #########################");
//					}
					
					/*--------------------------------------------------
					 - 24-1. 24번백업데이터 기준으로 데이터복원처리
					*--------------------------------------------------*/
					partsCoolerHistoryVOList = new ArrayList<>();
					partsCaseHistoryVOList = new ArrayList<>();
					partsPsuHistoryVOList = new ArrayList<>();
					partsRamHistoryVOList = new ArrayList<>();
					partsSsdHistoryVOList = new ArrayList<>();
					VC = VC24Backup;
					
					for(int i = 0; i < partsCoolerHistoryVOListAlgorithm24Backup.size(); i++) {
						partsCoolerHistoryVOList.add(partsCoolerHistoryVOListAlgorithm24Backup.get(i));
					}
					
					for(int i = 0; i < partsCaseHistoryVOListAlgorithm24Backup.size(); i++) {
						partsCaseHistoryVOList.add(partsCaseHistoryVOListAlgorithm24Backup.get(i));
					}
					
					for(int i = 0; i < partsPsuHistoryVOListAlgorithm24Backup.size(); i++) {
						partsPsuHistoryVOList.add(partsPsuHistoryVOListAlgorithm24Backup.get(i));
					}
					
					for(int i = 0; i < partsRamHistoryVOListAlgorithm24Backup.size(); i++) {
						partsRamHistoryVOList.add(partsRamHistoryVOListAlgorithm24Backup.get(i));
					}
					
					addListBySsd(partsSsdHistoryVOList, partsSsdHistoryVOListAlgorithm24Backup);
					
					/*--------------------------------------------------
					 - 24-2. 현재 진행 mb Index의 가격 빼기
					*--------------------------------------------------*/
					VC = VC.subtract(new BigDecimal(partsMbHistoryVOList.get(mbIndex).getPartsPrice()));
					
					/*--------------------------------------------------
					 - 25. VC=<Price인 모든 Cooler 제품을 소거한다.
					*--------------------------------------------------*/
					for(int i = partsCoolerHistoryVOList.size()-1; i >= 0; i--) {
						BigDecimal coolerPrice = new BigDecimal(partsCoolerHistoryVOList.get(i).getPartsPrice());
						int compareResult = VC.compareTo(coolerPrice);
						if(compareResult < 0 || compareResult == 0) {
							partsCoolerHistoryVOList.remove(i);
						}
					}
					
					
					
					/*--------------------------------------------------
					 - 27. 남은 Cooler제품의 개수를 limk이라 한다.
					 - limk<k라면 아래 변수정렬 후 24번으로 돌아간다.(소거 시점도 24번으로 롤백한다.)
					 - VC=VC+γ번째 MB의 Price
					 - γ=γ+1, k=1, p=1, q=1, x=1, y=1
					 - limk>=k라면 연산을 이어나간다.
					 - VC=VC-k번째 Cooler의 Price이다.
					*--------------------------------------------------*/
					// 27번 시점에서 백업데이터. 추후 구현할 33번에서 롤백 할 백업데이터로 쓰인다.
					List<PartsCaseHistoryVO> partsCaseHistoryVOListAlgorithm27Backup = new ArrayList<>();
					List<PartsPsuHistoryVO> partsPsuHistoryVOListAlgorithm27Backup = new ArrayList<>();
					List<PartsRamHistoryVO> partsRamHistoryVOListAlgorithm27Backup = new ArrayList<>();
					List<PartsSsdHistoryVO> partsSsdHistoryVOListAlgorithm27Backup = new ArrayList<>();
					BigDecimal VC27Backup = VC;
					
					for(int i = 0; i < partsCaseHistoryVOList.size(); i++) {
						partsCaseHistoryVOListAlgorithm27Backup.add(partsCaseHistoryVOList.get(i));
					}
					
					for(int i = 0; i < partsPsuHistoryVOList.size(); i++) {
						partsPsuHistoryVOListAlgorithm27Backup.add(partsPsuHistoryVOList.get(i));
					}
					
					for(int i = 0; i < partsRamHistoryVOList.size(); i++) {
						partsRamHistoryVOListAlgorithm27Backup.add(partsRamHistoryVOList.get(i));
					}
					
					addListBySsd(partsSsdHistoryVOListAlgorithm27Backup, partsSsdHistoryVOList);
					
					int limk = partsCoolerHistoryVOList.size();
					
					if(limk <= k) {
						// limk<k라면 아래 변수 정렬 후 24번으로 돌아간다. -> limk<=k
						
//						VC = VC.add(new BigDecimal(partsMbHistoryVOList.get(mbIndex).getPartsPrice()));
						k = 0;
						p = 0;
						q = 0;
						x = 0;
						y = 0;
						
						continue; // 24번 처음 for 다음 mbIndex 진행
					}
					
					// limk>=k라면 연산을 이어간다. -> limk>k
					for(int coolerIndex = k; coolerIndex < limk; coolerIndex++) {
						/*--------------------------------------------------
						 - 27-1. 27번백업데이터 기준으로 데이터복원처리
						*--------------------------------------------------*/
						partsCaseHistoryVOList = new ArrayList<>();
						partsPsuHistoryVOList = new ArrayList<>();
						partsRamHistoryVOList = new ArrayList<>();
						partsSsdHistoryVOList = new ArrayList<>();
						VC = VC27Backup;

						for(int i = 0; i < partsCaseHistoryVOListAlgorithm27Backup.size(); i++) {
							partsCaseHistoryVOList.add(partsCaseHistoryVOListAlgorithm27Backup.get(i));
						}
						
						for(int i = 0; i < partsPsuHistoryVOListAlgorithm27Backup.size(); i++) {
							partsPsuHistoryVOList.add(partsPsuHistoryVOListAlgorithm27Backup.get(i));
						}
						
						for(int i = 0; i < partsRamHistoryVOListAlgorithm27Backup.size(); i++) {
							partsRamHistoryVOList.add(partsRamHistoryVOListAlgorithm27Backup.get(i));
						}
						
						addListBySsd(partsSsdHistoryVOList, partsSsdHistoryVOListAlgorithm27Backup);
						
						/*--------------------------------------------------
						 - 27-2. 현재 진행 cooler Index의 가격 빼기
						*--------------------------------------------------*/
						VC = VC.subtract(new BigDecimal(partsCoolerHistoryVOList.get(coolerIndex).getPartsPrice()));
						
						/*--------------------------------------------------
						 - 28. VC=<Price인 모든 CASE제품을 소거한다.
						*--------------------------------------------------*/
						for(int i = partsCaseHistoryVOList.size()-1; i >= 0; i--) {
							BigDecimal casePrice = new BigDecimal(partsCaseHistoryVOList.get(i).getPartsPrice());
							int compareResult = VC.compareTo(casePrice);
							if(compareResult < 0 || compareResult == 0) {
								partsCaseHistoryVOList.remove(i);
							}
						}
						
						/*--------------------------------------------------
						 - 29. α번째 GPU의 IL>=CASE인 모든 CASE제품을 소거한다.
						*--------------------------------------------------*/
						BigDecimal gpuIL = new BigDecimal(partsGpuHistoryVOList.get(gpuIndex).getIl());
						for(int i = partsCaseHistoryVOList.size()-1; i >= 0; i--) {
							BigDecimal caseIl = new BigDecimal(partsCaseHistoryVOList.get(i).getIl());
							int compareResult = gpuIL.compareTo(caseIl);
							if(compareResult > 0 || compareResult == 0) {
								partsCaseHistoryVOList.remove(i);
							}
						}
						
						/*--------------------------------------------------
						 - 30. γ번째 MB의 FF⊂CASE가 아닌 모든 제품을 소거한다.
						 - 23.08.03 추가정보 30번 : 4자리수 2진법 (FF)
						*--------------------------------------------------*/
//						[H] [오후 4:56] 진법표현한거 부분집합에 속하는지 처리할 때 십진법 변환 뒤 비교연산자 적용으로 처리하는지? 아니면 대상 자리에 같은 값이 없으면 부분집합에 속하지 않는다고 보는지?
//						[H] [오후 4:56] 1번예시 A : 0010(십진4), B : 0100(십진6)
//						[H] [오후 4:56] B⊂A 성립
//						[H] [오후 4:57] 2번일 때는 성립하지 않음
//						[이해창] [오후 4:57] 성립하지 않습니다. also 2진법은 같은 값이지만
//						[이해창] [오후 4:57] 3진법 이상에선 같거나 상위값이면 포함관계입니다
//						[이해창] [오후 4:57] 0100은 0200에 포함됩니다.
//						[이해창] [오후 4:57] 0010은 0200에 포함되지 않습니다
//						[H] [오후 4:58] 2번예시로 봐야겠네
//						[H] [오후 4:58] 십진법 변환할 필요 없구만
//						[이해창] [오후 4:58] 넹 맞습니다
//						[H] [오후 4:58] 같은 자리값에 대해서 더 큰 수인지 비교하면 되겠노
//						[H] [오후 4:58] ㅇㅋㅇㅋ
//						[이해창] [오후 4:58] 네넹 감삼다
						
						String mbFF = String.format("%04d", partsMbHistoryVOList.get(mbIndex).getFf());
						int mbFF1 = Integer.parseInt(mbFF.substring(0, 1));
						int mbFF2 = Integer.parseInt(mbFF.substring(1, 2));
						int mbFF3 = Integer.parseInt(mbFF.substring(2, 3));
						int mbFF4 = Integer.parseInt(mbFF.substring(3, 4));
						
						for(int i = partsCaseHistoryVOList.size()-1; i >= 0; i--) {
							String caseFF = String.format("%04d", partsCaseHistoryVOList.get(i).getFf());
							int caseFF1 = Integer.parseInt(caseFF.substring(0, 1));
							int caseFF2 = Integer.parseInt(caseFF.substring(1, 2));
							int caseFF3 = Integer.parseInt(caseFF.substring(2, 3));
							int caseFF4 = Integer.parseInt(caseFF.substring(3, 4));
							int subset = 0;
							

							//같은 자릿수에 대해서 케이스의 인자가 같거나 더 커야함
							if(mbFF1 <= caseFF1) {
								subset = 1;
							}
							
							if(mbFF2 <= caseFF2) {
								subset = 1;
							}
							
							if(mbFF3 <= caseFF3) {
								subset = 1;
							}
							
							if(mbFF4 <= caseFF4) {
								subset = 1;
							}
							
							//MB는 CASE의 부분집합 이 아니면 제외
							if(subset == 0) {
								partsCaseHistoryVOList.remove(i);
							}
						}
						
						/*--------------------------------------------------
						 - 31. k번째 Cooler의 IW>=CASE인 모든 제품을 소거한다.
						*--------------------------------------------------*/
						BigDecimal coolerIW = new BigDecimal(partsCoolerHistoryVOList.get(coolerIndex).getIw());
						for(int i = partsCaseHistoryVOList.size()-1; i >= 0; i--) {
							BigDecimal caseIW = new BigDecimal(partsCaseHistoryVOList.get(i).getIw());
							int compareResult = coolerIW.compareTo(caseIW);
							if(compareResult > 0 || compareResult == 0) {
								partsCaseHistoryVOList.remove(i);
							}
						}
						
						/*--------------------------------------------------
						 - 32. k번째 Cooler의 IH⊂CASE 혹은 IT⊂CASE 둘 중 하나 
						 - 이상을 만족하는 CASE를 제외한 모든 CASE제품을 소거한다.
						 - 23.08.03 추가정보 32번 : 2자리수 4진법 (IH, IT)
						 - 23.12.17 수냉일 때만 소거법 적용
						*--------------------------------------------------*/
						
						if ("02".equals(partsCoolerHistoryVOList.get(coolerIndex).getFormulaCd())){
							String coolerIH = String.format("%02d", partsCoolerHistoryVOList.get(coolerIndex).getIh());
							String coolerIT = String.format("%02d", partsCoolerHistoryVOList.get(coolerIndex).getIt());
							int coolerIH1 = Integer.parseInt(coolerIH.substring(0, 1));
							int coolerIH2 = Integer.parseInt(coolerIH.substring(1, 2));
							int coolerIT1 = Integer.parseInt(coolerIT.substring(0, 1));
							int coolerIT2 = Integer.parseInt(coolerIT.substring(1, 2));
							
							for(int i = partsCaseHistoryVOList.size()-1; i >= 0; i--) {
								
								String caseIH = String.format("%02d", partsCaseHistoryVOList.get(i).getIh());
								String caseIT = String.format("%02d", partsCaseHistoryVOList.get(i).getIt());
								int caseIH1 = Integer.parseInt(caseIH.substring(0, 1));
								int caseIH2 = Integer.parseInt(caseIH.substring(1, 2));
								int caseIT1 = Integer.parseInt(caseIT.substring(0, 1));
								int caseIT2 = Integer.parseInt(caseIT.substring(1, 2));
								int subset = 0;
								
								// 23.12.17 쿨러의 인자가 0일 때 소거법 적용 제외 
								if(coolerIH1 != 0) {
									if(coolerIH1 <= caseIH1) {
										subset = 1;
									}
								}
								
								if(coolerIH2 != 0) {
									if(coolerIH2 <= caseIH2) {
										subset = 1;
									}
								}
								
								
								if(coolerIT1 != 0) {
									if(coolerIT1 <= caseIT1) {
										subset = 1;
									}
								}
								
								if(coolerIT2 != 0) {
									if(coolerIT2 <= caseIT2) {
										subset = 1;
									}
								}
								
								if(subset == 0) {
									partsCaseHistoryVOList.remove(i);
								}
							}
						}
						
						
						// 23.12.17 소거 조건추가
						
						if(zeroCaseCheck.compareTo(customCaseCheck) == 0
								|| zeroCaseCheck.compareTo(customCaseCheck) < 0) {
							
							for(int i = partsCaseHistoryVOList.size()-1; i >= 1; i--) {
								int targetIndex = i-1;
								
								BigDecimal value1 = partsCaseHistoryVOList.get(targetIndex).getCaseValue();
								BigDecimal value2 = partsCaseHistoryVOList.get(targetIndex+1).getCaseValue();
								
								int compareResult1 = value1.compareTo(value2);
								
								if(compareResult1 < 0) {
									// value1 < value2
									continue;
								}
								
								// 중첩 반복(대상 인덱스로부터 위로 검증)
								int zTargetSize = partsCaseHistoryVOList.size();
								for(int z = targetIndex+1; z < zTargetSize; z++) {
									if(z == zTargetSize) {
										break;
									}
									BigDecimal value3 = partsCaseHistoryVOList.get(z).getCaseValue();
									
									int compareResult2 = value1.compareTo(value3);
									if(compareResult2 > 0 || compareResult2 == 0) {
										// value1 > value3 or value1 == value3
										partsCaseHistoryVOList.remove(z);
										--zTargetSize;
										--z;
									}
								}
							}
							
						}
						
						
						
						
						/*--------------------------------------------------
						 - 33. 남은 CASE제품의 개수를 limp 라고 한다.
						 - Limp<p라면 아래 변수정렬 후 27번으로 돌아간다.(소거 시점도 27번으로 롤백한다.)
						 - VC=VC+k번째 Cooler의 Price
						 - k=k+1, p=1, q=1, x=1, y=1
						 - limp>=p라면 연산을 이어나간다.
						 - VC=VC-p번째 CASE의 Price이다.
						*--------------------------------------------------*/
						// 33번 시점에서 백업데이터. 추후 구현할 39번에서 롤백 할 백업데이터로 쓰인다.
						List<PartsPsuHistoryVO> partsPsuHistoryVOListAlgorithm33Backup = new ArrayList<>();
						List<PartsRamHistoryVO> partsRamHistoryVOListAlgorithm33Backup = new ArrayList<>();
						List<PartsSsdHistoryVO> partsSsdHistoryVOListAlgorithm33Backup = new ArrayList<>();
						BigDecimal VC33Backup = VC;
						
						for(int i = 0; i < partsPsuHistoryVOList.size(); i++) {
							partsPsuHistoryVOListAlgorithm33Backup.add(partsPsuHistoryVOList.get(i));
						}
						
						for(int i = 0; i < partsRamHistoryVOList.size(); i++) {
							partsRamHistoryVOListAlgorithm33Backup.add(partsRamHistoryVOList.get(i));
						}
						
						addListBySsd(partsSsdHistoryVOListAlgorithm33Backup, partsSsdHistoryVOList);
						
						int limp = partsCaseHistoryVOList.size();
						
						if(limp <= p) {
							// limp<p라면 아래 변수 정렬 후 27번으로 돌아간다. -> limp<=p
							
//							VC = VC.add(new BigDecimal(partsCoolerHistoryVOList.get(coolerIndex).getPartsPrice()));
							p = 0;
							q = 0;
							x = 0;
							y = 0;
							
							continue; // 27번 처음 for 다음 coolerIndex 진행
						}
						
						// limp>=p라면 연산을 이어간다. -> limp>p
						for(int caseIndex = p; caseIndex < limp; caseIndex++) {
							/*--------------------------------------------------
							 - 33-1. 33번백업데이터 기준으로 데이터복원처리
							*--------------------------------------------------*/
							partsPsuHistoryVOList = new ArrayList<>();
							partsRamHistoryVOList = new ArrayList<>();
							partsSsdHistoryVOList = new ArrayList<>();
							VC = VC33Backup;

							for(int i = 0; i < partsPsuHistoryVOListAlgorithm33Backup.size(); i++) {
								partsPsuHistoryVOList.add(partsPsuHistoryVOListAlgorithm33Backup.get(i));
							}
							
							for(int i = 0; i < partsRamHistoryVOListAlgorithm33Backup.size(); i++) {
								partsRamHistoryVOList.add(partsRamHistoryVOListAlgorithm33Backup.get(i));
							}
							
							addListBySsd(partsSsdHistoryVOList, partsSsdHistoryVOListAlgorithm33Backup);
							
							/*--------------------------------------------------
							 - 33-2. 현재 진행 caseIndex의 가격 빼기
							*--------------------------------------------------*/
							VC = VC.subtract(new BigDecimal(partsCaseHistoryVOList.get(caseIndex).getPartsPrice()));
							
							/*--------------------------------------------------
							 - 34. VC=<Price인 모든 PSU제품을 소거한다.
							*--------------------------------------------------*/
							for(int i = partsPsuHistoryVOList.size()-1; i >= 0; i--) {
								BigDecimal psuPrice = new BigDecimal(partsPsuHistoryVOList.get(i).getPartsPrice());
								int compareResult = VC.compareTo(psuPrice);
								if(compareResult < 0 || compareResult == 0) {
									partsPsuHistoryVOList.remove(i);
								}
							}
							
							/*--------------------------------------------------
							 - 35. α번째 GPU의 TDP>PSU인 모든 PSU제품을 소거한다.
							*--------------------------------------------------*/
							BigDecimal gpuTDP = new BigDecimal(partsGpuHistoryVOList.get(gpuIndex).getTdp());
							for(int i = partsPsuHistoryVOList.size()-1; i >= 0; i--) {
								BigDecimal psuTDP = new BigDecimal(partsPsuHistoryVOList.get(i).getTdp());
								int compareResult = gpuTDP.compareTo(psuTDP);
								if(compareResult > 0) {
									partsPsuHistoryVOList.remove(i);
								}
							}
							
							/*--------------------------------------------------
							 - 36. α번째 GPU의 GPL⊂PSU인 제품을 제외한 모든 PSU제품을 소거한다.
							 - 23.08.03 추가정보 36번 : 4자릿수 3진법 (GPL)
							*--------------------------------------------------*/
							String gpuGPL = String.format("%04d", partsGpuHistoryVOList.get(gpuIndex).getGpl());
							int gpuGPL1 = Integer.parseInt(gpuGPL.substring(0, 1));
							int gpuGPL2 = Integer.parseInt(gpuGPL.substring(1, 2));
							int gpuGPL3 = Integer.parseInt(gpuGPL.substring(2, 3));
							int gpuGPL4 = Integer.parseInt(gpuGPL.substring(3, 4));
							
							for(int i = partsPsuHistoryVOList.size()-1; i >= 0; i--) {
								String psuGPL = String.format("%04d", partsPsuHistoryVOList.get(i).getGpl());
								int psuGPL1 = Integer.parseInt(psuGPL.substring(0, 1));
								int psuGPL2 = Integer.parseInt(psuGPL.substring(1, 2));
								int psuGPL3 = Integer.parseInt(psuGPL.substring(2, 3));
								int psuGPL4 = Integer.parseInt(psuGPL.substring(3, 4));
								int subset = 0;
								
								if(gpuGPL1 <= psuGPL1) {
									subset = 1;
								}
								
								if(gpuGPL2 <= psuGPL2) {
									subset = 1;
								}
								
								if(gpuGPL3 <= psuGPL3) {
									subset = 1;
								}
								
								if(gpuGPL4 <= psuGPL4) {
									subset = 1;
								}
								
								if(subset == 0) {
									partsPsuHistoryVOList.remove(i);
								}
							}
							
							/*--------------------------------------------------
							 - 37. α번째 GPU의 12PIN⊂PSU인 제품을 제외한 모든 PSU제품을 소거한다.
							 - 23.08.03 정정 요청 
							 - 37번에서 GPU의 12PIN>PSU인 모든 PSU제품을 소거한다(PSU의 12PIN수가 같거나 더 많아야 함)
							*--------------------------------------------------*/
							int gpu12PIN = partsGpuHistoryVOList.get(gpuIndex).getTwelvePin();
							
							for(int i = partsPsuHistoryVOList.size()-1; i >= 0; i--) {
								int psu12PIN = partsPsuHistoryVOList.get(i).getTwelvePin();
								if(gpu12PIN > psu12PIN) {
									partsPsuHistoryVOList.remove(i);
								}
							}
							
							/*--------------------------------------------------
							 - 38. γ번째 MB의 PL⊂PSU인 제품을 제외한 모든 PSU제품을 소거한다.
							 - 23.08.03 추가정보 38번 : 3자리수 3진법 (PL)
							*--------------------------------------------------*/
							String mbPL = String.format("%03d", partsMbHistoryVOList.get(mbIndex).getPl());
							int mbPL1 = Integer.parseInt(mbPL.substring(0, 1));
							int mbPL2 = Integer.parseInt(mbPL.substring(1, 2));
							int mbPL3 = Integer.parseInt(mbPL.substring(2, 3));
							
							for(int i = partsPsuHistoryVOList.size()-1; i >= 0; i--) {
								String psuPL = String.format("%03d", partsPsuHistoryVOList.get(i).getPl());
								int psuPL1 = Integer.parseInt(psuPL.substring(0, 1));
								int psuPL2 = Integer.parseInt(psuPL.substring(1, 2));
								int psuPL3 = Integer.parseInt(psuPL.substring(2, 3));
								int subset = 0;
								
								if(mbPL1 <= psuPL1) {
									subset = 1;
								}
								
								if(mbPL2 <= psuPL2) {
									subset = 1;
								}
								
								if(mbPL3 <= psuPL3) {
									subset = 1;
								}
								
								if(subset == 0) {
									partsPsuHistoryVOList.remove(i);
								}
							}
						
							
							if(zeroPsuCheck.compareTo(customPsuCheck) == 0
									|| zeroPsuCheck.compareTo(customPsuCheck) < 0) {
								
								
								for(int i = partsPsuHistoryVOList.size()-1; i >= 1; i--) {
									int targetIndex = i-1;
									
									BigDecimal value1 = partsPsuHistoryVOList.get(targetIndex).getPsuValue();
									BigDecimal value2 = partsPsuHistoryVOList.get(targetIndex+1).getPsuValue();
									
									int compareResult1 = value1.compareTo(value2);
									
									if(compareResult1 < 0) {
										// value1 < value2
										continue;
									}
									
									// 중첩 반복(대상 인덱스로부터 위로 검증)
									int zTargetSize = partsPsuHistoryVOList.size();
									for(int z = targetIndex+1; z < zTargetSize; z++) {
										if(z == zTargetSize) {
											break;
										}
										BigDecimal value3 = partsPsuHistoryVOList.get(z).getPsuValue();
										
										int compareResult2 = value1.compareTo(value3);
										if(compareResult2 > 0 || compareResult2 == 0) {
											// value1 > value3 or value1 == value3
											partsPsuHistoryVOList.remove(z);
											--zTargetSize;
											--z;
										}
									}
								}
							}
							
							
							/*--------------------------------------------------
							 - 39. 남은 PSU제품의 개수를 limq라고 한다.
							 - Limq<q라면 아래 변수정렬 후 33번으로 돌아간다.(소거 시점도 33번으로 롤백한다.)
							 - VC=VC+p번째 CASE의 Price
							 - p=p+1, q=1, x=1, y=1
							 - limq>=q라면 연산을 이어나간다.
							 - VC=VC-q번째 PSU의 Price이다.
							*--------------------------------------------------*/
							// 39번 시점에서 백업데이터. 추후 구현할 42번에서 롤백 할 백업데이터로 쓰인다.
							List<PartsRamHistoryVO> partsRamHistoryVOListAlgorithm39Backup = new ArrayList<>();
							List<PartsSsdHistoryVO> partsSsdHistoryVOListAlgorithm39Backup = new ArrayList<>();
							BigDecimal VC39Backup = VC;
							
							for(int i = 0; i < partsRamHistoryVOList.size(); i++) {
								partsRamHistoryVOListAlgorithm39Backup.add(partsRamHistoryVOList.get(i));
							}
							
							addListBySsd(partsSsdHistoryVOListAlgorithm39Backup, partsSsdHistoryVOList);
							
							int limq = partsPsuHistoryVOList.size();
							
							if(limq <= q) {
								// limq<q라면 아래 변수 정렬 후 33번으로 돌아간다. -> limq<=q
								
//								VC = VC.add(new BigDecimal(partsCaseHistoryVOList.get(caseIndex).getPartsPrice()));
								q = 0;
								x = 0;
								y = 0;
								
								continue; // 33번 처음 for 다음 caseIndex 진행
							}
							
							// limq>=q라면 연산을 이어간다. -> limq>q
							for(int psuIndex = q; psuIndex < limq; psuIndex++) {
								/*--------------------------------------------------
								 - 39-1. 39번백업데이터 기준으로 데이터복원처리
								*--------------------------------------------------*/
								partsRamHistoryVOList = new ArrayList<>();
								partsSsdHistoryVOList = new ArrayList<>();
								VC = VC39Backup;

								for(int i = 0; i < partsRamHistoryVOListAlgorithm39Backup.size(); i++) {
									partsRamHistoryVOList.add(partsRamHistoryVOListAlgorithm39Backup.get(i));
								}
								
								addListBySsd(partsSsdHistoryVOList, partsSsdHistoryVOListAlgorithm39Backup);
								
								/*--------------------------------------------------
								 - 39-2. 현재 진행 psuIndex의 가격 빼기
								*--------------------------------------------------*/
								VC = VC.subtract(new BigDecimal(partsPsuHistoryVOList.get(psuIndex).getPartsPrice()));
								
								/*--------------------------------------------------
								 - 40. VC=<Price인 모든 RAM제품을 소거한다.
								*--------------------------------------------------*/
								for(int i = partsRamHistoryVOList.size()-1; i >= 0; i--) {
									BigDecimal ramPrice = new BigDecimal(partsRamHistoryVOList.get(i).getPartsPrice());
									int compareResult = VC.compareTo(ramPrice);
									if(compareResult < 0 || compareResult == 0) {
										partsRamHistoryVOList.remove(i);
									}
								}
								
								/*--------------------------------------------------
								 - 41. γ번째 MB의 MEM SOC≠RAM인 모든 RAM제품을 소거한다.
								*--------------------------------------------------*/
								for(int i = partsRamHistoryVOList.size()-1; i >= 0; i--) {
									if(!partsMbHistoryVOList.get(mbIndex).getMemSocCd().equals(partsRamHistoryVOList.get(i).getMemSocCd())) {
										partsRamHistoryVOList.remove(i);
									}
								}
								
								
								/*--------------------------------------------------
								 - 42. 남은 RAM제품의 개수를 limx라고 한다.
								 - Limx<x라면 아래 변수정렬 후 39번으로 돌아간다.(소거 시점도 39번으로 롤백한다.)
								 - VC=VC+q번째 PSU의 Price
								 - q=q+1, x=1, y=1
								 - limx>=x라면 연산을 이어나간다.
								 - VC=VC-x번째 RAM의 Price이다.
								*--------------------------------------------------*/
								// 42번 시점에서 백업데이터. 추후 구현할 45번에서 롤백 할 백업데이터로 쓰인다.
								List<PartsSsdHistoryVO> partsSsdHistoryVOListAlgorithm42Backup = new ArrayList<>();
								BigDecimal VC42Backup = VC;
								
								addListBySsd(partsSsdHistoryVOListAlgorithm42Backup, partsSsdHistoryVOList);
								
								int limx = partsRamHistoryVOList.size();
								
								if(limx <= x) {
									// limx<x라면 아래 변수 정렬 후 39번으로 돌아간다. -> limx<=x
									
//									VC = VC.add(new BigDecimal(partsPsuHistoryVOList.get(psuIndex).getPartsPrice()));
									x = 0;
									y = 0;
									
									continue; // 39번 처음 for 다음 psuIndex 진행
								}
								
								// limx>=x라면 연산을 이어간다. -> limx>x
								for(int ramIndex = x; ramIndex < limx; ramIndex++) {
									/*--------------------------------------------------
									 - 42-1. 42번백업데이터 기준으로 데이터복원처리
									*--------------------------------------------------*/
									partsSsdHistoryVOList = new ArrayList<>();
									VC = VC42Backup;
									
									addListBySsd(partsSsdHistoryVOList, partsSsdHistoryVOListAlgorithm42Backup);
									
									// test 23.08.31
//									if(mbIndex == 0) {
//										System.out.println("################# SYSO 결과출력 START #########################");
//									}
//									if(mbIndex == 1) {
//										System.out.println("################# SYSO 결과출력 START #########################");
//									}
//									if(mbIndex == 2) {
//										System.out.println("################# SYSO 결과출력 START #########################");
//									}
//									if(mbIndex == 3) {
//										System.out.println("################# SYSO 결과출력 START #########################");
//									}
									
									
									// test 23.09.15
//									if(partsGpuHistoryVOList.get(gpuIndex).getId().equals("GPU000169")
//											&& partsCpuHistoryVOList.get(cpuIndex).getId().equals("CPU000002")
//											&& partsMbHistoryVOList.get(mbIndex).getId().equals("MB000002")
//											&& partsCoolerHistoryVOList.get(coolerIndex).getId().equals("COOLER000005")
//											) {
//										System.out.println("################# 드러오냐 #########################");
//									}
									
									/*--------------------------------------------------
									 - 42-2. 현재 진행 ramIndex의 가격 빼기
									*--------------------------------------------------*/
									VC = VC.subtract(new BigDecimal(partsRamHistoryVOList.get(ramIndex).getPartsPrice()));
									
									/*--------------------------------------------------
									 - 43. VC<PRICE인 모든 SSD제품을 소거한다.
									*--------------------------------------------------*/
									for(int i = partsSsdHistoryVOList.size()-1; i >= 0; i--) {
										BigDecimal ssdPrice = new BigDecimal(partsSsdHistoryVOList.get(i).getPartsPrice());
										int compareResult = VC.compareTo(ssdPrice);
										if(compareResult < 0) {
											partsSsdHistoryVOList.remove(i);
										}
									}
									
									/*--------------------------------------------------
									 - 44. γ번째 MB의 SCS<SSD인 모든 SSD제품을 소거한다.
									 - (scs_cd 코드 정수화 하면 순서대로 값1부터 5까지임.)
									 - PRT008 : SCS
									 - 01	SATA3
									 - 02	PCIe 2.0
									 - 03	PCIe 3.0
									 - 04	PCIe 4.0
									 - 05	PCIe 5.0
									*--------------------------------------------------*/
									for(int i = partsSsdHistoryVOList.size()-1; i >= 0; i--) {
										int mbScs = Integer.parseInt(partsMbHistoryVOList.get(mbIndex).getScsCd());
										int ssdScs = Integer.parseInt(partsSsdHistoryVOList.get(i).getScsCd());
										if(mbScs < ssdScs) {
											partsSsdHistoryVOList.remove(i);
										}
									}
									
									
									if(zeroSsdCheck.compareTo(customSsdCheck) == 0
											|| zeroSsdCheck.compareTo(customSsdCheck) < 0) {
					
						
										List<PartsSsdHistoryVO> PRT008_01and256_List = new ArrayList<>();
										List<PartsSsdHistoryVO> PRT008_01and512_List = new ArrayList<>();
										List<PartsSsdHistoryVO> PRT008_01and1024_List = new ArrayList<>();
										List<PartsSsdHistoryVO> PRT008_01and2048_List = new ArrayList<>();
										List<PartsSsdHistoryVO> PRT008_01and4096_List = new ArrayList<>();
										List<PartsSsdHistoryVO> PRT008_03and256_List = new ArrayList<>();
										List<PartsSsdHistoryVO> PRT008_03and512_List = new ArrayList<>();
										List<PartsSsdHistoryVO> PRT008_03and1024_List = new ArrayList<>();
										List<PartsSsdHistoryVO> PRT008_03and2048_List = new ArrayList<>();
										List<PartsSsdHistoryVO> PRT008_03and4096_List = new ArrayList<>();
										List<PartsSsdHistoryVO> PRT008_04and256_List = new ArrayList<>();
										List<PartsSsdHistoryVO> PRT008_04and512_List = new ArrayList<>();
										List<PartsSsdHistoryVO> PRT008_04and1024_List = new ArrayList<>();
										List<PartsSsdHistoryVO> PRT008_04and2048_List = new ArrayList<>();
										List<PartsSsdHistoryVO> PRT008_04and4096_List = new ArrayList<>();
										List<PartsSsdHistoryVO> PRT008_05and256_List = new ArrayList<>();
										List<PartsSsdHistoryVO> PRT008_05and512_List = new ArrayList<>();
										List<PartsSsdHistoryVO> PRT008_05and1024_List = new ArrayList<>();
										List<PartsSsdHistoryVO> PRT008_05and2048_List = new ArrayList<>();
										List<PartsSsdHistoryVO> PRT008_05and4096_List = new ArrayList<>();
										
										List<PartsSsdHistoryVO> ssdEtcList = new ArrayList<>();
										
										for(int i = 0; i < partsSsdHistoryVOList.size(); i++) {
											if("01".equals(partsSsdHistoryVOList.get(i).getScsCd())) {
												if(256 == partsSsdHistoryVOList.get(i).getVolume()) {
													PRT008_01and256_List.add(partsSsdHistoryVOList.get(i));
												}else if(512 == partsSsdHistoryVOList.get(i).getVolume()) {
													PRT008_01and512_List.add(partsSsdHistoryVOList.get(i));
												}else if(1024 == partsSsdHistoryVOList.get(i).getVolume()) {
													PRT008_01and1024_List.add(partsSsdHistoryVOList.get(i));
												}else if(2048 == partsSsdHistoryVOList.get(i).getVolume()) {
													PRT008_01and2048_List.add(partsSsdHistoryVOList.get(i));
												}else if(4096 == partsSsdHistoryVOList.get(i).getVolume()) {
													PRT008_01and4096_List.add(partsSsdHistoryVOList.get(i));
												}else {
													ssdEtcList.add(partsSsdHistoryVOList.get(i));
												}
											}else if("03".equals(partsSsdHistoryVOList.get(i).getScsCd())) {
												if(256 == partsSsdHistoryVOList.get(i).getVolume()) {
													PRT008_03and256_List.add(partsSsdHistoryVOList.get(i));
												}else if(512 == partsSsdHistoryVOList.get(i).getVolume()) {
													PRT008_03and512_List.add(partsSsdHistoryVOList.get(i));
												}else if(1024 == partsSsdHistoryVOList.get(i).getVolume()) {
													PRT008_03and1024_List.add(partsSsdHistoryVOList.get(i));
												}else if(2048 == partsSsdHistoryVOList.get(i).getVolume()) {
													PRT008_03and2048_List.add(partsSsdHistoryVOList.get(i));
												}else if(4096 == partsSsdHistoryVOList.get(i).getVolume()) {
													PRT008_03and4096_List.add(partsSsdHistoryVOList.get(i));
												}else {
													ssdEtcList.add(partsSsdHistoryVOList.get(i));
												}
											}else if("04".equals(partsSsdHistoryVOList.get(i).getScsCd())) {
												if(256 == partsSsdHistoryVOList.get(i).getVolume()) {
													PRT008_04and256_List.add(partsSsdHistoryVOList.get(i));
												}else if(512 == partsSsdHistoryVOList.get(i).getVolume()) {
													PRT008_04and512_List.add(partsSsdHistoryVOList.get(i));
												}else if(1024 == partsSsdHistoryVOList.get(i).getVolume()) {
													PRT008_04and1024_List.add(partsSsdHistoryVOList.get(i));
												}else if(2048 == partsSsdHistoryVOList.get(i).getVolume()) {
													PRT008_04and2048_List.add(partsSsdHistoryVOList.get(i));
												}else if(4096 == partsSsdHistoryVOList.get(i).getVolume()) {
													PRT008_04and4096_List.add(partsSsdHistoryVOList.get(i));
												}else {
													ssdEtcList.add(partsSsdHistoryVOList.get(i));
												}
											}else if("05".equals(partsSsdHistoryVOList.get(i).getScsCd())) {
												if(256 == partsSsdHistoryVOList.get(i).getVolume()) {
													PRT008_05and256_List.add(partsSsdHistoryVOList.get(i));
												}else if(512 == partsSsdHistoryVOList.get(i).getVolume()) {
													PRT008_05and512_List.add(partsSsdHistoryVOList.get(i));
												}else if(1024 == partsSsdHistoryVOList.get(i).getVolume()) {
													PRT008_05and1024_List.add(partsSsdHistoryVOList.get(i));
												}else if(2048 == partsSsdHistoryVOList.get(i).getVolume()) {
													PRT008_05and2048_List.add(partsSsdHistoryVOList.get(i));
												}else if(4096 == partsSsdHistoryVOList.get(i).getVolume()) {
													PRT008_05and4096_List.add(partsSsdHistoryVOList.get(i));
												}else {
													ssdEtcList.add(partsSsdHistoryVOList.get(i));
												}
											}else {
												ssdEtcList.add(partsSsdHistoryVOList.get(i));
											}
										}
										
										valueEraseProcessingBySsd(PRT008_01and256_List);
										valueEraseProcessingBySsd(PRT008_01and512_List);
										valueEraseProcessingBySsd(PRT008_01and1024_List);
										valueEraseProcessingBySsd(PRT008_01and2048_List);
										valueEraseProcessingBySsd(PRT008_01and4096_List);
										valueEraseProcessingBySsd(PRT008_03and256_List);
										valueEraseProcessingBySsd(PRT008_03and512_List);
										valueEraseProcessingBySsd(PRT008_03and1024_List);
										valueEraseProcessingBySsd(PRT008_03and2048_List);
										valueEraseProcessingBySsd(PRT008_03and4096_List);
										valueEraseProcessingBySsd(PRT008_04and256_List);
										valueEraseProcessingBySsd(PRT008_04and512_List);
										valueEraseProcessingBySsd(PRT008_04and1024_List);
										valueEraseProcessingBySsd(PRT008_04and2048_List);
										valueEraseProcessingBySsd(PRT008_04and4096_List);
										valueEraseProcessingBySsd(PRT008_05and256_List);
										valueEraseProcessingBySsd(PRT008_05and512_List);
										valueEraseProcessingBySsd(PRT008_05and1024_List);
										valueEraseProcessingBySsd(PRT008_05and2048_List);
										valueEraseProcessingBySsd(PRT008_05and4096_List);
										valueEraseProcessingBySsd(ssdEtcList);
										
										// 각각 소거 후 리스트화
										partsSsdHistoryVOList = new ArrayList<>();
										
										// 기존리스트에 결과리스트 삽입
										addListBySsd(partsSsdHistoryVOList, PRT008_01and256_List);
										addListBySsd(partsSsdHistoryVOList, PRT008_01and512_List);
										addListBySsd(partsSsdHistoryVOList, PRT008_01and1024_List);
										addListBySsd(partsSsdHistoryVOList, PRT008_01and2048_List);
										addListBySsd(partsSsdHistoryVOList, PRT008_01and4096_List);
										addListBySsd(partsSsdHistoryVOList, PRT008_03and256_List);
										addListBySsd(partsSsdHistoryVOList, PRT008_03and512_List);
										addListBySsd(partsSsdHistoryVOList, PRT008_03and1024_List);
										addListBySsd(partsSsdHistoryVOList, PRT008_03and2048_List);
										addListBySsd(partsSsdHistoryVOList, PRT008_03and4096_List);
										addListBySsd(partsSsdHistoryVOList, PRT008_04and256_List);
										addListBySsd(partsSsdHistoryVOList, PRT008_04and512_List);
										addListBySsd(partsSsdHistoryVOList, PRT008_04and1024_List);
										addListBySsd(partsSsdHistoryVOList, PRT008_04and2048_List);
										addListBySsd(partsSsdHistoryVOList, PRT008_04and4096_List);
										addListBySsd(partsSsdHistoryVOList, PRT008_05and256_List);
										addListBySsd(partsSsdHistoryVOList, PRT008_05and512_List);
										addListBySsd(partsSsdHistoryVOList, PRT008_05and1024_List);
										addListBySsd(partsSsdHistoryVOList, PRT008_05and2048_List);
										addListBySsd(partsSsdHistoryVOList, PRT008_05and4096_List);
										addListBySsd(partsSsdHistoryVOList, ssdEtcList);
										
									}
									
									
									/*--------------------------------------------------
									 - 45. 남은 SSD제품의 개수를 limy라고 한다.
									 - limy<y라면 아래 변수 정렬 후 42번으로 돌아간다.(소거 시점도 42번으로 롤백한다.)
									 - x=x+1 y=1
									 - limy>y라면 연산을 이어나간다.
									*--------------------------------------------------*/
									int limy = partsSsdHistoryVOList.size();
									
									if(limy <= y) {
										// limy<y라면 아래 변수 정렬 후 42번으로 돌아간다. -> limy<=y
										y = 0;
										
										// 알고리즘 누락된거같은데?
										// VC 빼고 더하는 연산식으로 처리하던 과정을 부품list 롤백과 동일한 처리로 과정 변경 23.09.05
//										VC = VC.add(new BigDecimal(partsRamHistoryVOList.get(ramIndex).getPartsPrice()));
										
										continue; // 42번 처음 for 다음 ramIndey 진행
									}
									
									// limy>=y라면 연산을 이어간다. -> limy>y
									for(int ssdIndex = y; ssdIndex < limy; ssdIndex++) {
										
										loopCnt = loopCnt.add(new BigDecimal("1"));
										
										/*--------------------------------------------------
										 - 46. γ번째 MB의 MC가 0이고 y번째 SSD의 STR2.5=0이면서 VC<y번째SSD의 Price+3000일
										 - 때 y=y+1 처리 후 45번으로 돌아간다.
										 - 위 세 조건 중 하나라도 미달된다면 아래의 동작을 취한다.
										 - ω번째 견적 후보에 α β γ k p q x y값을 담고 해당 제품군들의 
										 - Value 총합 수치를 기록한다.
										 - ω=ω+1 y=y+1처리 후 45번으로 돌아간다.
										*--------------------------------------------------*/
										int mbMC = partsMbHistoryVOList.get(mbIndex).getMc();
										int ssdSTR2dot5 = partsSsdHistoryVOList.get(ssdIndex).getStrTwoDotFive();
										BigDecimal ssdPrice = new BigDecimal(partsSsdHistoryVOList.get(ssdIndex).getPartsPrice());
										ssdPrice = ssdPrice.add(new BigDecimal("3000"));
										int compareResult = VC.compareTo(ssdPrice);
										
										if(mbMC == 0 
												&& ssdSTR2dot5 == 0
												&& compareResult < 0) {
											continue;
										}else {
											EstimateCalculationResultPrivateDetailVO resultVO = new EstimateCalculationResultPrivateDetailVO();
											resultVO.setGpuId(partsGpuHistoryVOList.get(gpuIndex).getId());
											resultVO.setGpuHistorySeq(partsGpuHistoryVOList.get(gpuIndex).getHistorySeq());
											resultVO.setGpuValue(partsGpuHistoryVOList.get(gpuIndex).getGpuValue());
											
											resultVO.setCpuId(partsCpuHistoryVOList.get(cpuIndex).getId());
											resultVO.setCpuHistorySeq(partsCpuHistoryVOList.get(cpuIndex).getHistorySeq());
											resultVO.setCpuValue(partsCpuHistoryVOList.get(cpuIndex).getCpuValue());
											
											resultVO.setMbId(partsMbHistoryVOList.get(mbIndex).getId());
											resultVO.setMbHistorySeq(partsMbHistoryVOList.get(mbIndex).getHistorySeq());
											resultVO.setMbValue(partsMbHistoryVOList.get(mbIndex).getMbValue());
											
											resultVO.setCoolerId(partsCoolerHistoryVOList.get(coolerIndex).getId());
											resultVO.setCoolerHistorySeq(partsCoolerHistoryVOList.get(coolerIndex).getHistorySeq());
											resultVO.setCoolerValue(partsCoolerHistoryVOList.get(coolerIndex).getCoolerValue());
											
											resultVO.setCaseId(partsCaseHistoryVOList.get(caseIndex).getId());
											resultVO.setCaseHistorySeq(partsCaseHistoryVOList.get(caseIndex).getHistorySeq());
											resultVO.setCaseValue(partsCaseHistoryVOList.get(caseIndex).getCaseValue());
											
											resultVO.setPsuId(partsPsuHistoryVOList.get(psuIndex).getId());
											resultVO.setPsuHistorySeq(partsPsuHistoryVOList.get(psuIndex).getHistorySeq());
											resultVO.setPsuValue(partsPsuHistoryVOList.get(psuIndex).getPsuValue());
											
											resultVO.setRamId(partsRamHistoryVOList.get(ramIndex).getId());
											resultVO.setRamHistorySeq(partsRamHistoryVOList.get(ramIndex).getHistorySeq());
											resultVO.setRamValue(partsRamHistoryVOList.get(ramIndex).getRamValue());
											
											resultVO.setSsdId(partsSsdHistoryVOList.get(ssdIndex).getId());
											resultVO.setSsdHistorySeq(partsSsdHistoryVOList.get(ssdIndex).getHistorySeq());
											resultVO.setSsdValue(partsSsdHistoryVOList.get(ssdIndex).getSsdValue());
											
											resultVO.setTotalValue(
													resultVO.getGpuValue()
													.add(resultVO.getCpuValue())
													.add(resultVO.getMbValue())
													.add(resultVO.getCoolerValue())
													.add(resultVO.getCaseValue())
													.add(resultVO.getPsuValue())
													.add(resultVO.getRamValue())
													.add(resultVO.getSsdValue())
											);
											
											ω.add(resultVO);
										}
										
									} // 45번 for end
								} // 42번 for end
							} // 39번 for end
						} // 33번 for end
					} // 27번 for end
				} // 24번 for end
			} // 18번 for end
		} // 13번 for end
		

		/*--------------------------------------------------
		 - 47. ω=1일 경우 견적산출 불가 알림을 띄운다.
		*--------------------------------------------------*/
		if(0 == ω.size()) {
			String errMsg = "########## 견적산출 ERROR : 견적산출 결과저장량이 0입니다.";
			
			System.out.println(errMsg);
			estimateCalculationResultPrivateMasterVO.setErrChk(true);
			estimateCalculationResultPrivateMasterVO.setErrMsg(errMsg);
		}else {
			
			/*--------------------------------------------------
			 - 48. ω>1일 경우 Value.SUM(1~ω)으로부터 가장 높은 
			 - 수치를 가진 견적을 추적한다.
			 - 49. α β γ k p q x y값을 복원한 뒤 13번 이후의 알고리즘을 
			 - 복제하여 최종 선정 제품군들을 추적하고 산출페이지에 해당 제품을 전시한다.
			*--------------------------------------------------*/
			int selectIndex = 0;
			BigDecimal maxValue = BigDecimal.ZERO;
			for(int i = 0; i < ω.size(); i++) {
				BigDecimal tempValue = ω.get(i).getTotalValue();
				int compareResult = maxValue.compareTo(tempValue);
				if(compareResult < 0) {
					selectIndex = i;
					maxValue = tempValue;
				}
			}
			// 가장 value가 큰 모델 정보를 가진 EstimateCalculationResultPrivateDetailVO 세팅
			estimateCalculationResultPrivateMasterVO.setSelectProduct(ω.get(selectIndex));
			
			/*--------------------------------------------------
			 - 완본체 등록처리부(현재시점 견적산출일 때)
			*--------------------------------------------------*/
			if(null == targetDate) {
				int productPrice = 0;
				String maxId = productDAO.getProductMasterVOMaxId();
				
				estimateCalculationResultPrivateMasterVO.setCreateProductId(maxId);
				
				// gpu 등록
				ProductDetailVO productDetailGpuVO = new ProductDetailVO();
				PartsGpuVO partsGpuVO = partsService.getPartsGpuVOById(estimateCalculationResultPrivateMasterVO.getSelectProduct().getGpuId());
				
				productDetailGpuVO.setId(maxId);
				productDetailGpuVO.setSeq(1);
				productDetailGpuVO.setPartsTypeCd("01");
				productDetailGpuVO.setPartsId(partsGpuVO.getId());
				productDetailGpuVO.setPartsName(partsGpuVO.getPartsName());
				productDetailGpuVO.setPartsQty(1);
				productDetailGpuVO.setPartsPrice(partsGpuVO.getPartsPrice());
				productDetailGpuVO.setPartsTotalPrice(partsGpuVO.getPartsPrice());
				productDetailGpuVO.setPartsHistorySeq(partsGpuVO.getPartsHistorySeq());
				productPrice += partsGpuVO.getPartsPrice();
				
				productDAO.insertProductDetailVO(productDetailGpuVO);
				
				// cpu 등록
				ProductDetailVO productDetailCpuVO = new ProductDetailVO();
				PartsCpuVO partsCpuVO = partsService.getPartsCpuVOById(estimateCalculationResultPrivateMasterVO.getSelectProduct().getCpuId());
				
				productDetailCpuVO.setId(maxId);
				productDetailCpuVO.setSeq(2);
				productDetailCpuVO.setPartsTypeCd("02");
				productDetailCpuVO.setPartsId(partsCpuVO.getId());
				productDetailCpuVO.setPartsName(partsCpuVO.getPartsName());
				productDetailCpuVO.setPartsQty(1);
				productDetailCpuVO.setPartsPrice(partsCpuVO.getPartsPrice());
				productDetailCpuVO.setPartsTotalPrice(partsCpuVO.getPartsPrice());
				productDetailCpuVO.setPartsHistorySeq(partsCpuVO.getPartsHistorySeq());
				productPrice += partsCpuVO.getPartsPrice();
				
				productDAO.insertProductDetailVO(productDetailCpuVO);
				
				// mb 등록
				ProductDetailVO productDetailMbVO = new ProductDetailVO();
				PartsMbVO partsMbVO = partsService.getPartsMbVOById(estimateCalculationResultPrivateMasterVO.getSelectProduct().getMbId());
				
				productDetailMbVO.setId(maxId);
				productDetailMbVO.setSeq(3);
				productDetailMbVO.setPartsTypeCd("03");
				productDetailMbVO.setPartsId(partsMbVO.getId());
				productDetailMbVO.setPartsName(partsMbVO.getPartsName());
				productDetailMbVO.setPartsQty(1);
				productDetailMbVO.setPartsPrice(partsMbVO.getPartsPrice());
				productDetailMbVO.setPartsTotalPrice(partsMbVO.getPartsPrice());
				productDetailMbVO.setPartsHistorySeq(partsMbVO.getPartsHistorySeq());
				productPrice += partsMbVO.getPartsPrice();
				
				productDAO.insertProductDetailVO(productDetailMbVO);
				
				// Cooler 등록
				ProductDetailVO productDetailCoolerVO = new ProductDetailVO();
				PartsCoolerVO partsCoolerVO = partsService.getPartsCoolerVOById(estimateCalculationResultPrivateMasterVO.getSelectProduct().getCoolerId());
				
				productDetailCoolerVO.setId(maxId);
				productDetailCoolerVO.setSeq(4);
				productDetailCoolerVO.setPartsTypeCd("07");
				productDetailCoolerVO.setPartsId(partsCoolerVO.getId());
				productDetailCoolerVO.setPartsName(partsCoolerVO.getPartsName());
				productDetailCoolerVO.setPartsQty(1);
				productDetailCoolerVO.setPartsPrice(partsCoolerVO.getPartsPrice());
				productDetailCoolerVO.setPartsTotalPrice(partsCoolerVO.getPartsPrice());
				productDetailCoolerVO.setPartsHistorySeq(partsCoolerVO.getPartsHistorySeq());
				productPrice += partsCoolerVO.getPartsPrice();
				
				productDAO.insertProductDetailVO(productDetailCoolerVO);
				
				// Case 등록
				ProductDetailVO productDetailCaseVO = new ProductDetailVO();
				PartsCaseVO partsCaseVO = partsService.getPartsCaseVOById(estimateCalculationResultPrivateMasterVO.getSelectProduct().getCaseId());
				
				productDetailCaseVO.setId(maxId);
				productDetailCaseVO.setSeq(5);
				productDetailCaseVO.setPartsTypeCd("06");
				productDetailCaseVO.setPartsId(partsCaseVO.getId());
				productDetailCaseVO.setPartsName(partsCaseVO.getPartsName());
				productDetailCaseVO.setPartsQty(1);
				productDetailCaseVO.setPartsPrice(partsCaseVO.getPartsPrice());
				productDetailCaseVO.setPartsTotalPrice(partsCaseVO.getPartsPrice());
				productDetailCaseVO.setPartsHistorySeq(partsCaseVO.getPartsHistorySeq());
				productPrice += partsCaseVO.getPartsPrice();
				
				productDAO.insertProductDetailVO(productDetailCaseVO);
				
				// Psu 등록
				ProductDetailVO productDetailPsuVO = new ProductDetailVO();
				PartsPsuVO partsPsuVO = partsService.getPartsPsuVOById(estimateCalculationResultPrivateMasterVO.getSelectProduct().getPsuId());
				
				productDetailPsuVO.setId(maxId);
				productDetailPsuVO.setSeq(6);
				productDetailPsuVO.setPartsTypeCd("05");
				productDetailPsuVO.setPartsId(partsPsuVO.getId());
				productDetailPsuVO.setPartsName(partsPsuVO.getPartsName());
				productDetailPsuVO.setPartsQty(1);
				productDetailPsuVO.setPartsPrice(partsPsuVO.getPartsPrice());
				productDetailPsuVO.setPartsTotalPrice(partsPsuVO.getPartsPrice());
				productDetailPsuVO.setPartsHistorySeq(partsPsuVO.getPartsHistorySeq());
				productPrice += partsPsuVO.getPartsPrice();
				
				productDAO.insertProductDetailVO(productDetailPsuVO);
				
				// Ram 등록
				ProductDetailVO productDetailRamVO = new ProductDetailVO();
				PartsRamVO partsRamVO = partsService.getPartsRamVOById(estimateCalculationResultPrivateMasterVO.getSelectProduct().getRamId());
				
				productDetailRamVO.setId(maxId);
				productDetailRamVO.setSeq(7);
				productDetailRamVO.setPartsTypeCd("04");
				productDetailRamVO.setPartsId(partsRamVO.getId());
				productDetailRamVO.setPartsName(partsRamVO.getPartsName());
				productDetailRamVO.setPartsQty(1);
				productDetailRamVO.setPartsPrice(partsRamVO.getPartsPrice());
				productDetailRamVO.setPartsTotalPrice(partsRamVO.getPartsPrice());
				productDetailRamVO.setPartsHistorySeq(partsRamVO.getPartsHistorySeq());
				productPrice += partsRamVO.getPartsPrice();
				
				productDAO.insertProductDetailVO(productDetailRamVO);
				
				// Ssd 등록
				ProductDetailVO productDetailSsdVO = new ProductDetailVO();
				PartsSsdVO partsSsdVO = partsService.getPartsSsdVOById(estimateCalculationResultPrivateMasterVO.getSelectProduct().getSsdId());
				
				productDetailSsdVO.setId(maxId);
				productDetailSsdVO.setSeq(8);
				productDetailSsdVO.setPartsTypeCd("09");
				productDetailSsdVO.setPartsId(partsSsdVO.getId());
				productDetailSsdVO.setPartsName(partsSsdVO.getPartsName());
				productDetailSsdVO.setPartsQty(1);
				productDetailSsdVO.setPartsPrice(partsSsdVO.getPartsPrice());
				productDetailSsdVO.setPartsTotalPrice(partsSsdVO.getPartsPrice());
				productDetailSsdVO.setPartsHistorySeq(partsSsdVO.getPartsHistorySeq());
				productPrice += partsSsdVO.getPartsPrice();
				
				productDAO.insertProductDetailVO(productDetailSsdVO);
				
				// 완본체 마스터등록
				ProductMasterVO productMasterVO = new ProductMasterVO();
				productMasterVO.setId(maxId);
				productMasterVO.setProductName("견적산출 자동등록 완본체");
//				productMasterVO.setProductPrice(productPrice);
//				productMasterVO.setProductQty(1);
				// 23.11.02 완본체 견적산출자동등록 수량 999개로 정함.
				productMasterVO.setProductQty(999);
				productMasterVO.setProductDescription("targetUserId:"+targetUserId);
				productMasterVO.setProductImage(partsCaseVO.getPartsImage());
				productMasterVO.setProductRegistPathCd("02");
				
				// 업무공백 중 발생한 수정사항 질문 0번 추가
				productMasterVO.setWindowsName(windowsName);
				productMasterVO.setWindowsPrice(windowsPrice);
				
				productPrice += windowsPrice;
				productMasterVO.setProductPrice(productPrice);
				
				productDAO.insertProductMasterVO(productMasterVO);
			}
		} // 47번 if else end
		
		estimateCalculationResultPrivateMasterVO.setTargetUserId(targetUserId);
		
		return estimateCalculationResultPrivateMasterVO;
	}
	
	/*--------------------------------------------------
	 - 각 부품 별 value 소거처리부 
	 - 특정 부품 특정 데이터의 사용자 지정 값(발주처 제공)에 따라 리스트업 후
	 - 별도로 value 소거처리로직 적용하는 부분에서 같은 기능의 코드를
	 - 과도하게 반복사용하게 됨으로써 소거처리로직 모듈화 진행.
	 - 23.10.10 
	 - Ver1.0
	*--------------------------------------------------*/
	private void valueEraseProcessingByCooler(List<PartsCoolerHistoryVO> coolerList) {
		for(int i = coolerList.size()-1; i >= 1; i--) {
			int targetIndex = i-1;
			
			BigDecimal value1 = coolerList.get(targetIndex).getCoolerValue();
			BigDecimal value2 = coolerList.get(targetIndex+1).getCoolerValue();
			
			int compareResult1 = value1.compareTo(value2);
			
			if(compareResult1 < 0) {
				// value1 < value2
				continue;
			}
			
			// 중첩 반복(대상 인덱스로부터 위로 검증)
			int zTargetSize = coolerList.size();
			for(int z = targetIndex+1; z < zTargetSize; z++) {
				if(z == zTargetSize) {
					break;
				}
				BigDecimal value3 = coolerList.get(z).getCoolerValue();
				
				int compareResult2 = value1.compareTo(value3);
				if(compareResult2 > 0 || compareResult2 == 0) {
					// value1 > value3 or value1 == value3
					coolerList.remove(z);
					--zTargetSize;
					--z;
				}
			}
		}
	}
	
	private void valueEraseProcessingBySsd(List<PartsSsdHistoryVO> ssdList) {
		for(int i = ssdList.size()-1; i >= 1; i--) {
			int targetIndex = i-1;
			
			BigDecimal value1 = ssdList.get(targetIndex).getSsdValue();
			BigDecimal value2 = ssdList.get(targetIndex+1).getSsdValue();
			
			int compareResult1 = value1.compareTo(value2);
			
			if(compareResult1 < 0) {
				// value1 < value2
				continue;
			}
			
			// 중첩 반복(대상 인덱스로부터 위로 검증)
			int zTargetSize = ssdList.size();
			for(int z = targetIndex+1; z < zTargetSize; z++) {
				if(z == zTargetSize) {
					break;
				}
				BigDecimal value3 = ssdList.get(z).getSsdValue();
				
				int compareResult2 = value1.compareTo(value3);
				if(compareResult2 > 0 || compareResult2 == 0) {
					// value1 > value3 or value1 == value3
					ssdList.remove(z);
					--zTargetSize;
					--z;
				}
			}
		}
	}
	
	private void addListBySsd(List<PartsSsdHistoryVO> targetList, List<PartsSsdHistoryVO> addList) {
		for(int i = 0; i < addList.size(); i++) {
			targetList.add(addList.get(i));
		}
	}
	
	private void valueEraseProcessingByRam(List<PartsRamHistoryVO> ramList) {
		for(int i = ramList.size()-1; i >= 1; i--) {
			int targetIndex = i-1;
			
			BigDecimal value1 = ramList.get(targetIndex).getRamValue();
			BigDecimal value2 = ramList.get(targetIndex+1).getRamValue();
			
			int compareResult1 = value1.compareTo(value2);
			
			if(compareResult1 < 0) {
				// value1 < value2
				continue;
			}
			
			// 중첩 반복(대상 인덱스로부터 위로 검증)
			int zTargetSize = ramList.size();
			for(int z = targetIndex+1; z < zTargetSize; z++) {
				if(z == zTargetSize) {
					break;
				}
				BigDecimal value3 = ramList.get(z).getRamValue();
				
				int compareResult2 = value1.compareTo(value3);
				if(compareResult2 > 0 || compareResult2 == 0) {
					// value1 > value3 or value1 == value3
					ramList.remove(z);
					--zTargetSize;
					--z;
				}
			}
		}
	}
	
	/*--------------------------------------------------
	 - 견적산출로직
	 - Ver1.1 (버전 업 시 추가예정)
	*--------------------------------------------------*/
	
}
