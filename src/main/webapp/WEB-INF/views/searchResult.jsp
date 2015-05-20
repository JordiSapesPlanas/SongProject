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
  <title>Result list</title>
  <script language="javascript">
    function DoPost(url,song){
      $.post("/songCollection/"+url+"/songs", song);
    }
  </script>
</head>
<body>
<h2>band list</h2>
<ul>
  <c:if test="${not empty map.bands}">
    <ul>
    <c:forEach var="band" items="${map.bands}">

          <li>
              <a href="javascript:DoPost(${map.idCollection}, {band:${fn:escapeXml(band)},name:${fn:escapeXml(map.song)}})">${fn:escapeXml(band)} </a>
          </li>

    </c:forEach>
      </ul>
  </c:if>

</ul>
</body>
</html>
