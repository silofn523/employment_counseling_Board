<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Board.BoardDAO" %>
<%@ page import="Board.Board" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f0f2f5;
    color: #333;
    margin: 0;
    padding: 0;
}
.container {
    max-width: 700px;
    margin: 40px auto;
    padding: 20px;
    background-color: #ffffff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
}
.header {
    text-align: center;
    padding: 20px 0;
    color: #0055a5;
    font-size: 32px;
    font-weight: bold;
}
.search-form {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin-bottom: 20px;
}
.search-form input[type="text"] {
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 30px; /* 둥근 모서리 */
    width: 40%;
    font-size: 16px;
}
.search-form button {
    padding: 12px 24px;
    background-color: #0055a5;
    color: white;
    border: none;
    border-radius: 30px;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}
.search-form button:hover {
    background-color: #003f7f;
}
.post-list {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 20px;
}

.post-item {
    padding: 20px;
    border-bottom: 1px solid #ddd;
    margin-bottom: 20px;
    border-radius: 0;
    box-shadow: none;
}
.post-item:hover {
    background-color: #f9f9f9;
}

.post-item a {
    color: #0055a5;
    font-size: 20px;
    font-weight: bold;
    text-decoration: none;
}
.post-item a:hover {
    text-decoration: underline;
}
.post-item .content-preview {
    color: #555;
    margin: 10px 0;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
.post-item .metadata {
    font-size: 14px;
    color: #888;
}
.pagination {
    text-align: center;
    margin: 20px 0;
}
.pagination a {
    padding: 8px 16px;
    background-color: #0055a5;
    color: white;
    margin: 0 5px;
    border-radius: 30px; /* 둥근 모서리 */
    text-decoration: none;
    transition: background-color 0.3s ease;
}
.pagination a:hover {
    background-color: #003f7f;
}
.write-btn {
    display: block;
    max-width: 150px;
    margin: 30px auto;
    padding: 10px 20px;
    text-align: center;
    background-color: #0055a5;
    color: white;
    border-radius: 30px; /* 둥근 모서리 */
    font-size: 16px;
    text-decoration: none;
    transition: background-color 0.3s ease;
}
.write-btn:hover {
    background-color: #003f7f;
}

</style>
</head>
<body>
	<%
	
	    int pageNumber = 1;
	    String searchBoard = request.getParameter("searchBoard") != null ? request.getParameter("searchBoard") : "";
	
	    if (request.getParameter("pageNumber") != null) {
	        pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	    }
	
	    BoardDAO DAO = new BoardDAO();
	    ArrayList<Board> list;
	
	    if (searchBoard.isEmpty()) {
	        list = DAO.getList(pageNumber);
	    } else {
	        list = DAO.searchBoard(searchBoard); 
	    }
	%>
	<div class="header">
        <h1>경소마고 취업상담 Q&N</h1>
    </div>
    
	<div class="container">
		<form action="bbs.jsp" method="get" class="search-form">
            <label for="searchBoard"></label>
            <input type="text" id="searchBoard" name="searchBoard" value="<%= searchBoard %>" placeholder="이름 혹은 제목으로 검색">
            <button type="submit">검색</button>
        </form>
        <br>
		<div class="search-form">
			<div class="post-list">
			    <% for(int i = 0; i < list.size(); i++) {
			            Board board = list.get(i);
			    %>
			        <div class="post-item">
			            <a href="view.jsp?id=<%= board.getId() %>"><%= board.getTitle() %></a><br/>
			            <p style="font-weight: bold; font-size: 1.1rem">작성자: <%= board.getName() %></p>
			            <p style="
			            	width: 200px; 
			            	display: block;
        					text-overflow: ellipsis;
        					overflow: hidden;
        					white-space: nowrap; 
        					font-weight: bold;"
        				><%= board.getContent() %></p><br/>
			            <p style="color: #858585; font-size: 0.9rem">작성일: <%= board.getCreateTime() %></p>
			        </div>
			    <% } %>
			</div>
			
		</div>
		<div class="pagination">
            <% if (pageNumber > 1) { %>
                <a href="bbs.jsp?pageNumber=<%= pageNumber - 1 %>">이전</a><br/>
            <% } %>
            <% if (DAO.nextPage(pageNumber)) { %>
                <a href="bbs.jsp?pageNumber=<%= pageNumber + 1 %>">다음</a><br/>
            <% } %>
     
        </div>
        <div class="paginationA">
        	<a href="write.jsp" class="write-btn" >글쓰기</a>
        </div>
	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>