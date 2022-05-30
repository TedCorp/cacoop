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

    var readQuery = `
    query {
        allItems(dateFrom: 0, category: "${category}", first: ${first}, after: "${after}", status: available) {
            pageInfo {
                hasNextPage
                hasPreviousPage
                startCursor
                endCursor
            }
            edges {
                cursor
                node {
                    key
                    name
                    price
                    pricePolicy
                    fixedPrice
                    status
                }
            }
        }
    }
    `;

    //client.open("GET", "https://api-sandbox.ownerclan.com/v1/graphql?query=%0A%09%09%09query%20%7B%0A%20%20%20%20%20%20%20%20allItems(dateFrom%3A%200%2C%20category%3A%20%2250000108%22%2C%20first%3A%201000%2C%20after%3A%20%220%22%2C%20status%3A%20available)%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20pageInfo%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20hasNextPage%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20hasPreviousPage%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20startCursor%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20endCursor%0A%20%20%20%20%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20%20%20%20%20edges%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20cursor%2C%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20node%20%7B%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20key%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20name%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20price%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20pricePolicy%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20fixedPrice%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20status%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%20%20%20%20%7D%0A%20%20%20%20%7D%0A%09%09", true);
    client.open("GET", "http://api-sandbox.ownerclan.com/v1/graphql?query=" + encodeURIComponent(readQuery), true);
    client.setRequestHeader("Authorization", "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZXMiOlsiaXRlbTpyZWFkIiwicHJvZHVjdDpyZWFkIiwiY2F0ZWdvcnk6cmVhZCIsIm9yZGVyOmFsbCIsInRyYW5zYWN0aW9uOnJlYWQiLCJjdXN0b21lclNlcnZpY2U6cmVhZCJdLCJzdWIiOiJpaWJzMDAxNyIsInNlcnZpY2UiOiJvd25lcmNsYW4iLCJ1c2VyVHlwZSI6InNlbGxlciIsImlhdCI6MTU4Nzk1Nzg4MCwiZXhwIjoxNTkwNTQ5ODgwfQ.06MixU_clQgp14WfghL6IRg-fNHogskOZeYgubMWLr4");
    console.log("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZXMiOlsiaXRlbTpyZWFkIiwicHJvZHVjdDpyZWFkIiwiY2F0ZWdvcnk6cmVhZCIsIm9yZGVyOmFsbCIsInRyYW5zYWN0aW9uOnJlYWQiLCJjdXN0b21lclNlcnZpY2U6cmVhZCJdLCJzdWIiOiJpaWJzMDAxNyIsInNlcnZpY2UiOiJvd25lcmNsYW4iLCJ1c2VyVHlwZSI6InNlbGxlciIsImlhdCI6MTU4Nzk1Nzg4MCwiZXhwIjoxNTkwNTQ5ODgwfQ.06MixU_clQgp14WfghL6IRg-fNHogskOZeYgubMWLr4");
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