<%@page import="board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	BoardDAO dao = new BoardDAO();

	Map<String, Object> param = new HashMap<String, Object>();
	
	String srchField = request.getParameter("srchField");
	String srchWord = request.getParameter("srchWord");
	
	if(srchWord !=null) {
		param.put("srchField", srchField);
		param.put("srchWord", srchWord);
	}		
	
	List<BoardDTO> boardLists = dao.selectList(param);
	dao.close();
%>
<%@ include file="./commons/header.jsp" %>
<body>
<div class="container">
    <!-- Top영역 -->
    <%@ include file="./commons/top.jsp" %>
    <!-- Body영역 -->
    <div class="row">
        <!-- Left메뉴영역 -->
        <%@ include file="./commons/left.jsp" %>
        <!-- Contents영역 -->
        <div class="col-9 pt-3">
            <h3>게시판 목록 - <small>자유게시판</small></h3>
            <!-- 검색 -->
            <div class="row">
                <form method="get">
                    <div class="input-group ms-auto" style="width: 400px;">
                        <select name="srchField" class="form-control">
                            <option value="title">제목</option>
                            <option value="content">내용</option>
                            <option value="id">작성자</option>
                        </select>
                        <input type="text" name="srchWord" class="form-control" placeholder="Search" style="width: 200px;">
                        <button class="btn btn-success" type="submit">
                            <i class="bi-search" style="font-size: 1rem; color: white;"></i>
                        </button>
                    </div>
                </form>
            </div>
            <!-- 게시판 리스트 -->
            <div class="row mt-3 mx-1">
                <table class="table table-bordered table-hover table-striped">
                <thead>
                    <tr class="text-center">
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>조회수</th>
                        <th>작성일</th>
                    </tr>
                </thead>
                <tbody>

<%
			if(boardLists.isEmpty()) {
%>
					<tr>
						<td colspan="5" align="center">등록된 게시물이 없습니다.</td>
					</tr>
<%
			}
			else {
				for(BoardDTO dto : boardLists) {						
%>
                    <tr class="text-center">
                        <td><%= dto.getNum() %></td>
                        <td class="text-start"><a href="viewT.jsp?num=<%= dto.getNum() %>">
                        	<%= dto.getTitle() %></a></td>
                        <td><%= dto.getId() %></td>
                        <td><%= dto.getVisitcount() %></td>
                        <td><%= dto.getPostdate() %></td>
                    </tr>                   
<%
				}
			}
%>
                </tbody>
                </table>
            </div>
            <!-- 각종버튼 -->
            <div class="row">
                <div class="col d-flex justify-content-end">
                    <button type="button" class="btn btn-primary" onclick="location.href='writeT.jsp';">글쓰기</button>
                </div>
            </div>
            <!-- 페이지 번호 -->
            <div class="row mt-3">
                <div class="col">
                    <ul class="pagination justify-content-center">
                        <li class="page-item"><a class="page-link" href="#">
                            <i class='bi bi-skip-backward-fill'></i>
                        </a></li>
                        <li class="page-item"><a class="page-link" href="#">
                            <i class='bi bi-skip-start-fill'></i>
                        </a></li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item"><a class="page-link" href="#">
                            <i class='bi bi-skip-end-fill'></i>
                        </a></li>
                        <li class="page-item"><a class="page-link" href="#">
                            <i class='bi bi-skip-forward-fill'></i>
                        </a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- Copyright영역 -->
    <%@ include file="./commons/copyright.jsp" %>
</div>
</body>
</html>