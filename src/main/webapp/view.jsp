<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="Board.Board" %>
<%@ page import="Board.BoardDAO" %>
<%@ page import="Comment.Comment" %>
<%@ page import="Comment.CommentDAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 보기</title>
<style>
    /* 기본 스타일 설정 */
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, sans-serif;
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
    .post-view {
        background-color: white;
        padding: 20px;
        border-bottom: 2px solid #ddd;
        margin-bottom: 20px;
    }
    .post-view h2 {
        color: #2d3436;
        font-size: 24px;
    }
    .post-view p {
        font-size: 1rem;
        color: #636e72;
    }
    .post-view-input, .comment-section h3 {
        margin-top: 20px;
        color: #2d3436;
    }
    .comment-section h3 {
        font-size: 20px;
        color: #0055a5;
        border-bottom: 2px solid #ddd;
        padding-bottom: 5px;
        margin-top: 20px;
    }
    .comment-form {
        background-color: #ffffff;;
        border-radius: 8px;
        padding: 15px;
        margin-bottom: 20px;
    }
    .comment-form, .comment-form-2 {
        display: flex;
        flex-direction: column;
        gap: 8px; /* 간격 좁힘 */
        margin-bottom: 20px;
    }
    .comment-form input, .comment-form textarea, .comment-form-2 input {
        padding: 8px; /* 인풋 칸 줄임 */
        border: 1px solid #ccc;
        border-radius: 16px; /* 더 부드러운 둥근 모서리 */
        font-size: 14px; /* 작은 폰트 크기 */
        outline: none;
    }
    .comment-form button, .comment-form-2 button, .b a , button{
        padding: 6px 12px; /* 버튼 크기 줄임 */
        background-color: #0055a5;
        color: white;
        border: none;
        border-radius: 30px; /* 버튼도 둥글게 */
        font-size: 12px; /* 버튼 폰트 크기 줄임 */
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .comment-form button:hover, .comment-form-2 button:hover, .button:hover {
        background-color: #003f7f;
    }
    .button {
        display: inline-block;
        margin-top: 10px;
        padding: 12px 20px;
        text-decoration: none;
        text-align: center;
    }

    /* 댓글 디자인 (밑줄만 추가) */
    .comment {
        background-color: #f9f9f9;
        border-radius: 8px;
        padding: 15px;
        margin-bottom: 20px;
        padding-bottom: 23px;
        padding-top: 23px;
    }
    .comment:last-child {
        border-bottom: none;
    }
    .comment p.date {
        font-size: 13px;
        color: #888;
        margin-top: 5px;
    }
    .comment p {
        font-size: 15px; /* 댓글 글씨 크기 줄임 */
        color: #2d3436;
        margin: 0;
    }
    .delete-button {
        padding: 6px 12px;
        background-color: #d63031;
        border-radius: 20px;
        font-size: 12px;
        color: #fff;
        float: right;
        margin-top: 10px;
        transition: background-color 0.3s;
    }
    .delete-button:hover {
        background-color: #c0392b;
    }
    
</style>
<script>
    // 게시글 수정 시 비밀번호 입력 받기
    function modifyPost(boardId) {
        const pw = prompt("수정 비밀번호를 입력하세요:");
        if (pw) {
            const form = document.createElement("form");
            form.method = "post";
            form.action = "verifyPassword.jsp";

            const idInput = document.createElement("input");
            idInput.type = "hidden";
            idInput.name = "id";
            idInput.value = boardId;
            form.appendChild(idInput);

            const pwInput = document.createElement("input");
            pwInput.type = "hidden";
            pwInput.name = "pw";
            pwInput.value = pw;
            form.appendChild(pwInput);

            document.body.appendChild(form);
            form.submit();
        }
    }

    // 게시글 삭제 시 비밀번호 입력 받기
    function deletePost(boardId) {
        const pw = prompt("삭제 비밀번호를 입력하세요:");
        if (pw) {
            const form = document.createElement("form");
            form.method = "post";
            form.action = "verifyPasswordForDelete.jsp";

            const idInput = document.createElement("input");
            idInput.type = "hidden";
            idInput.name = "id";
            idInput.value = boardId;
            form.appendChild(idInput);

            const pwInput = document.createElement("input");
            pwInput.type = "hidden";
            pwInput.name = "pw";
            pwInput.value = pw;
            form.appendChild(pwInput);

            document.body.appendChild(form);
            form.submit();
        }
    }

    // 댓글 삭제 시 비밀번호 입력 받기
    function deleteComment(commentId) {
        const pw = prompt("댓글 삭제 비밀번호를 입력하세요:");
        if (pw) {
            const form = document.createElement("form");
            form.method = "post";
            form.action = "verifyPasswordForCommentDelete.jsp";

            const idInput = document.createElement("input");
            idInput.type = "hidden";
            idInput.name = "id";
            idInput.value = commentId;
            form.appendChild(idInput);

            const pwInput = document.createElement("input");
            pwInput.type = "hidden";
            pwInput.name = "pw";
            pwInput.value = pw;
            form.appendChild(pwInput);

            document.body.appendChild(form);
            form.submit();
        }
    }
</script>
</head>
<body>
    <div class="header">
        <h1>경소마고 취업상담 Q&N</h1>
    </div>
    <div class="container">
        <div class="post-view">
            <%
                int id = 0;
                if(request.getParameter("id") != null) {
                    id = Integer.parseInt(request.getParameter("id"));
                }
                if(id == 0) {
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('유효하지 않은 글입니다')");
                    script.println("location.href = 'bbs.jsp'");
                    script.println("</script>");
                    return;
                }
                Board board = new BoardDAO().getBoard(id);
            %>
            <h2><%= board.getTitle() %></h2>
            <p><strong>작성자:</strong> <%= board.getName() %></p>
            <p><%= board.getContent() %></p>
            <p style="color: #b2bec3;">작성일: <%= board.getCreateTime() %></p>

            <div class="post-view-input">
                <button onclick="modifyPost(<%= board.getId() %>)">게시글 수정</button>
                <button onclick="deletePost(<%= board.getId() %>)" class="delete-button">게시글 삭제</button>
            </div>
        </div>

        <div class="b">
        	<a href="bbs.jsp" class="button">목록</a>
        </div>

        <div class="comment-section">
            <h3>댓글 작성</h3>
            <form class="comment-form" action="view.jsp?id=<%= id %>" method="post">
                <input type="hidden" name="boardId" value="<%= id %>">
                <input type="text" name="title" placeholder="내용을 입력하세요" required >
                <input type="password" name="pw" placeholder="비밀번호" required>
                <button type="submit">댓글 작성</button>
            </form>
            <h3>댓글</h3>
            <%
                CommentDAO commentDAO = new CommentDAO();
                if (request.getMethod().equalsIgnoreCase("POST")) {
                    String title = request.getParameter("title");
                    String pw = request.getParameter("pw");
                    Comment newComment = new Comment();
                    newComment.setBoard_id(id);
                    newComment.setTitle(title);
                    newComment.setPw(pw);
                    commentDAO.addComment(newComment);
                    response.sendRedirect("view.jsp?id=" + id);
                }
                ArrayList<Comment> comments = commentDAO.getComments(id);
                for (Comment comment : comments) {
            %>
            <div class="comment">
                <p><%= comment.getTitle() %></p>
                <p style="color: #b2bec3;">작성일: <%= comment.getCreateTime() %></p>
                <button onclick="deleteComment(<%= comment.getId() %>)" class="delete-button">댓글 삭제</button>
            </div>
            <%
                }
            %>
        </div>
    </div>
    <%@ include file="footer.jsp"%>
</body>
</html>
