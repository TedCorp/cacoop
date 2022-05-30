<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script>window.jQuery || document.write('<script src="${contextPath}/resources/js/jquery-2.2.1.min.js"><\/script>')</script>
<%-- <script src="${contextPath}/resources/js/read_allItems_search_by_category_example1.js"></script> --%>


<script>
/**
 * 아래 예제는 인터넷 브라우저의 콘솔 창에서 실행해볼 수 있습니다.
 * 크롬 브라우저에서 테스트되었습니다.
 *
 * 토큰은 manual.md 파일의 JWT 인증 섹션에 있는 방식으로 발급받을 수 있으며,
 * 이 예제 코드 하단부에 있는 client.setRequestHeader("Authorizaiton", "Bearer YOUR_TOKEN"); 코드의
 * YOUR_TOKEN 부분에 발급받은 토큰을 넣어주시면 됩니다.
 */

/**
 * 이 예제는 allItems 쿼리로 검색을 진행할 수 있도록 합니다.
 *
 * ----------
 *
 * 입력한 카테고리 코드에 대해서 해당 카테고리에 해당하는 판매중인 상품을 모두 불러옵니다.
 * 
 * 불러오는 상품 정보:
 *  - 오너클랜 상품코드(key)
 *  - 상품명(name)
 *  - 오너클랜 판매가(price)
 *  - 오너클랜 가격 정책(pricePolicy)
 *  - 소비자 준수가 제품의 경우 소비자 준수가격(fixedPrice)
 *  - 상품 상태(status)
 */

/**
 * 쿼리 1번에 가져올 상품 정보의 개수. 최대 1000.
 */
var countPerQuery = 1000;

/**
 * 상품을 조회할 카테고리의 key입니다.
 */
var category = "50000108";

/**
 * 조회 결과입니다.
 */
var itemData = [];

function get(first, after) {
    var client = new XMLHttpRequest();
    
    //쿼리
    var endpoint = `${endpoint}`;
    var query = `${query}`;
	var token = `${token}`;
    
    client.open("GET", endpoint + encodeURIComponent(query), true);
    client.setRequestHeader("Authorization", "Bearer " + token);
    client.onreadystatechange = function (aEvt) {
        if (client.readyState === 4) {
            if (client.status === 200) {
                var response = JSON.parse(client.responseText);
                if (response.errors) {
                    // API 서버 응답이 정상이지만 API 에러가 있다면 에러를 발생시킵니다.
                    throw new Error(JSON.stringify(response.errors));
                } else {
                    // 불러온 데이터를 콘솔에 기록하려면 다음 3줄을 주석 해제합니다.
                    //for (var i = 0; i < response.data.allItems.edges.length; i++) {
                    //    console.log(JSON.stringify(response.data.allItems.edges[i].node));
                    //}
                	
                	console.log(response);

                    // API 서버 응답도 정상이고, API 에러도 없다면 반환된 데이터를 저장합니다.
                    for (var i = 0; i < response.data.allItems.edges.length; i++) {
                        itemData.push(response.data.allItems.edges[i].node);
                    }

                    if (response.data.allItems.pageInfo.hasNextPage) {
                        // 만약 다음 데이터가 더 있다면 추가로 더 불러옵니다.
                        
                        console.log("has next : " + response.data.allItems.pageInfo.hasNextPage);
                        console.log("end cursor : " + response.data.allItems.pageInfo.endCursor);
                        console.log("response : " + response);
                        console.log("response data : " + response.data);
                        
                        
                        console.log("data>>>>>>>>>>>>>>>>>>>>>>>>>>>>> : ");
                        console.info(response.data);
                        
                        console.log("response>>>>>>>>>>>>>>>>>>>>>>>>>>>>> : ");
                        console.info(response);
                        console.log("end>>>>>>>>>>>>>>>>>>>>>>>>>>>>> : ");
                        
                        
                        get(countPerQuery, response.data.allItems.pageInfo.endCursor);
                    } else {
                        // 다음 데이터가 없다면 불러온 상품 데이터의 개수를 콘솔에 씁니다.
                        console.log(itemData.length);
                    }
                }
            } else {
                // API 서버 응답이 정상이 아닌 경우 에러와 HTTP status code를 담은 에러를 발생시킵니다.
                throw new Error(client.status.toString() + ", " + client.responseText);
            }
        }
    };

    client.send(null);
}

get(countPerQuery, "0");

</script>