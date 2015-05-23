<%--
  Created by IntelliJ IDEA.
  User: debian-jordi
  Date: 4/05/15
  Time: 16:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
    <title></title>
</head>
<body>


 <form:form method="POST" action="/songCollection" modelAttribute="SongCollection">
    <table>
        <tr>
            <td><form:label path="email">Email</form:label></td>

            <td><form:input path="email"/> <i><form:errors path="email"></form:errors></i></td>
        </tr>
        <tr>
            <td><form:label path="name">Name</form:label></td>
            <td><form:input path="name"/> <i><form:errors path="name"></form:errors></i></td>
        </tr>



    </table>
     <input type="submit" value="Submit" />
</form:form>
</body>
</html>
