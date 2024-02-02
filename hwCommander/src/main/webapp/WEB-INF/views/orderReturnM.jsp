<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.io.*"%>



<%

	/////////////////////////////////////////////////////////////////////////////
	///// 1. 변수 초기화 및 POST 인증값 받음                                 ////
	/////////////////////////////////////////////////////////////////////////////
	request.setCharacterEncoding("UTF-8");

	String P_STATUS = request.getParameter("P_STATUS");			// 인증 상태
	String P_RMESG1 = request.getParameter("P_RMESG1");			// 인증 결과 메시지
	String P_TID = request.getParameter("P_TID");				// 인증 거래번호
	String P_REQ_URL = request.getParameter("P_REQ_URL");		// 결제요청 URL
	String P_NOTI = request.getParameter("P_NOTI");				// 기타주문정보
	
	HashMap<String, String> map = new HashMap<String, String>();

	////////////////////////////////////////////////////////////////////////////
	// 인증성공 P_STATUS=00 확인
	// IDC센터 확인 [idc_name=fc,ks,stg]	
	// idc_name 으로 수신 받은 값 기준 properties 에 설정된 승인URL과 P_REQ_URL 이 같은지 비교
	// 승인URL은  https://manual.inicis.com 참조
	////////////////////////////////////////////////////////////////////////////

	if(P_STATUS.equals("00")) {
		
		/////////////////////////////////////////////////////////////////////////////
		///// 2. 상점 아이디 설정 :                                              ////
		/////    결제요청 페이지에서 사용한 MID값과 동일하게 세팅해야 함...      ////
		/////////////////////////////////////////////////////////////////////////////
		
		String P_MID = "hwmander66";
	
		/////////////////////////////////////////////////////////////////////////////
		//// 3. 승인요청 :                                                      ////
		//// 	승인요청 API url (P_REQ_URL) 리스트 는 properties 에 세팅하여 사용합니다.
		//// 	idc_name 으로 수신 받은 센터 네임을 properties 에서 확인하여 승인요청하시면 됩니다.
		/////////////////////////////////////////////////////////////////////////////
	
		P_REQ_URL = P_REQ_URL + "?P_TID=" + P_TID + "&P_MID=" + P_MID;
	
		try {
			URL reqUrl = new URL(P_REQ_URL);
			HttpURLConnection conn = (HttpURLConnection) reqUrl.openConnection();
			
			if (conn != null) {
				conn.setRequestMethod("POST");
				conn.setDefaultUseCaches(false);
				conn.setDoOutput(true);
				
				if (conn.getDoOutput()) {
					conn.getOutputStream().flush();
					conn.getOutputStream().close();
				}

				conn.connect();
				
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
					
				String[] values = new String(br.readLine()).split("&"); 
				for( int x = 0; x < values.length; x++ ) {
						  
					// 승인결과를 파싱값 잘라 hashmap에 저장
					int i = values[x].indexOf("=");
					String key1 = values[x].substring(0, i);
					String value1 = values[x].substring(i+1);
					map.put(key1, value1);
					  
				}
					
				br.close();
			}
		}catch(Exception e ) {
			e.printStackTrace();
		}  
	    
	} else {
		
		map.put("P_STATUS", P_STATUS);
		map.put("P_RMESG1", P_RMESG1);
        
	}
%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>현우의 컴퓨터 공방 - 결제완료</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
	<link rel="stylesheet" href="/resources/css/main.css">
	<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script type="text/javascript">
        $(function() {
        
            if("00" == $("#resultCode").val()) {
                
                var ajaxData = {
                        id : $("#moid").val()
                };
                    
                $.ajax({
                    type: "post",
                    url: "/order/inicisPayComplete.do",
                    data: ajaxData,
                    dataType: 'json',
                    success: function (data) {
                        
                        console.log(data);
                        
                        if(data == 2) {
                            alert("주문이 완료되었습니다.\n감사합니다.");
                            location.href = "/";
                        }else {
                            alert("결제 후 주문상태변경에 오류가 발생했습니다.\n 관리자에게 문의하세요.");
                        }
                    }
                });
            }
        
        });
    </script>
</head>
    <body class="wrap">
        <form name="" id="result" method="post" class="mt-5">
            <input type="hidden" id="resultCode" value="<%=map.get("P_STATUS")%>">
			<input type="hidden" id="moid" value="<%=map.get("P_OID")%>">
        </form>
    </body>
</html>