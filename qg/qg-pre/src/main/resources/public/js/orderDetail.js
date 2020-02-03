/***
 * created by 北大课工场
 * 加载订单详细信息
 * @param number
 * @param price
 */
$(function() {
    var orderNo = GetQueryString("orderNo");
    var goodsId = GetQueryString("goodsId");
    var count = GetQueryString("count");
    var payAmount = GetQueryString("payAmount");
    $('.price').html(payAmount);
    $('.number').html(orderNo);
    $('#orderNo').val(orderNo);
    $('#goodsId').val(goodsId);
    $('#payAmount').val(payAmount);
    $("input[name='payType']").click(function () {
        var value=$(this).val();
    });
    //立即支付点击事件
    $("#submitBtnBank").click(function(){
        var flag = $("input[name='payType']:checked").val();
        var orderNo=$('#orderNo').val();
        var goodsId= $('#goodsId').val();
        var payAmount= $('#payAmount').val();
        if(null == flag){
            alert("请选择支付方式！");
        }else if(1==flag){ //支付宝支付
            window.open(ReqUrl.ToAliPayReqUrl()+"pay?WIDout_trade_no="+orderNo+"&WIDsubject="+goodsId+"&WIDtotal_amount="+payAmount);
            $(".box_kouKuan").show();
        }else if(2 == flag){ //微信支付
            $.ajax({
                url: ReqUrl.ToWxPayUrl() + "wxpay/createqccode/" + orderNo,
                method: "get",
                success: function (data) {
                    //先清空qrcodediv中的内容，否则会叠加内容
                    $("#qrcode").html("");
                    $(".box_wx").show();
                    // new QRCode(document.getElementById('qrcode'),data.data.codeUrl,100,100);
                    var qrcode = new QRCode('qrcode', {
                        text: data.data.codeUrl,
                        width: 150,
                        height: 150,
                        colorDark : '#000000',
                        colorLight : '#ffffff',
                        correctLevel : QRCode.CorrectLevel.H
                    });
                }
            });
            function queryOrder(){
                $.ajax({
                    url: ReqUrl.ToWxPayUrl() + "wxpay/queryorderstatus/" + orderNo,
                    method: "get",
                    success: function (result) {
                        if(result.success == 'true'){
                            var orderStatus = result.data.status;
                            if(orderStatus == 1){
                                window.location.href = "success.html?orderNo=" + orderNo;
                            }
                        }
                    }
                });
            }
            setInterval(queryOrder, 5000);
        }
    });
});

//支付成功事件
function paySuccess(){
    window.location.href = "/index.html";
}
function payFail(){
    $(".box_kouKuan").hide();
}
//弹出窗口关闭
function closeWindow(){
    CloseDiv("showdiv","bgdiv");
}
//支付提示
function payNotice() {
  $(".box_kouKuan").show();
}
