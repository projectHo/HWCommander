package com.hw.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hw.dao.ProductDAO;
import com.hw.model.EstimateCalculationResultPrivateVO;
import com.hw.model.PartsCaseHistoryVO;
import com.hw.model.PartsCoolerHistoryVO;
import com.hw.model.PartsCpuHistoryVO;
import com.hw.model.PartsGpuHistoryVO;
import com.hw.model.PartsHddHistoryVO;
import com.hw.model.PartsMbHistoryVO;
import com.hw.model.PartsPsuHistoryVO;
import com.hw.model.PartsRamHistoryVO;
import com.hw.model.PartsSfHistoryVO;
import com.hw.model.PartsSsdHistoryVO;
import com.hw.model.ProductDetailVO;
import com.hw.model.ProductMasterVO;
import com.hw.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
    private ProductDAO productDAO;
	
	@Override
	public Integer productRegistLogic(ProductMasterVO productMasterVO, List<ProductDetailVO> productDetailVOList) {
		int insertResult = 0;
		String maxId = productDAO.getProductMasterVOMaxId();
		
		for(int i = 0; i < productDetailVOList.size(); i++) {
			ProductDetailVO productDetailVO = new ProductDetailVO();
			productDetailVO = productDetailVOList.get(i); 
			productDetailVO.setId(maxId);
			productDetailVO.setSeq(i+1);
			
			if("CASE".equals(productDetailVO.getPartsId().substring(0, 4))) {
				productMasterVO.setProductImage(productDetailVO.getPartsImage());
			}
			
			productDAO.insertProductDetailVO(productDetailVO);
		}
		
		productMasterVO.setId(maxId);

		insertResult = productDAO.insertProductMasterVO(productMasterVO);
		return insertResult;
	}
	
	@Override
	public List<ProductMasterVO> getProductMasterAllList() {
		return productDAO.getProductMasterAllList();
	}
	
	@Override
	public List<ProductMasterVO> getEventMallList() {
		return productDAO.getEventMallList();
	}
	
	@Override
	public ProductMasterVO getProductMasterById(String id) {
		return productDAO.getProductMasterById(id);
	}
	
	@Override
	public List<ProductDetailVO> getProductDetailById(String id) {
		return productDAO.getProductDetailById(id);
	}
	
	@Override
	public Integer productUpdateLogic(ProductMasterVO productMasterVO, List<ProductDetailVO> productDetailVOList) {
		int updateResult = 0;
		String targetId = productMasterVO.getId();
		
		ProductDetailVO deleteVO = new ProductDetailVO();
		deleteVO.setId(targetId);
		
		int delete = productDAO.deleteProductDetailVO(deleteVO);
		
		for(int i = 0; i < productDetailVOList.size(); i++) {
			ProductDetailVO productDetailVO = new ProductDetailVO();
			productDetailVO = productDetailVOList.get(i); 
			productDetailVO.setId(targetId);
			productDetailVO.setSeq(i+1);
			
			productDAO.insertProductDetailVO(productDetailVO);
		}

		updateResult = productDAO.updateProductMasterVO(productMasterVO);
		return updateResult;
	}
	
	@Override
	public EstimateCalculationResultPrivateVO estimateCalculation(String urlText) {
		EstimateCalculationResultPrivateVO estimateCalculationResultPrivateVO = new EstimateCalculationResultPrivateVO();
		
		//임시로 적용(복수선택에서 무조건 복수)
//		urlText = "answer1<Price,3000000>|answer2<PR000001,60:PR000004,30:PR000008,10>|answer3<Fever,1.111:Meterial,1.222:AS,1.333:Noise,1.444:Stability,1.555:QC,1.666>|answer4<Wireless,0>|answer5<CPU,1>|answer6<GPU,1>|answer7<Aio,2>|answer8<main-color,:sub-color,>|answer9<RAM,1>|answer10<Bulk,2>|answer11<Ssd,3>|answer12<Metarial,[\"1\",\"4\",\"3\"]>|answer13<HDD,4:3>|answer14<Window,2>|answer15<Fan,1>|answer16<LED,[\"0\",\"2\"]>|answer17<null,null>|answer18<null,null>|answer19<null,null>|answer20<null,null>|etc<userId,root> |etc<targetDate,null>";

		// 임시로 적용(복수선택에서 무조건 단일선택)
//		urlText = "answer1<Price,3000000>|answer2<PR000001,100>|answer3<Fever,1.1:Meterial,1.2:AS,1.3:Noise,1.4:Stability,1.5:QC,1.6>|answer4<Wireless,1>|answer5<CPU,2>|answer6<GPU,2>|answer7<Aio,2>|answer8<main-color,:sub-color,>|answer9<RAM,2>|answer10<Bulk,3>|answer11<Ssd,3>|answer12<Metarial,["5"]>|answer13<HDD,5:null>|answer14<Window,2>|answer15<Fan,2>|answer16<LED,["3"]>|answer17<null,null>|answer18<null,null>|answer19<null,null>|answer20<null,null>|etc<userId,root> |etc<targetDate,null>";
		
		// 1, 2번 질문만 답변했을 때
		urlText = "answer1<Price,10000>|answer2<PR999999,100>|answer3<Fever,:Meterial,:AS,:Noise,:Stability,:QC,>|answer4<Wireless>|answer5<CPU>|answer6<GPU>|answer7<Aio>|answer8<main-color,:sub-color,>|answer9<RAM>|answer10<Bulk>|answer11<Ssd>|answer12<Metarial>|answer13<HDD>|answer14<Window>|answer15<Fan>|answer16<LED>|answer17<null,null>|answer18<null,null>|answer19<null,null>|answer20<null,null>|etc<userId,root>|etc<targetDate,null>";
		
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
		
		/*--------------------------------------------------
		 - 0-1. 견적산출질문에 대한 답변 데이터 변수 선언 및 초기화
		*--------------------------------------------------*/
		BigDecimal answer1 = BigDecimal.ZERO;
		Map<String, Integer> answer2 = new HashMap<>();
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
		Integer answer15 = null;
		Integer[] answer16 = null;
		List<Map<String, String>> answer17 = new ArrayList<>(); //프론트 미구현
		List<Map<String, String>> answer18 = new ArrayList<>(); //프론트 미구현
		List<Map<String, String>> answer19 = new ArrayList<>(); //프론트 미구현
		List<Map<String, String>> answer20 = new ArrayList<>(); //프론트 미구현
		
		/*--------------------------------------------------
		 - 0-2. 견적산출 대상 시간 선언 및 초기화
		*--------------------------------------------------*/
		String targetDate = null;
		
		/*--------------------------------------------------
		 - 0-3. 견적산출 대상 유저 id 선언 및 초기화
		*--------------------------------------------------*/
		String targetId = null;
		
		/*--------------------------------------------------
		 - 0-4. 견적산출화면으로부터 넘어온 text 데이터화
		*--------------------------------------------------*/
		String[] urlTextArray = urlText.split("\\|");
		
		// 질문 20개, 견적산출 대상 유저id, 견적산출 대상시간 도합 22가 아닐 시 에러 return
		if(22 != urlTextArray.length) {
			String errMsg = "########## 견적산출 ERROR : 질문답변갯수가 안맞음 ㄲㅈ셈";
			
			System.out.println(errMsg);
			estimateCalculationResultPrivateVO.setErrChk(true);
			estimateCalculationResultPrivateVO.setErrMsg(errMsg);
			
			return estimateCalculationResultPrivateVO;
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
			estimateCalculationResultPrivateVO.setErrChk(true);
			estimateCalculationResultPrivateVO.setErrMsg(errMsg);
			
			return estimateCalculationResultPrivateVO;
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
			estimateCalculationResultPrivateVO.setErrChk(true);
			estimateCalculationResultPrivateVO.setErrMsg(errMsg);
			
			return estimateCalculationResultPrivateVO;
		}else {
			for(int i = 0; i < nameValueArray.length; i++) {
				String tempArray[] = nameValueArray[i].split(",");
				if(2 == tempArray.length) {
					answer2.put(tempArray[0], Integer.parseInt(tempArray[1]));
				}
			}
		}
		
		// 3번질문
		tempText = urlTextArray[2];
		tempText = tempText.replaceAll(" ", "");
		
		// 답변을 하지 않았을 때 Front에서 넘기는 기본텍스트값
		if(!"answer3<Fever,:Meterial,:AS,:Noise,:Stability,:QC,>".equals(tempText)) {
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
		if(!"answer4<Wireless>".equals(tempText)) {
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
		if(!"answer5<CPU>".equals(tempText)) {
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
		if(!"answer6<GPU>".equals(tempText)) {
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
		if(!"answer7<Aio>".equals(tempText)) {
			tempText = tempText.replaceAll("answer7", "");
			tempText = tempText.replaceAll("<", "");
			tempText = tempText.replaceAll(">", "");
			
			nameValueArray = tempText.split(",");
			
			answer7 = Integer.parseInt(nameValueArray[1]);
		}
		
		// 8번질문 (미구현)
		
		// 9번질문
		tempText = urlTextArray[8];
		tempText = tempText.replaceAll(" ", "");
		
		// 답변을 하지 않았을 때 Front에서 넘기는 기본텍스트값
		if(!"answer9<RAM>".equals(tempText)) {
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
		if(!"answer10<Bulk>".equals(tempText)) {
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
		if(!"answer11<Ssd>".equals(tempText)) {
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
		if(!"answer12<Metarial>".equals(tempText)) {
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
		if(!"answer13<HDD>".equals(tempText)) {
			tempText = tempText.replaceAll("answer13", "");
			tempText = tempText.replaceAll("<HDD,", "");
			tempText = tempText.replaceAll(">", "");
			
			nameValueArray = tempText.split(":");
			
			if(2 != nameValueArray.length) {
				String errMsg = "########## 견적산출 ERROR : 13번질문에 대한 답변값이 2개가 아님(필요없음일 시 null 전송)";
				
				System.out.println(errMsg);
				estimateCalculationResultPrivateVO.setErrChk(true);
				estimateCalculationResultPrivateVO.setErrMsg(errMsg);
				
				return estimateCalculationResultPrivateVO;
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
		if(!"answer14<Window>".equals(tempText)) {
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
		if(!"answer15<Fan>".equals(tempText)) {
			tempText = tempText.replaceAll("answer15", "");
			tempText = tempText.replaceAll("<", "");
			tempText = tempText.replaceAll(">", "");
			
			nameValueArray = tempText.split(",");
			
			answer15 = Integer.parseInt(nameValueArray[1]);
		}
		
		// 16번질문
		tempText = urlTextArray[15];
		tempText = tempText.replaceAll(" ", "");
		
		// 답변을 하지 않았을 때 Front에서 넘기는 기본텍스트값
		if(!"answer16<LED>".equals(tempText)) {
			tempText = tempText.replaceAll("answer16", "");
			tempText = tempText.replaceAll("<LED,", "");
			tempText = tempText.replaceAll(">", "");
			tempText = tempText.replaceAll("\\[", "");
			tempText = tempText.replaceAll("\\]", "");
			tempText = tempText.replaceAll("\"", "");
			
			nameValueArray = tempText.split(",");
			
			String[] tempTextArray = nameValueArray;
			answer16 = new Integer[tempTextArray.length];
			for(int i = 0; i < tempTextArray.length; i++) {
				answer16[i] = Integer.parseInt(tempTextArray[i]);
			}
		}
		
		// 17번질문
		
		// 18번질문
		
		// 19번질문
		
		// 20번질문
		
		// etc(userId) index=20
		tempText = urlTextArray[20];
		tempText = tempText.replaceAll(" ", "");
		
		tempText = tempText.replaceAll("etc", "");
		tempText = tempText.replaceAll("<", "");
		tempText = tempText.replaceAll(">", "");
		
		nameValueArray = tempText.split(",");
		
		if(2 != nameValueArray.length) {
			String errMsg = "########## 견적산출 ERROR : userId 데이터전송 오류";
			
			System.out.println(errMsg);
			estimateCalculationResultPrivateVO.setErrChk(true);
			estimateCalculationResultPrivateVO.setErrMsg(errMsg);
			
			return estimateCalculationResultPrivateVO;
		}else {
			targetId = nameValueArray[1];
		}
		
		// etc(targetDate) index=21
		tempText = urlTextArray[21];
		tempText = tempText.replaceAll(" ", "");
		
		tempText = tempText.replaceAll("etc", "");
		tempText = tempText.replaceAll("<", "");
		tempText = tempText.replaceAll(">", "");
		
		nameValueArray = tempText.split(",");
		
		if(2 != nameValueArray.length) {
			String errMsg = "########## 견적산출 ERROR : targetDate 데이터전송 오류";
			
			System.out.println(errMsg);
			estimateCalculationResultPrivateVO.setErrChk(true);
			estimateCalculationResultPrivateVO.setErrMsg(errMsg);
			
			return estimateCalculationResultPrivateVO;
		}else {
			// 과거 견적산출로부터 넘어오지 않을 경우 문자열 "null"을 화면에서 뿌림.
			// 일반 견적산출이면 날짜는 targetDate = "null", 과거견적산출이면 targetDate에 반영
			// ex) '2023-07-25 23:10:22'
			if(!"null".equals(nameValueArray[1])) {
				targetDate = nameValueArray[1];
			}
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
		int c_gpu = 1;
		int c_cpu = 1;
		int c_mb = 1;
		int c_cooler = 1;
		int c_case = 1;
		int c_psu = 1;
		int c_ram = 1;
		int c_ssd = 1;
		int c_estimateSave = 1;
		
		// 프론트에서 만단위 곱해서 보내주기때문에 백엔드에서 만단위 나눠서 대입함.
//		BigDecimal VC = answer1.divide(new BigDecimal("10000"));
		
//		07.29 VC와 Price 일원화 하기로 함 프론트에서 만 단위 곱해서 보내준 수 그대로 쓰기로 함.
		BigDecimal VC = answer1;
		
		BigDecimal CQC = new BigDecimal(1);
		BigDecimal CSFT = new BigDecimal(1);
		BigDecimal CTH = new BigDecimal(1);
		BigDecimal CAS = new BigDecimal(1);
		BigDecimal CMT = new BigDecimal(1);
		
		
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
					estimateCalculationResultPrivateVO.setErrChk(true);
					estimateCalculationResultPrivateVO.setErrMsg(errMsg);
					
					return estimateCalculationResultPrivateVO;
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
		
		if(null != answer11) {
			for(int i = partsSsdHistoryVOList.size()-1; i >= 0; i--) {
				if(0 == answer11) {
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
				
				if(1 == answer11) {
					// 256GB
					if(256 != partsSsdHistoryVOList.get(i).getVolume()) {
						partsSsdHistoryVOList.remove(i);
					}
				}
				
				if(2 == answer11) {
					// 512GB
					if(512 != partsSsdHistoryVOList.get(i).getVolume()) {
						partsSsdHistoryVOList.remove(i);
					}
				}
				
				if(3 == answer11) {
					// 1024GB
					if(1024 != partsSsdHistoryVOList.get(i).getVolume()) {
						partsSsdHistoryVOList.remove(i);
					}
				}
				
				if(4 == answer11) {
					// 2048GB
					if(2048 != partsSsdHistoryVOList.get(i).getVolume()) {
						partsSsdHistoryVOList.remove(i);
					}
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
			if(0 > partsGpuHistoryVOList.get(i).getPartsPrice()
					|| checkPrice > partsGpuHistoryVOList.get(i).getPartsPrice()) {
				partsGpuHistoryVOList.remove(i);
			}
		}
		
		for(int i = partsCpuHistoryVOList.size()-1; i >= 0; i--) {
			if(0 > partsCpuHistoryVOList.get(i).getPartsPrice()
					|| checkPrice > partsCpuHistoryVOList.get(i).getPartsPrice()) {
				partsCpuHistoryVOList.remove(i);
			}
		}
		
		for(int i = partsMbHistoryVOList.size()-1; i >= 0; i--) {
			if(0 > partsMbHistoryVOList.get(i).getPartsPrice()
					|| checkPrice > partsMbHistoryVOList.get(i).getPartsPrice()) {
				partsMbHistoryVOList.remove(i);
			}
		}
		
		for(int i = partsRamHistoryVOList.size()-1; i >= 0; i--) {
			if(0 > partsRamHistoryVOList.get(i).getPartsPrice()
					|| checkPrice > partsRamHistoryVOList.get(i).getPartsPrice()) {
				partsRamHistoryVOList.remove(i);
			}
		}
		
		for(int i = partsPsuHistoryVOList.size()-1; i >= 0; i--) {
			if(0 > partsPsuHistoryVOList.get(i).getPartsPrice()
					|| checkPrice > partsPsuHistoryVOList.get(i).getPartsPrice()) {
				partsPsuHistoryVOList.remove(i);
			}
		}
		
		for(int i = partsCaseHistoryVOList.size()-1; i >= 0; i--) {
			if(0 > partsCaseHistoryVOList.get(i).getPartsPrice()
					|| checkPrice > partsCaseHistoryVOList.get(i).getPartsPrice()) {
				partsCaseHistoryVOList.remove(i);
			}
		}
		
		for(int i = partsCoolerHistoryVOList.size()-1; i >= 0; i--) {
			if(0 > partsCoolerHistoryVOList.get(i).getPartsPrice()
					|| checkPrice > partsCoolerHistoryVOList.get(i).getPartsPrice()) {
				partsCoolerHistoryVOList.remove(i);
			}
		}
		
		for(int i = partsHddHistoryVOList.size()-1; i >= 0; i--) {
			if(0 > partsHddHistoryVOList.get(i).getPartsPrice()
					|| checkPrice > partsHddHistoryVOList.get(i).getPartsPrice()) {
				partsHddHistoryVOList.remove(i);
			}
		}
		
		for(int i = partsSsdHistoryVOList.size()-1; i >= 0; i--) {
			if(0 > partsSsdHistoryVOList.get(i).getPartsPrice()
					|| checkPrice > partsSsdHistoryVOList.get(i).getPartsPrice()) {
				partsSsdHistoryVOList.remove(i);
			}
		}
		
		for(int i = partsSfHistoryVOList.size()-1; i >= 0; i--) {
			if(0 > partsSfHistoryVOList.get(i).getPartsPrice()
					|| checkPrice > partsSfHistoryVOList.get(i).getPartsPrice()) {
				partsSfHistoryVOList.remove(i);
			}
		}
		
		
		return estimateCalculationResultPrivateVO;
		
	}
}
