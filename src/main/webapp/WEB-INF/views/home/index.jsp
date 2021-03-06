<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/top.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>西安美食推荐</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="/favicon.ico">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <%@ include file="../common/headcss.jsp"%>
    <%@ include file="../common/utiljs.jsp"%>
</head>
<style>
    .search-input input{
        border-radius: 30px;
        font-size: 12px;
        padding:0px 20px;
        border: none;
        background:#F2F2F2;
        text-align: center;
        color: #666666;
    }
    .searchbar .icon-search{
        left: 10px;
        font-weight: bold;
        top: 55%;
        color: #666666;
    }
    .search-input input::-webkit-input-placeholder{
        color:#666666;
    }
    .search-input input::-moz-placeholder{   /* Mozilla Firefox 19+ */
        color:#666666;
    }
    .search-input input:-moz-placeholder{    /* Mozilla Firefox 4 to 18 */
        color:#666666;
    }
    .search-input input:-ms-input-placeholder{  /* Internet Explorer 10-11 */
        color:#666666;
    }
    .nowBuy{
        background:#FEE101 !important;
        line-height: 1.6rem !important;
        height: 1.6rem !important;
    }
    .external{
        height: 180px;
    }
</style>
<body>
<div class="page-group">
    <div class="page page-current">
        <div class="content infinite-scroll" data-distance="30">
            <div class="row" style="padding:5px;">
                <div class="col-100">
                    <div class="searchbar">
                        <div class="search-input">
                            <label class="icon icon-search" for="search"></label>
                            <input type="search" id='search' name="keywords" placeholder='输入关键字...'/>
                        </div>
                    </div>
                </div>
            </div>
            <div id="goods">

            </div>
            <h5>&nbsp;</h5>
        </div>
        <%@ include file="../common/nav.jsp"%>
    </div>
</div>
</body>
<%@ include file="../common/headjs.jsp"%>
<script type="text/javascript">

    search(true);

    var page_currentPage = 1;

    function search(flag){
        $.ajax({
            type: "POST",
            url: '<%=request.getContextPath()%>/home/search',
            data:{
                "page_currentPage":page_currentPage,
                "keywords":$("#search").val()
            },
            async: false,
            dataType:'json',
            cache: false,
            beforeSend:function(){
                $.showPreloader();
                //$("#shops").html('');
            },
            success: function(data){
                pageData = data.page;
                console.log(pageData)
                var list = data.page.data;
                var html = "";
                $.each(list,function(index,value){
                    html += `
    					<div class="row" style="padding:5px;">
    					<div class="col-100">
    				<div class="card demo-card-header-pic proBox">
    				    <a class="external" href="<%=request.getContextPath()%>/goods/info?GOODS_ID=`+value.GOODS_ID+`"><div valign="bottom" class="card-header color-white no-border no-padding">
    				      <img class='card-cover proImage' style="width:100%;" height="200px" src="<%=request.getContextPath()%>/file/image?FILENAME=`+value.FILEPATH+`" alt="">
    				    </a>
                     </div>
    				    <div class="card-footer proContentBox">
	  				      <span class="bigFontSize">`;

                    if(value.SHOPNAME.length>7){
                        var shoplength=value.SHOPNAME.slice(0,5)+"..";
                        html +=shoplength;
                    }else{
                        html +=value.SHOPNAME;
                    }
                    html += `</span><span class="bigFontSize">`
                    if(value.SHOPADDRESS.length>7){
                        var shoplength1=value.SHOPADDRESS.slice(0,5)+"..";
                        html += shoplength1;
                    }else{
                        html += value.SHOPADDRESS;
                    }

                    html += `</span>
	  				    </div>
    				    <div class="card-content proContentBox">
    				      <div class="card-content-inner" style="padding:0">
    				        <p><span style="margin-right:10px;padding:3px 10px;background:#FFCC01;"class="smFontSize myColor">[`+value.PROVIDE+`]提供</span>`+value.GOODSDESC+`</p>
    				      </div>
    				    </div>

    				    <div class="card-footer proContentBox">
  				      <span><font style="color:#F40A0B;" class="bigFontSize">`+value.SELLMONEY+`元</font></span>
  				      <span><a href="<%=request.getContextPath()%>/goods/info?GOODS_ID=`+value.GOODS_ID+`" class="external button button-fill nowBuy">立即购买</a></span>
  				    </div>
  				  <div class="card-footer proContentBox">
			      <span class="delete deleteColor">原价 `+value.ORIGINALMONEY+`元</span>
			      <span>已售`+value.VIRTUALSELLED+`份</span>
			    </div>
    				  </div>
    				  </div>
    				  </div>
    					`;
                })
                if(flag){
                    $("#goods").html(html);
                }else{
                    $("#goods").append(html);
                }

                setTimeout(function(){$.hidePreloader();if(flag && '${showNotice}' == 'yes'){searchUnRead();}},1000);

                loading = false;
            },
            error:function(){

            }
        });
    }

</script>
<script type="text/javascript">

    var loading = false;
    console.log($);

    $.init();

    $(document).on('infinite',function(){

        if(parseInt(pageData.currentPage) >= parseInt(pageData.totalPage)){
            $.toast("数据已经到底了");
            return;
        }

        page_currentPage++;

        // 如果正在加载，则退出
        if (loading) return;

        // 设置flag
        loading = true;

        // 模拟1s的加载过程
        setTimeout(function() {
            // 重置加载flag

            search(false);

            //容器发生改变,如果是js滚动，需要刷新滚动
            $.refreshScroller();
        }, 500);
    });
</script>

<script type="text/javascript">
    $("#search").blur(function(){

        page_currentPage = 1;

        search(true);

    });

    function searchUnRead(){
        $.ajax({
            type: "POST",
            url: '<%=request.getContextPath()%>/notice/listAllUnRead',
            data:{

            },
            async: false,
            dataType:'json',
            cache: false,
            beforeSend:function(){

            },
            success: function(data){
                showUnRead(data,0);
            },
            error:function(){

            }
        });
    }

    function showUnRead(data,index){
        if(index >= data.length){
            return;
        }
        var notice = data[index];

        $.modal({
            title:  '系统消息通知',
            text: notice.NOTICECONTENT,
            buttons: [
                {
                    text: '确定',
                    onClick: function() {
                        saveNoticeRecord(notice.NOTICE_ID);setTimeout(function(){showUnRead(data,(index+1))},3000);
                    }
                },
                {
                    text: '取消',
                    onClick: function() {
                        setTimeout(function(){showUnRead(data,(index+1))},3000);
                    }
                }
            ]
        });
    }

    function saveNoticeRecord(id){
        $.ajax({
            type: "POST",
            url: '<%=request.getContextPath()%>/notice/saveRecord',
            data:{
                "NOTICE_ID":id
            },
            async: false,
            dataType:'json',
            cache: false,
            beforeSend:function(){

            },
            success: function(data){

            },
            error:function(){

            }
        });
    }
</script>
</html>