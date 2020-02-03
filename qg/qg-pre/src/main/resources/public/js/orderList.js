$(function () {
    loadOrders();
});
function loadOrders() {
    $.ajax({
        async: false,
        url: ReqUrl.OrdeReqUrl() + 'queryOrderList',
        type: 'post',
        dataType: 'json',
        data: {
            id: "1",
            token: getCookie("token")
        },
        success: function (result) {
            if (result.success == "true") {
                var list = result.data;
                var $contentBody=$("#contentBody");
                $contentBody.html("");
                for (var i = 0; i < list.length; i++) {
                    var $conDiv = $("<div class=\"con\"></div>");
                    var $orderNoDiv = $("<div class=\"dingDan\" ></div>");
                    var $goodsImgDiv = $("<div class=\"shangPin\" ><img src=\"img/daisen.png\"/></div>");
                    var $amountDiv = $("<div class=\"jinE\" >1699.00</div>");
                    var $statusDiv = $("<div class=\"zhiFu\" >支付失败</div>");
                    var $operatorDiv = $("<div class=\"caoZuo\" >去支付</div>");

                    $orderNoDiv.html(list[i].orderNo);
                    $goodsImgDiv.html("<img src='" + list[i].goodsImg + "' width='100px;' height='100px'>");
                    $amountDiv.html(list[i].amount);
                    $statusDiv.html(list[i].status == 1 ? "支付成功" : (list[i].status == 0?"待支付":"支付失败"));
                    $operatorDiv.html(list[i].status == 0 ?"<button id='" + list[i].orderNo +
                        "' class='btn_pay'"+"onclick=toPay();>去支付</button>":"———");
                    $conDiv.append($orderNoDiv);
                    $conDiv.append($goodsImgDiv);
                    $conDiv.append($amountDiv);
                    $conDiv.append($statusDiv);
                    $conDiv.append($operatorDiv);
                    $contentBody.append($conDiv);
                }
                $('.btn_pay').bind('click', toPay);
            } else {
                if (result.errorCode == "0002") {
                    alert({"title": "提示", "content": "加载失败"});
                } else if (result.errorCode == "0001") {
                    window.location.href = "login.html";
                }
            }
            $('.default-btn').bind('click', toPay);
        },
        error: function () {
            alert({"title": "提示", "content": "系统异常"});
        }
    })
};

function toPay(e) {
    var orderNoval = this.id;
    $.ajax({
        url: ReqUrl.ToAliPayReqUrl()+"prepay/"+orderNoval,
        type: "get",
        dataType: "json",
        success: function (response, status, xhr) {
            var flag = response.success;
            var data = response.data;
            if (!flag) {
                alert({"title": "提示", "content": message});
            } else {
                window.location.href = "/orderDetail.html?orderNo="
                    + data.orderNo + "&goodsId="
                    + data.goodsId + "&count="
                    + data.count + "&payAmount="
                    + data.payAmount;
            }
        }
    });
}