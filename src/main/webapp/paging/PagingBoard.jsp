<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String uri = (String)request.getAttribute("uri");
%>
<div class="row mt-3">
    <div class="col">
        <ul class="pagination justify-content-center">
<%
	if(pageTemp !=1) {
%>
            <li class="page-item"><a class="page-link" 
            	href="<%= uri %>?pageNum=1">
                <i class='bi bi-skip-backward-fill'></i>
            </a></li>
            <li class="page-item"><a class="page-link" 
            	href="<%= uri %>?pageNum=<%= pageTemp-1 %>">
                <i class='bi bi-skip-start-fill'></i>
            </a></li>
<%
	}
	int countBlock = 1;
	while(countBlock <= blockPage && pageTemp <= countPages) {
		if(pageTemp == pageNum) {
%>
            <li class="page-item active"><a class="page-link"><%= pageTemp %></a></li>
<%
		}
		else {
%>     
            
            <li class="page-item"><a class="page-link" 
            	href="<%= uri %>?pageNum=<%= pageTemp %>"><%= pageTemp %></a></li>
<%
		}
		pageTemp++;
		countBlock++;
	}
	if(pageTemp <= countPages) {
%>
            <li class="page-item"><a class="page-link" 
            	href="<%= uri %>?pageNum=<%= pageTemp %>">
                <i class='bi bi-skip-end-fill'></i>
            </a></li>
            <li class="page-item"><a class="page-link" 
            	href="<%= uri %>?pageNum=<%= countPages %>">
                <i class='bi bi-skip-forward-fill'></i>
            </a></li>
<%
	}
%>
        </ul>
    </div>
</div>