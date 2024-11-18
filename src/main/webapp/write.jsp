<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f0f2f5;
        color: #333;
        margin: 0;
        padding: 0;
    }
    .container {
        width: 100%;
        max-width: 700px;
        margin: 40px auto;
        padding: 30px;
        background-color: #ffffff;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }
    .header {
        text-align: center;
        font-size: 32px;
        font-weight: bold;
        color: #0055a5;
        margin-bottom: 25px;
    }
    .form-group {
        display: grid;
        grid-template-columns: 1fr;
        gap: 15px;
        margin-bottom: 20px;
    }
    .form-group label {
        font-weight: bold;
        color: #333;
    }
    .form-group input, .form-group textarea {
        padding: 8px 12px;
        font-size: 16px;
        border: none;
        border-bottom: 2px solid #ccc;
        background-color: transparent;
        width: 100%;
        box-sizing: border-box;
        transition: all 0.3s ease;
    }
    .form-group input:focus, .form-group textarea:focus {
        border-bottom: 2px solid #0055a5;
        outline: none;
    }
    .form-group textarea {
        height: 150px;
        resize: none;
    }
    .button {
        padding: 12px 0;
        background-color: #0055a5;
        color: white;
        border: none;
        border-radius: 30px;
        cursor: pointer;
        font-size: 16px;
        font-weight: bold;
        width: 100%;
        box-sizing: border-box;
        transition: background-color 0.3s ease;
    }
    .button:hover {
        background-color: #003f7f;
    }
</style>
</head>
<body>
    <div class="header">
        <h1>경소마고 취업상담 Q&N</h1>
    </div>
    
    <div class="container">
        <form method="post" action="writeAction.jsp">
            <div class="form-group">
                <label for="title">글 제목</label>
                <input type="text" id="title" name="title" placeholder="제목을 입력하세요" maxlength="50" required>
            </div>
            <div class="form-group">
                <label for="name">작성자</label>
                <input type="text" id="name" name="name" placeholder="작성자를 입력하세요" maxlength="20" required>
            </div>
            <div class="form-group">
                <label for="pw">비밀번호</label>
                <input type="password" id="pw" name="pw" placeholder="비밀번호를 입력하세요" maxlength="20" required>
            </div>
            <div class="form-group">
                <label for="content">글 내용</label>
                <textarea id="content" name="content" placeholder="글 내용을 입력하세요" maxlength="500" required></textarea>
            </div>
            <button type="submit" class="button">글쓰기</button>
        </form>
    </div>
    <%@ include file="footer.jsp"%>
</body>
</html>
