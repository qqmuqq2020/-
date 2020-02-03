/****
 * created By 北大课工场 kgc
 * @param a
 * @param b
 * @param c
 * @param d
 */
var goodsId=1;
//加载百分比
function loadPercent(width,total,discountPrice,price){
    $('.ec_jinDu').width(width);
    $('.bfb').html(width);
    $('.sz').html(total);
    $('.x_jiaGe').html(discountPrice);
    $('.d_jiaGe').html(price);
}
//初始化加载
$(function () {
   loadGoodInfo();
});
function qgGoods() {
    var token=getCookie("token");
    $.ajax({
        url : ReqUrl.GoodsReqUrl()+"/sendQgGoodsMessage",
        type : "post",
        dataType : "json",
        data : {
            goodsId : goodsId,
            token : token
        },
        success: function(response, status, xhr){
            var success = response.success;
            alert(response.msg);
            // if(success){
            //     var goods=response.data;
            //     //{"id":"1","goodsImg":"images/pic1.jpg","goodsName":"苹果手机","price":56.7,"stock":100,"currentStock":100}
            //     var currentStock=goods.currentStock;
            //     var goodsName=goods.goodsName;
            //     var price=goods.price;
            //     var goodsImg=goods.goodsImg;
            //     var percent=(goods.stock-currentStock)*100/goods.stock;
            //     $("#goodsName").html(goodsName);
            //     $("#goodsImg").attr("src",goodsImg);
            //     loadPercent(percent+'%',currentStock,'￥'+price,'￥80');
            // }
        }
    });
};

window.alert=function (message) {
    dialog.show({
        'message':message,
        'isCountDown':true,
        'seconds':3,
    });
};
// dialog.show({
//     'logoType':1,
//     'message':'抢购成功',
//     'isCountDown':false,
// });



/*$(function() {
    $(".top-anNiu1").click(function() {
        $(".btn-show").show().siblings("div").hide()
    });
    $(".btn-show").click(function() {
        $(".bian_kuang-biaoDan").show()
    });
    $(".btn-qieHuan").click(function() {
        $(".bian_kuang-biaoDan").toggle().siblings("div").show();
    });


    $(".top-anNiu2").click(function() {
        $(".bian_kuang-biaoDan").hide().siblings("div").hide()
    })
});*/