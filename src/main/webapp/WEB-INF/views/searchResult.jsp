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
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
  <title>Result list</title>
  <script language="javascript">
    function DoPost(url,song){
      song.song.substr(0, song.song.length-1);
      console.log(1);

      $.post("/songCollection/"+url.toString()+"/songs",  JSON.stringify(song), function(data){
        console.log(444444);
        $.get("/songCollection/"+url.toString()+"/songs/"+data)
      }, 'json');
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
              <a href="javascript:DoPost(${map.idCollection}, {band:'${band}',name:'${map.song}'})">${fn:escapeXml(band)} </a>
          </li>

    </c:forEach>
      </ul>
  </c:if>

</ul>
</body>
</html>
