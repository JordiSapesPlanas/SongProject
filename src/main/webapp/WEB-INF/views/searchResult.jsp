<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: davidkaste
  Date: 23/02/15
  Time: 11:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>


</head>
<body>
<h2>band list</h2>


<c:if test="${not empty map.bands}">
    <ul>
        <c:forEach var="band" items="${map.bands}">
            <form method="POST" action="/songCollection/${map.idCollection}/songs">
                <li>
                    <table>
                        <tr>

                            <td>${band}<input type="hidden" name="band" value="${band}" />



                            <td> - ${map.song} <input type="hidden" name="name" value="${map.song}"/></td>
                            <td><input type="submit" value="add" /></td>
                        </tr>



                    </table>
                </li>

            </form>
        </c:forEach>
    </ul>
</c:if>
</body>
</html>
