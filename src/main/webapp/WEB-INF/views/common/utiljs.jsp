<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<script type="text/javascript">
	function getDate24Hours(){
		//获取当前时间
		var date = new Date();
		var seperator1 = "-";
		var seperator2 = ":";
		var month = date.getMonth() + 1;
		var strDate = date.getDate();
		if (month >= 1 && month <= 9) {
			month = "0" + month;
		}
		if (strDate >= 0 && strDate <= 9) {
			strDate = "0" + strDate;
		}
		var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
				+ " " + date.getHours() + seperator2 + date.getMinutes()
				+ seperator2 + date.getSeconds();
		return currentdate;
	}

	function TimeDown(id, endDateStr) {
	    //结束时间
	    var endDate = new Date(endDateStr);
	    //当前时间
	    var nowDate = new Date();
	    //相差的总秒数
	    var totalSeconds = parseInt((endDate - nowDate) / 1000);
	    //天数
	    var days = Math.floor(totalSeconds / (60 * 60 * 24));
	    //取模（余数）
	    var modulo = totalSeconds % (60 * 60 * 24);
	    //小时数
	    var hours = Math.floor(modulo / (60 * 60));
	    modulo = modulo % (60 * 60);
	    //分钟
	    var minutes = Math.floor(modulo / 60);
	    //秒
	    var seconds = modulo % 60;
	    
	    if(document.getElementById(id) != null){
		    //输出到页面
		    document.getElementById(id).innerHTML = "<span>"+ days + "</span>天<span>" + hours + "</span> <span>" + minutes + "</span> <span>" + seconds +"</span>";
		    //延迟一秒执行自己
		    
		    if(days<0 || hours<0 || minutes<0 || seconds <0){
		    	//document.getElementById(id+"_left").style.display = 'none';
		    	document.getElementById(id+"_right").style.display = 'none';
		    	return;
		    }
	    }
	    setTimeout(function () {
	        TimeDown(id, endDateStr);
	    }, 1000)
	}
</script>

