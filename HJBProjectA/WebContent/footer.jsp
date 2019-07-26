<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<footer
	style="position: relative; padding-left: 10%; padding-right: 10%; background-color: rgba(255, 255, 255, 0.9);">
	<hr>
	<p>게시판을 구현한 사이트입니다.</p>
	<p>팝업창을 허용하셔야 메일을 보내실 수 있습니다.</p>
	<p class="float-right">&copy; Company 2017-2019</p>
	<p>
		<a href="javascript:sendmail()">Mail to JinBum</a>
	</p>
	<p>&nbsp;</p>
</footer>
<script>
function sendmail(){
var width=768;
var height=384;
var url='mailForm.html';
var name='popup';
var left = (screen.width-width)/2;

var top = (screen.height-height)/2;

var popup = window.open(url, name,'left='+left+',top='+top+',width='+width+',height='+height);
}
</script>
